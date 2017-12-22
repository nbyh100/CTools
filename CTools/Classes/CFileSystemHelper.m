//
//  CFileSystemHelper.m
//  CTools
//
//  Created by 张九州 on 2017/12/21.
//

#import "CFileSystemHelper.h"

@implementation CFileSystemHelper

+ (NSString *)documentPath
{
    static NSString *documentPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentPath = [paths objectAtIndex:0];
    });
    return documentPath;
}

+ (NSString *)libraryPath
{
    static NSString *libraryPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        libraryPath = [paths objectAtIndex:0];
    });
    return libraryPath;
}

+ (NSString *)cachePath
{
    static NSString *cachePath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        cachePath = [paths objectAtIndex:0];
    });
    return cachePath;
}

+ (NSString *)tmpPath
{
    return NSTemporaryDirectory();
}

+ (BOOL)excludeFromICloudBackup:(NSString *)path
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSError *error = nil;
        BOOL success = [fileURL setResourceValue:@YES forKey:NSURLIsExcludedFromBackupKey error:&error];
        if (!success) {
            NSLog(@"Error excluding %@ from backup %@", path, error);
        }
        return success;
    }
    return NO;
}

@end
