//
//  NSMutableDictionary+SafeAccess.m
//  CTools
//
//  Created by 张九州 on 2017/12/21.
//

#import "NSMutableDictionary+SafeAccess.h"
#import <JRSwizzle/JRSwizzle.h>

@implementation NSMutableDictionary (SafeAccess)

+ (void)c_supportSafeAccess
{
#ifndef DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        [class jr_swizzleMethod:@selector(setObject:forKey:)
                     withMethod:@selector(c_setObject:forKey:)
                          error:NULL];
        [class jr_swizzleMethod:@selector(setObject:forKeyedSubscript:)
                     withMethod:@selector(c_setObject:forKeyedSubscript:)
                          error:NULL];
        [class jr_swizzleMethod:@selector(removeObjectForKey:)
                     withMethod:@selector(c_removeObjectForKey:)
                          error:NULL];
    });
#endif
}

- (void)c_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!aKey) {
        return;
    }
    if (anObject) {
        [self c_setObject:anObject forKey:aKey];
    } else {
        [self removeObjectForKey:aKey];
    }
}

- (void)c_setObject:(id)anObject forKeyedSubscript:(id<NSCopying>)key
{
    if (!key) {
        return;
    }
    if (anObject) {
        [self c_setObject:anObject forKeyedSubscript:key];
    } else {
        [self removeObjectForKey:key];
    }
}

- (void)c_removeObjectForKey:(id)aKey
{
    if (aKey) {
        [self c_removeObjectForKey:aKey];
    }
}

@end

@interface NSMutableDictionary_SafeAccess : NSObject

@end

@implementation NSMutableDictionary_SafeAccess

+ (void)load
{
    [NSMutableDictionary c_supportSafeAccess];
}

@end
