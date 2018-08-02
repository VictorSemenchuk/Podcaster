//
//  UIImage+Getting.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SandboxFolderType.h"

@interface UIImage (Getting)

+ (UIImage *)getImageFromPath:(NSString *)stringPath withSandboxFolderType:(SandboxFolderType)sandboxFolderType;

@end
