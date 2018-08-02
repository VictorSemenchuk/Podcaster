//
//  UIImage+Getting.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "UIImage+Getting.h"
#import "FileManager.h"

@implementation UIImage (Getting)

+ (UIImage *)getImageFromPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType {
    FileManager *fileManager = [FileManager sharedFileManager];
    NSString *destinationPath = [fileManager getPathForUrl:stringPath withSandboxFolderType:sandboxFolderType];
    return [UIImage imageWithContentsOfFile:destinationPath];
}

@end
