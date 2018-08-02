//
//  FileManager+Creating.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FileManager+Creating.h"
#import "UIImage+Compression.h"

@implementation FileManager (Creating)

#pragma mark - Creating

- (void)createDirectoryWithPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType {
    NSString *rootDirectory = [self rootDirectoryForSandboxFolderType:sandboxFolderType];
    NSString *destinationPath = [rootDirectory stringByAppendingString:stringPath];
    [self.fileManager createDirectoryAtPath:destinationPath withIntermediateDirectories:YES attributes:nil error:nil];
}

- (void)createFileWithData:(NSData *)data atPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType {
    NSString *rootDirectory = [self rootDirectoryForSandboxFolderType:sandboxFolderType];
    NSString *destinationPath = [rootDirectory stringByAppendingString:stringPath];
    NSLog(@"File destination path: %@", destinationPath);
    [self.fileManager createFileAtPath:destinationPath contents:data attributes:nil];
}

- (void)createFileWithData:(NSData *)data atPath:(NSString *)stringPath withCompressionFactor:(float)compressionFactor withSandboxFolderType:(SandboxFolderType)sandboxFolderType {
    NSData *newImageData = [UIImage imageWithImage:[UIImage imageWithData:data] compressedWithFactor:compressionFactor];
    [self createFileWithData:newImageData atPath:stringPath withSandboxFolderType:sandboxFolderType];
}

@end
