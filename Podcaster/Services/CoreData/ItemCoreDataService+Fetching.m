//
//  ItemCoreDataService+Fetching.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ItemCoreDataService+Fetching.h"

@implementation ItemCoreDataService (Fetching)

#pragma mark - Fetching

- (NSArray *)fetchItems {
    NSMutableArray<Item *> *items = [[NSMutableArray alloc] init];
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kItemEntityTitle byPredicate:nil];
    if (results) {
        for (ItemCoreData *itemMO in results) {
            Item *item = [[Item alloc] initWithMO:itemMO];
            [items addObject:item];
        }
    }
    return [items copy];
}

- (void)fetchItemsToDictionaryByPredicate:(NSPredicate *)predicate withCompletionBlock:(void(^)(NSMutableDictionary *items))completionBlock {
    NSMutableDictionary *items = [[NSMutableDictionary alloc] init];
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kItemEntityTitle byPredicate:predicate];
    if (results) {
        for (ItemCoreData *itemMO in results) {
            Item *item = [[Item alloc] initWithMO:itemMO];
            items[item.guId] = item;
        }
    }
    completionBlock(items);
}

- (Item *)fetchItemByKey:(NSString *)key withValue:(NSString *)value {
    Item *item;
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", key, value];
    NSArray *results = [coreDataManager fetchEntitiesWithName:kItemEntityTitle byPredicate:predicate];
    if (results) {
        ItemCoreData *itemMO = results.firstObject;
        item = [[Item alloc] initWithMO:itemMO];
    }
    return item;
}

@end
