//
//  ItemCoreDataService.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/25/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface ItemCoreDataService : NSObject

- (void)saveNewItem:(Item *)item;
- (NSArray *)fetchItems;
- (void)fetchItemsToDictionaryWithCompletionBlock:(void(^)(NSMutableDictionary *items))completionBlock;
- (Item *)fetchItemByKey:(NSString *)key withValue:(NSString *)value;

@end
