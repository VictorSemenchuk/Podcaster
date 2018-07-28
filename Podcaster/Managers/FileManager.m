//
//  FileManager.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FileManager.h"
#import "UIImage+Compression.h"
#import "Constants.h"

@interface FileManager ()

@property (nonatomic) NSFileManager *fileManager;
@property (nonatomic) NSString *cachesDirectory;
@property (nonatomic) NSString *documentsDirectory;

- (NSString *)rootDirectoryForSandboxFolderType:(SandboxFolderType)sandboxFolderType;

@end

@implementation FileManager

#pragma mark - Init

+ (instancetype)sharedFileManager {
    static FileManager *sharedFileManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFileManager = [[self alloc] init];
    });
    return sharedFileManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _fileManager = [NSFileManager defaultManager];
        _cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        _documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        [self createDirectoryWithPath:[NSString stringWithFormat:@"/%@", kPreviewImageDirestory] withSandboxFolderType:kCaches];
        [self createDirectoryWithPath:[NSString stringWithFormat:@"/%@", kVideoDirectory] withSandboxFolderType:kDocuments];
        [self createDirectoryWithPath:[NSString stringWithFormat:@"/%@", kFullSizeImageDirectory] withSandboxFolderType:kDocuments];
    }
    return self;
}

#pragma mark - Creating

- (void)createDirectoryWithPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType {
    NSString *rootDirectory = [self rootDirectoryForSandboxFolderType:sandboxFolderType];
    NSString *destinationPath = [rootDirectory stringByAppendingString:stringPath];
    [self.fileManager createDirectoryAtPath:destinationPath withIntermediateDirectories:YES attributes:nil error:nil];
}

- (void)createFileWithData:(NSData *)data atPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType {
    NSString *rootDirectory = [self rootDirectoryForSandboxFolderType:sandboxFolderType];
    NSString *destinationPath = [rootDirectory stringByAppendingString:stringPath];
    //NSLog(@"%@", destinationPath);
    [self.fileManager createFileAtPath:destinationPath contents:data attributes:nil];
}

- (void)createFileWithData:(NSData *)data atPath:(NSString *)stringPath withCompressionFactor:(float)compressionFactor withSandboxFolderType:(SandboxFolderType)sandboxFolderType {
    NSData *newImageData = [UIImage imageWithImage:[UIImage imageWithData:data] compressedWithFactor:compressionFactor];
    [self createFileWithData:newImageData atPath:stringPath withSandboxFolderType:sandboxFolderType];
}

#pragma mark - Getting

- (UIImage *)getImageFromPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType {
    NSString *rootDirectory = [self rootDirectoryForSandboxFolderType:sandboxFolderType];
    NSString *destinationPath = [rootDirectory stringByAppendingString:stringPath];
    return [UIImage imageWithContentsOfFile:destinationPath];
}

#pragma mark - Other

- (BOOL)fileIsExistForPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType {
    NSString *rootDirectory = [self rootDirectoryForSandboxFolderType:sandboxFolderType];
    NSString *destinationPath = [rootDirectory stringByAppendingString:stringPath];
    return [self.fileManager fileExistsAtPath:destinationPath];
}

- (NSString *)localFilePathForWebURL:(NSString *)webStringUrl atDirectory:(NSString *)directory withSandboxFolderType:(SandboxFolderType)sandboxFolderType {
    NSString *localPath = [NSString stringWithFormat:@"/%@/%@", directory, [self getFilenameFromStringURL:webStringUrl]];
    if ([self fileIsExistForPath:localPath withSandboxFolderType:sandboxFolderType]) {
        return localPath;
    } else {
        return @"";
    }
}

- (NSString *)getFilenameFromStringURL:(NSString *)stringUrl {
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSString *fileTitle = url.lastPathComponent;
    return fileTitle;
}

- (NSString *)rootDirectoryForSandboxFolderType:(SandboxFolderType)sandboxFolderType {
    NSString *directory = @"";
    switch (sandboxFolderType) {
        case kCaches:
            directory = self.cachesDirectory;
            break;
        case kDocuments:
            directory = self.documentsDirectory;
            break;
    }
    return directory;
}

@end
