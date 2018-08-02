//
//  ItemCoreDataService+Saving.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ItemCoreDataService.h"

@interface ItemCoreDataService (Saving)

- (void)saveNewItem:(Item *)item;

@end
