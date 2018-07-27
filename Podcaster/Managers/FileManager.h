//
//  FileManager.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FileManager : NSObject

+ (instancetype)sharedFileManager;
- (void)createCachesDirectoryWithPath:(NSString *)stringPath;
- (void)createFileWithData:(NSData *)data atPath:(NSString *)stringPath;
- (void)createFileWithData:(NSData *)data atPath:(NSString *)stringPath withCompressionFactor:(float)compressionFactor;
- (UIImage *)getImageFromPath:(NSString *)stringPath;
- (BOOL)fileIsExistForPath:(NSString *)stringPath;
- (NSString *)localFilePathForWebURL:(NSString *)webStringUrl atDirectory:(NSString *)directory;
- (NSString *)getFilenameFromStringURL:(NSString *)stringUrl;

@end
