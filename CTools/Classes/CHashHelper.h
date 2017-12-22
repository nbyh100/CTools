//
//  CHashHelper.h
//  CTools
//
//  Created by 张九州 on 2017/12/21.
//

#import <Foundation/Foundation.h>

@interface CHashHelper : NSObject

+ (NSString *)md5:(NSString *)string;
+ (NSString *)sha1:(NSString *)string;

@end
