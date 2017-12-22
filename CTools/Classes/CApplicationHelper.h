//
//  CApplicationHelper.h
//  CTools
//
//  Created by 张九州 on 2017/12/21.
//

#import <Foundation/Foundation.h>

@interface CApplicationHelper : NSObject

+ (BOOL)openPhone:(NSString *)phoneNumber;
+ (BOOL)openShortMessage:(NSString *)phoneNumber;
+ (BOOL)openEmail:(NSString *)emailAddress;
+ (BOOL)openSettings;

@end
