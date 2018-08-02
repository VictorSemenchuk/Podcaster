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
#import "SourceType.h"

@interface FileManager : NSObject

@property (nonatomic) NSFileManager *fileManager;

+ (instancetype)sharedFileManager;
- (BOOL)fileIsExistForPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType;
- (NSString *)localFilePathForWebURL:(NSString *)webStringUrl atDirectory:(NSString *)directory withSandboxFolderType:(SandboxFolderType)sandboxFolderType;
- (NSString *)getFilenameFromStringURL:(NSString *)stringUrl;
- (NSString *)getPathForUrl:(NSString *)stringUrl withSandboxFolderType:(SandboxFolderType)sandboxFolderType;
- (NSString *)rootDirectoryForSourceType:(SourceType)sourceType;
- (NSString *)rootDirectoryForSandboxFolderType:(SandboxFolderType)sandboxFolderType;

@end
