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

@end

@implementation FileManager

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
        [self createCachesDirectoryWithPath:[NSString stringWithFormat:@"/%@", kFullSizeImageDirectory]];
        [self createCachesDirectoryWithPath:[NSString stringWithFormat:@"/%@", kPreviewImageDirestory]];
    }
    return self;
}

- (void)createCachesDirectoryWithPath:(NSString *)stringPath {
    NSString *destinationPath = [self.cachesDirectory stringByAppendingString:stringPath];
    [self.fileManager createDirectoryAtPath:destinationPath withIntermediateDirectories:YES attributes:nil error:nil];
}

- (void)createFileWithData:(NSData *)data atPath:(NSString *)stringPath {
    NSString *destinationPath = [self.cachesDirectory stringByAppendingString:stringPath];
    [self.fileManager createFileAtPath:destinationPath contents:data attributes:nil];
}

- (void)createFileWithData:(NSData *)data atPath:(NSString *)stringPath withCompressionFactor:(float)compressionFactor {
    NSData *newImageData = [UIImage imageWithImage:[UIImage imageWithData:data] compressedWithFactor:compressionFactor];
    [self createFileWithData:newImageData atPath:stringPath];
}

- (UIImage *)getImageFromPath:(NSString *)stringPath {
    NSString *destinationPath = [self.cachesDirectory stringByAppendingString:stringPath];
    return [UIImage imageWithContentsOfFile:destinationPath];
}

- (BOOL)fileIsExistForPath:(NSString *)stringPath {
    NSString *destinationPath = [self.cachesDirectory stringByAppendingString:stringPath];
    return [self.fileManager fileExistsAtPath:destinationPath];
}

- (NSString *)localFilePathForWebURL:(NSString *)webStringUrl atDirectory:(NSString *)directory {
    NSString *localPath = [NSString stringWithFormat:@"/%@/%@", directory, [self getFilenameFromStringURL:webStringUrl]];
    if ([self fileIsExistForPath:localPath]) {
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

@end
