//
//  FileManager+Creating.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FileManager.h"

@interface FileManager (Creating)

- (void)createDirectoryWithPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType;
- (void)createFileWithData:(NSData *)data atPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType;
- (void)createFileWithData:(NSData *)data atPath:(NSString *)stringPath withCompressionFactor:(float)compressionFactor withSandboxFolderType:(SandboxFolderType)sandboxFolderType;

@end
