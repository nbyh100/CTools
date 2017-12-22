//
//  CFileSystemHelper.h
//  CTools
//
//  Created by 张九州 on 2017/12/21.
//

#import <Foundation/Foundation.h>

@interface CFileSystemHelper : NSObject

@property (class, readonly) NSString *documentPath;
@property (class, readonly) NSString *libraryPath;
@property (class, readonly) NSString *cachePath;
@property (class, readonly) NSString *tmpPath;

+ (BOOL)excludeFromICloudBackup:(NSString *)path;

@end
