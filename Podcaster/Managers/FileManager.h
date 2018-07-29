//
//  FileManager.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SandboxFolderType.h"

@interface FileManager : NSObject

+ (instancetype)sharedFileManager;
- (void)createDirectoryWithPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType;
- (void)createFileWithData:(NSData *)data atPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType;
- (void)createFileWithData:(NSData *)data atPath:(NSString *)stringPath withCompressionFactor:(float)compressionFactor withSandboxFolderType:(SandboxFolderType)sandboxFolderType;
- (void)removeFileFromPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType;
- (UIImage *)getImageFromPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType;
- (BOOL)fileIsExistForPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType;
- (NSString *)localFilePathForWebURL:(NSString *)webStringUrl atDirectory:(NSString *)directory withSandboxFolderType:(SandboxFolderType)sandboxFolderType;
- (NSString *)getFilenameFromStringURL:(NSString *)stringUrl;

@end
