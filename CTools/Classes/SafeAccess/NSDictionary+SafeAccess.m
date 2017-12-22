//
//  NSDictionary+SafeAccess.m
//  CTools
//
//  Created by 张九州 on 2017/12/21.
//

#import "NSDictionary+SafeAccess.h"
#import <JRSwizzle/JRSwizzle.h>

@implementation NSDictionary (SafeAccess)

+ (void)c_supportSafeAccess
{
#ifndef DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self jr_swizzleMethod:@selector(initWithObjects:forKeys:count:)
                    withMethod:@selector(c_initWithObjects:forKeys:count:)
                         error:NULL];
        [self jr_swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:)
                         withMethod:@selector(c_dictionaryWithObjects:forKeys:count:)
                              error:NULL];
    });
#endif
}

+ (instancetype)c_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt
{
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj) {
            continue;
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self c_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

- (instancetype)c_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt
{
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj) {
            continue;
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self c_initWithObjects:safeObjects forKeys:safeKeys count:j];
}

@end

@interface NSDictionary_SafeAccess : NSObject

@end

@implementation NSDictionary_SafeAccess

+ (void)load
{
    [NSDictionary c_supportSafeAccess];
}

@end
