//
//  NSArray+SafeAccess.m
//  CTools
//
//  Created by 张九州 on 2017/12/21.
//

#import "NSArray+SafeAccess.h"
#import <JRSwizzle/JRSwizzle.h>

@implementation NSArray (SafeAccess)

+ (void)c_supportSafeAccess
{
#ifndef DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self jr_swizzleClassMethod:@selector(arrayWithObjects:count:)
                         withMethod:@selector(c_arrayWithObjects:count:)
                              error:NULL];
        [self jr_swizzleMethod:@selector(initWithObjects:count:)
                    withMethod:@selector(c_initWithObjects:count:)
                         error:NULL];
    });
#endif
}

+ (instancetype)c_arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt
{
    id safeObjects[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i<cnt; i++) {
        id obj = objects[i];
        if (!obj) {
            continue;
        }
        safeObjects[j] = obj;
        j++;
    }
    return [self c_arrayWithObjects:safeObjects count:j];
}

- (instancetype)c_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt
{
    id safeObjects[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i<cnt; i++) {
        id obj = objects[i];
        if (!obj) {
            continue;
        }
        safeObjects[j] = obj;
        j++;
    }
    return [self c_initWithObjects:safeObjects count:j];
}

@end

@interface NSArray_SafeAccess : NSObject

@end

@implementation NSArray_SafeAccess

+ (void)load
{
    [NSArray c_supportSafeAccess];
}

@end
