//
//  DownloadManager.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface DownloadManager : NSObject

- (void)downloadFileForURL:(NSString *)stringUrl withCompletionBlock:(void(^)(NSData *data))completionBlock;

@end
