//
//  CFormatHelper.h
//  CTools
//
//  Created by 张九州 on 2017/12/21.
//

#import <Foundation/Foundation.h>

@interface CFormatHelper : NSObject

@property (class, readonly) NSString *fullDateFormat;
@property (class, readonly) NSString *fullDateTimeFormat;
@property (class, readonly) NSDateFormatter *dateFormatter;

+ (NSString *)date:(NSDate *)date format:(NSString *)format;
+ (NSString *)timestamp:(NSTimeInterval)date format:(NSString *)format;
+ (NSString *)formatCountdown:(NSTimeInterval)second;

@property (class, readonly) NSString *addComma;
@property (class, readonly) NSString *digits;
@property (class, readonly) NSString *showSign;
@property (class, readonly) NSString *percentage;
@property (class, readonly) NSString *trimZero;

+ (NSString *)number:(double)number options:(NSDictionary *)options;

@end
