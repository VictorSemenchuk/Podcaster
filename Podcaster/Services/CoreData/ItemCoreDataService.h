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
- (void)fetchItemsToDictionaryByPredicate:(NSPredicate *)predicate withCompletionBlock:(void(^)(NSMutableDictionary *items))completionBlock;
- (Item *)fetchItemByKey:(NSString *)key withValue:(NSString *)value;
- (void)updateItemByNewItem:(Item *)item;
- (void)updateItemWithGUID:(NSString *)guid setValue:(NSString *)value forKey:(NSString *)key;
- (Item *)updateAndGetItemByNewItem:(Item *)item;
- (void)removeItem:(Item *)item;

@end
