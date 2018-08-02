//
//  DataManager+Removing.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DataManager.h"

@interface DataManager (Removing)

+ (void)removeItemFromPersistent:(Item *)item completionBlock:(void(^)(void))completionBlock;

@end
