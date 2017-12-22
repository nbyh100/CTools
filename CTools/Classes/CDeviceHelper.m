//
//  CDeviceHelper.m
//  CTools
//
//  Created by 张九州 on 2017/12/21.
//

#import "CDeviceHelper.h"
#include <sys/sysctl.h>

@implementation CDeviceHelper

+ (NSString *)machineModel {
    static NSString *model;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}

+ (BOOL)isSimulator {
    static BOOL simu = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *model = self.machineModel;
        if ([model isEqualToString:@"x86_64"] ||
            [model isEqualToString:@"i386"]) {
            simu = YES;
        }
    });
    return simu;
}

+ (BOOL)isIPhone {
    static dispatch_once_t one;
    static BOOL phone;
    dispatch_once(&one, ^{
        phone = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
    });
    return phone;
}

+ (BOOL)isIPad {
    static dispatch_once_t one;
    static BOOL pad;
    dispatch_once(&one, ^{
        pad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    });
    return pad;
}

+ (CGFloat)screenWidth {
    return CGRectGetWidth([UIScreen mainScreen].bounds);
}

+ (CGFloat)screenHeight {
    return CGRectGetHeight([UIScreen mainScreen].bounds);
}

+ (BOOL)canMakePhoneCalls {
    __block BOOL can;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        can = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
    });
    return can;
}

+ (NSString *)osVersion {
    static NSString *version;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [UIDevice currentDevice].systemVersion;
    });
    return version;
}

+ (BOOL)osVersionNotLessThan:(NSString *)version {
    NSString *currentVersion = [[UIDevice currentDevice] systemVersion];
    return [currentVersion compare:version options:NSNumericSearch] != NSOrderedAscending;
}

@end
