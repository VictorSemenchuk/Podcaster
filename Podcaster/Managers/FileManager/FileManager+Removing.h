//
//  FileManager+Removing.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FileManager.h"

@interface FileManager (Removing)

- (void)removeFileFromPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType;


@end
