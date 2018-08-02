//
//  DataManager+Saving.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DataManager.h"

@interface DataManager (Saving)

- (void)saveItemToPersistent:(Item *)item completionBlock:(void(^)(void))completionBlock;

@end
