//
//  CDeviceHelper.h
//  CTools
//
//  Created by 张九州 on 2017/12/21.
//

#import <Foundation/Foundation.h>

@interface CDeviceHelper : NSObject

@property (class, readonly) NSString *machineModel;
@property (class, readonly) BOOL isSimulator;
@property (class, readonly) BOOL isIPhone;
@property (class, readonly) BOOL isIPad;

@property (class, readonly) CGFloat screenWidth;
@property (class, readonly) CGFloat screenHeight;
@property (class, readonly) BOOL canMakePhoneCalls;

@property (class, readonly) NSString *osVersion;

+ (BOOL)osVersionNotLessThan:(NSString *)version;

@end
