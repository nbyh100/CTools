//
//  CFormatHelper.m
//  CTools
//
//  Created by 张九州 on 2017/12/21.
//

#import "CFormatHelper.h"

@implementation CFormatHelper

+ (NSString *)fullDateFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)fullDateTimeFormat {
    return @"yyyy-MM-dd HH:mm:ss";
}

static NSString *const kCurrentDateFormatter = @"dateFormatter";

+ (NSDateFormatter *)dateFormatter {
    NSMutableDictionary *threadDict = [NSThread currentThread].threadDictionary;
    NSDateFormatter *dateFormatter = threadDict[kCurrentDateFormatter];

    if (!dateFormatter) {
        @synchronized (self) {
            if (!dateFormatter) {
                dateFormatter = [NSDateFormatter new];
                threadDict[kCurrentDateFormatter] = dateFormatter;
            }
        }
    }
    return dateFormatter;
}

+ (NSString *)date:(NSDate *)date format:(NSString *)format {
    [self.dateFormatter setDateFormat:format];
    return [self.dateFormatter stringFromDate:date];
}

+ (NSString *)timestamp:(NSTimeInterval)date format:(NSString *)format {
    return [self date:[NSDate dateWithTimeIntervalSince1970:date] format:format];
}

+ (NSString *)formatCountdown:(NSTimeInterval)second {
    NSInteger hh = second / (60 * 60);
    NSInteger mm = hh > 0 ? (second - 60 * 60 * hh)/60 : second/60;
    NSInteger ss = (NSInteger)second - hh * 60 * 60 - mm * 60;
    NSString *hhStr, *mmStr, *ssStr;
    if (hh == 0) {
        hhStr = @"00";
    } else if (hh > 0 && hh < 10) {
        hhStr = [NSString stringWithFormat:@"0%ld", (long)hh];
    } else {
        hhStr = [NSString stringWithFormat:@"%ld", (long)hh];
    }
    if (mm == 0) {
        mmStr = @"00";
    } else if (mm > 0 && mm < 10) {
        mmStr = [NSString stringWithFormat:@"0%ld", (long)mm];
    } else {
        mmStr = [NSString stringWithFormat:@"%ld", (long)mm];
    }
    if (ss == 0) {
        ssStr = @"00";
    } else if (ss > 0 && ss < 10) {
        ssStr = [NSString stringWithFormat:@"0%ld", (long)ss];
    } else {
        ssStr = [NSString stringWithFormat:@"%ld", (long)ss];
    }
    return [NSString stringWithFormat:@"%@:%@:%@", hhStr, mmStr, ssStr];
}

+ (NSString *)addComma {
    return @"addComma";
}

+ (NSString *)digits {
    return @"digits";
}

+ (NSString *)showSign {
    return @"showSign";
}

+ (NSString *)percentage {
    return @"percentage";
}

+ (NSString *)trimZero {
    return @"trimZero";
}

+ (NSString *)number:(double)number options:(NSDictionary *)options {
    BOOL addComma = [options[self.addComma] boolValue];
    NSInteger decimalDigits = [options[self.digits] integerValue];
    BOOL showSign = [options[self.showSign] boolValue];
    BOOL percentage = [options[self.percentage] boolValue];
    BOOL trimZero = [options[self.trimZero] boolValue];

    // 3.33
    number = percentage ? number / 100 : number;
    double realNumber = round(number * pow(10, decimalDigits)) / pow(10, decimalDigits);
    double absNumber = fabs(realNumber);
    long long longLongMoney = (long long)absNumber;
    NSString *fmt = [NSString stringWithFormat:@"%%.%ldf", (long)decimalDigits];
    NSString *resultString = nil;

    if (!addComma || absNumber < 1000) {
        resultString = [NSString stringWithFormat:fmt, absNumber];
    } else {
        if (decimalDigits > 0) {
            CGFloat yushu = absNumber - longLongMoney;
            NSString *yushuStr = [NSString stringWithFormat:fmt, yushu];
            resultString = [NSString stringWithFormat:@"%@%@",
                            [self _addComma:longLongMoney],
                            [yushuStr substringWithRange:NSMakeRange(1, 1 + decimalDigits)]];
        } else {
            resultString = [self _addComma:longLongMoney];
        }
    }

    if (trimZero && [resultString rangeOfString:@"."].location != NSNotFound) {
        resultString = [resultString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0"]];
        // 整数部分被去除了，补上0
        if ([resultString hasPrefix:@"."]) {
            resultString = [NSString stringWithFormat:@"0%@", resultString];
        }
        // 小数部分被去除了，去掉小数点
        if ([resultString hasSuffix:@"."]) {
            resultString = [resultString substringToIndex:resultString.length - 1];
        }
    }

    if (realNumber < 0) {
        resultString = [NSString stringWithFormat:@"-%@", resultString];
    } else if (realNumber > 0 && showSign) {
        resultString = [NSString stringWithFormat:@"+%@", resultString];
    }

    if (percentage) {
        resultString = [NSString stringWithFormat:@"%@%%", resultString];
    }

    return resultString;
}

+ (NSString *)_addComma:(long long)aLongValue
{
    NSString *separatorString = @",";
    NSString *temString = [NSString stringWithFormat:@"%lld",aLongValue];

    NSMutableArray *valueArray = [NSMutableArray array];

    NSInteger commaCount = 0;
    NSInteger strLength = temString.length;

    //low -> high calculate
    for (NSInteger i = strLength - 1; i >= 0; i--) {

        [valueArray insertObject:[temString substringWithRange:NSMakeRange(i, 1)] atIndex:0];

        commaCount++;
        if (commaCount == 3) {
            //add comma
            [valueArray insertObject:separatorString atIndex:0];
            commaCount = 0;
        }

    }
    if ([valueArray.firstObject isEqualToString:separatorString]) {
        [valueArray removeObjectAtIndex:0];
    }
    NSString *resultString = [valueArray componentsJoinedByString:@""];

    return resultString;
}

@end
