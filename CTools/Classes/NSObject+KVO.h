//
//  NSObject+KVO.h
//  CTools
//
//  Created by 张九州 on 2017/12/21.
//

#import <Foundation/Foundation.h>

@class CKVOObserver;
typedef void (^CKVOHandler)(__weak id obj, id oldVal, id newVal, NSDictionary<NSString *,id> *change);

@interface NSObject (KVO)

- (CKVOObserver *)c_addObserverForKeyPath:(NSString *)keyPath handler:(CKVOHandler)handler;
- (void)c_removeObserver:(CKVOObserver *)observer forKeyPath:(NSString *)keyPath;
- (void)c_removeObserversForKeyPath:(NSString *)keyPath;

@end
