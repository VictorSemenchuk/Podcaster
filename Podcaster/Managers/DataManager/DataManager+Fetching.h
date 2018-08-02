//
//  DataManager+Fetching.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DataManager.h"

@interface DataManager (Fetching)

- (void)fetchData:(id)sender;
- (void)refetchData;
- (void)fetchData;
+ (void)getPreviewImageForItem:(Item *)item completionBlock:(void(^)(UIImage *image))completionBlock;

@end
