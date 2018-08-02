//
//  FileManager+Removing.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FileManager+Removing.h"

@implementation FileManager (Removing)

#pragma mark - Removing

- (void)removeFileFromPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType {
    NSString *rootDirectory = [self rootDirectoryForSandboxFolderType:sandboxFolderType];
    NSString *destinationPath = [rootDirectory stringByAppendingString:stringPath];
    [self.fileManager removeItemAtPath:destinationPath error:nil];
}

@end
