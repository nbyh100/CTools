//
//  CEncodingHelper.h
//  CTools
//
//  Created by 张九州 on 2017/12/21.
//

#import <Foundation/Foundation.h>

@interface CEncodingHelper : NSObject

+ (NSString *)base64Encode:(NSData *)data;
+ (NSData *)base64Decode:(NSString *)string;
+ (NSString *)URLEncode:(NSString *)string;
+ (NSString *)URLDecode:(NSString *)string;
+ (NSString *)escapeHTML:(NSString *)string;

@end
