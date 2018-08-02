//
//  ItemCoreDataService+Updating.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ItemCoreDataService+Updating.h"
#import "ItemCoreDataService+Fetching.h"

@implementation ItemCoreDataService (Updating)

#pragma mark - Updating

- (void)updateItemByNewItem:(Item *)item {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", kItemGUIDAttributeName, item.guid];
    [coreDataManager updateEntityWithName:kItemEntityTitle byPredicate:predicate withUpdatingBlock:^(NSManagedObject *object) {
        [object setValue:item.guid forKey:kItemGUIDAttributeName];
        [object setValue:item.title forKey:kItemTitleAttributeName];
        [object setValue:item.author forKey:kItemAuthorAttributeName];
        [object setValue:item.details forKey:kItemDetailsAttributeName];
        [object setValue:item.duration forKey:kItemDurationAttributeName];
        [object setValue:item.pubDate forKey:kItemPubDateAttributeName];
        [object setValue:[NSNumber numberWithUnsignedInteger:item.hashSum] forKey:kItemSourceHashSumAttributeName];
    }];
}

- (Item *)updateAndGetItemByNewItem:(Item *)item {
    [self updateItemByNewItem:item];
    Item *newItem = [self fetchItemByKey:kItemGUIDAttributeName withValue:item.guid];
    return newItem;
}

- (void)updateItemWithGUID:(NSString *)guid setValue:(NSString *)value forKey:(NSString *)key {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", kItemGUIDAttributeName, guid];
    [coreDataManager updateEntityWithName:kItemEntityTitle byPredicate:predicate withUpdatingBlock:^(NSManagedObject *object) {
        [object setValue:value forKeyPath:key];
    }];
}

@end
