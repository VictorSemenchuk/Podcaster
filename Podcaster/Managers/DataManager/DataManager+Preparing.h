//
//  DataManager+Preparing.h
//  Podcaster
//
//  Created by Victor Macintosh on 28/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DataManager.h"

@interface DataManager (Preparing)

- (NSString *)getUrlForSourceType:(SourceType)sourceType;
- (void)setupXMLServiceForSourceType:(SourceType)sourceType;

@end
