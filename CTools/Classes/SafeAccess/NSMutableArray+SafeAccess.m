//
//  NSMutableArray+SafeAccess.m
//  CTools
//
//  Created by 张九州 on 2017/12/21.
//

#import "NSMutableArray+SafeAccess.h"
#import <JRSwizzle/JRSwizzle.h>

@implementation NSMutableArray (SafeAccess)

+ (void)c_supportSafeAccess
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSArrayM");
        [class jr_swizzleMethod:@selector(addObject:)
                     withMethod:@selector(c_addObject:)
                          error:NULL];
        [class jr_swizzleMethod:@selector(insertObject:atIndex:)
                     withMethod:@selector(c_insertObject:atIndex:)
                          error:NULL];
        [class jr_swizzleMethod:@selector(setObject:atIndexedSubscript:)
                     withMethod:@selector(c_setObject:atIndexedSubscript:)
                          error:NULL];
    });
}

- (void)c_addObject:(id)anObject
{
    if (anObject) {
        [self c_addObject:anObject];
    }
}

- (void)c_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject) {
        [self c_insertObject:anObject atIndex:index];
    }
}

- (void)c_setObject:(id)anObject atIndexedSubscript:(NSUInteger)index
{
    if (anObject) {
        [self c_setObject:anObject atIndexedSubscript:index];
    }
}

@end


@interface NSMutableArray_SafeAccess : NSObject

@end

@implementation NSMutableArray_SafeAccess

+ (void)load
{
    [NSMutableArray c_supportSafeAccess];
}

@end

