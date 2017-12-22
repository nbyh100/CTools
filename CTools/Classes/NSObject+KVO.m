//
//  NSObject+KVO.m
//  CTools
//
//  Created by 张九州 on 2017/12/21.
//

#import "NSObject+KVO.h"
#import <objc/runtime.h>

@interface CKVOObserver : NSObject

@property (nonatomic, copy) CKVOHandler handler;

- (id)initWithHandler:(CKVOHandler)handler;

@end

@implementation CKVOObserver

- (id)initWithHandler:(CKVOHandler)handler {
    self = [super init];
    if (self) {
        self.handler = handler;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if (self.handler) {
        BOOL isPrior = [[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue];
        if (isPrior) {
            return;
        }

        id oldVal = [change objectForKey:NSKeyValueChangeOldKey];
        if (oldVal == [NSNull null]) {
            oldVal = nil;
        }

        id newVal = [change objectForKey:NSKeyValueChangeNewKey];
        if (newVal == [NSNull null]) {
            newVal = nil;
        }

        self.handler(object, oldVal, newVal, change);
    }
}


@end

@implementation NSObject (KVO)

- (CKVOObserver *)c_addObserverForKeyPath:(NSString *)keyPath handler:(CKVOHandler)handler {
    CKVOObserver *observer = [[CKVOObserver alloc] initWithHandler:handler];
    NSMutableDictionary *observers = [self _c_observers];
    NSMutableSet *observerSet = observers[keyPath];
    if (!observerSet) {
        observerSet = [NSMutableSet set];
        observers[keyPath] = observerSet;
    }
    [observerSet addObject:observer];
    [self addObserver:observer
           forKeyPath:keyPath
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:NULL];
    return observer;
}

- (void)c_removeObserver:(CKVOObserver *)observer forKeyPath:(NSString *)keyPath {
    NSMutableDictionary *observers = [self _c_observers];
    NSMutableSet *observerSet = observers[keyPath];
    if (observerSet) {
        [observerSet removeObject:observer];
        [self removeObserver:observer forKeyPath:keyPath];
    }
}

- (void)c_removeObserversForKeyPath:(NSString *)keyPath {
    NSMutableDictionary *observers = [self _c_observers];
    NSMutableSet *observerSet = observers[keyPath];
    if (observerSet) {
        [observerSet enumerateObjectsUsingBlock:^(id  _Nonnull observer, BOOL * _Nonnull stop) {
            [self removeObserver:observer forKeyPath:keyPath];
        }];
        [observers removeObjectForKey:keyPath];
    }
}

- (NSMutableDictionary *)_c_observers {
    NSMutableDictionary *observers = objc_getAssociatedObject(self, @selector(_c_observers));
    if (!observers) {
        observers = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, @selector(_c_observers), observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return observers;
}

@end
