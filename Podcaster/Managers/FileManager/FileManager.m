//
//  FileManager.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FileManager.h"
#import "Constants.h"
#import "FileManager+Creating.h"

@interface FileManager ()

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
        [self createDirectoryWithPath:[NSString stringWithFormat:@"/%@", kAudioDirectory] withSandboxFolderType:kDocuments];
        [self createDirectoryWithPath:[NSString stringWithFormat:@"/%@", kFullSizeImageDirectory] withSandboxFolderType:kDocuments];
    }
    return self;
}

#pragma mark - Methods

- (BOOL)fileIsExistForPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType {
    NSString *rootDirectory = [self rootDirectoryForSandboxFolderType:sandboxFolderType];
    NSString *destinationPath = [rootDirectory stringByAppendingString:stringPath];
    NSData *fileContents = [NSData dataWithContentsOfFile:destinationPath];
    if (fileContents) {
        return true;
    } else {
        return false;
    }
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

- (NSString *)getPathForUrl:(NSString *)stringUrl withSandboxFolderType:(SandboxFolderType)sandboxFolderType {
    return [[self rootDirectoryForSandboxFolderType:sandboxFolderType] stringByAppendingString:stringUrl];
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

- (NSString *)rootDirectoryForSourceType:(SourceType)sourceType {
    NSString *directory = @"";
    switch (sourceType) {
        case kMP3:
            directory = kAudioDirectory;
            break;
        case kTED:
            directory = kVideoDirectory;
            break;
    }
    return directory;
}

@end
