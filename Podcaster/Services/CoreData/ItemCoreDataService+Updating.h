//
//  ItemCoreDataService+Updating.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ItemCoreDataService.h"

@interface ItemCoreDataService (Updating)

- (void)updateItemByNewItem:(Item *)item;
- (void)updateItemWithGUID:(NSString *)guid setValue:(NSString *)value forKey:(NSString *)key;
- (Item *)updateAndGetItemByNewItem:(Item *)item;

@end
