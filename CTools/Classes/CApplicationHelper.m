//
//  CApplicationHelper.m
//  CTools
//
//  Created by 张九州 on 2017/12/21.
//

#import "CApplicationHelper.h"

@implementation CApplicationHelper

+ (BOOL)openPhone:(NSString *)phoneNumber {
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneNumber]]];
}

+ (BOOL)openShortMessage:(NSString *)phoneNumber {
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@", phoneNumber]]];
}

+ (BOOL)openEmail:(NSString *)emailAddress {
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", emailAddress]]];
}

+ (BOOL)openSettings {
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

@end
