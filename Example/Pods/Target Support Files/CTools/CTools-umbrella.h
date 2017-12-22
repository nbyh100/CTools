#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CApplicationHelper.h"
#import "CColorHelper.h"
#import "CDeviceHelper.h"
#import "CEncodingHelper.h"
#import "CFileSystemHelper.h"
#import "CFormatHelper.h"
#import "CHashHelper.h"
#import "CImageHelper.h"
#import "NSArray+SafeAccess.h"
#import "NSDictionary+SafeAccess.h"
#import "NSMutableArray+SafeAccess.h"
#import "NSMutableDictionary+SafeAccess.h"

FOUNDATION_EXPORT double CToolsVersionNumber;
FOUNDATION_EXPORT const unsigned char CToolsVersionString[];

