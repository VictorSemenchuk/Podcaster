//
//  ItemCoreDataService.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/25/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ItemCoreDataService.h"
#import "ItemCoreData.h"
#import "CoreDataManager.h"
#import "EntitiesConstants.h"

@implementation ItemCoreDataService

#pragma mark - Saving

- (void)saveNewItem:(Item *)item {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    [coreDataManager addNewInstanceForEntityWithName:kItemEntityTitle withAssigningBlock:^(NSManagedObject *currentEntity, NSManagedObjectContext *context) {
        [currentEntity setValue:item.guId forKey:kItemGUIDAttributeName];
        [currentEntity setValue:item.title forKey:kItemTitleAttributeName];
        [currentEntity setValue:item.author forKey:kItemAuthorAttributeName];
        [currentEntity setValue:item.details forKey:kItemDetailsAttributeName];
        [currentEntity setValue:item.duration forKey:kItemDurationAttributeName];
        [currentEntity setValue:item.pubDate forKey:kItemPubDateAttributeName];
        [currentEntity setValue:[NSNumber numberWithUnsignedInteger:item.hashSum] forKey:kItemSourceHashSumAttributeName];
        [currentEntity setValue:[NSNumber numberWithInteger:item.sourceType] forKey:kItemSourceTypeAttributeName];
        
        NSManagedObject *imageEntity = [NSEntityDescription insertNewObjectForEntityForName:kImageEntityTitle inManagedObjectContext:context];
        [imageEntity setValue:item.image.webUrl forKey:kImageWebLinkAttributeName];
        [imageEntity setValue:item.image.localPreviewUrl forKey:kImagePreviewLocalLinkAttributeName];
        [imageEntity setValue:item.image.localFullUrl forKey:kImageFullLocalLinkAttributeName];
        
        NSManagedObject *contentEntity = [NSEntityDescription insertNewObjectForEntityForName:kContentEntityTitle inManagedObjectContext:context];
        [contentEntity setValue:item.content.webUrl forKey:kContentWebLinkAttributeName];
        [contentEntity setValue:item.content.localUrl forKey:kContentLocalLinkAttributeName];
        
        [currentEntity setValue:imageEntity forKey:kItemImageAttributeName];
        [currentEntity setValue:contentEntity forKey:kItemContentAttributeName];
    }];
}

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

#pragma mark - Updating

- (void)updateItemByNewItem:(Item *)item {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", kItemGUIDAttributeName, item.guId];
    [coreDataManager updateEntityWithName:kItemEntityTitle byPredicate:predicate withUpdatingBlock:^(NSManagedObject *object) {
        [object setValue:item.guId forKey:kItemGUIDAttributeName];
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
    Item *newItem = [self fetchItemByKey:kItemGUIDAttributeName withValue:item.guId];
    return newItem;
}

- (void)updateItemWithGUID:(NSString *)guid setValue:(NSString *)value forKey:(NSString *)key {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", kItemGUIDAttributeName, guid];
    [coreDataManager updateEntityWithName:kItemEntityTitle byPredicate:predicate withUpdatingBlock:^(NSManagedObject *object) {
        [object setValue:value forKeyPath:key];
    }];
}

#pragma mark - Removing

- (void)removeItem:(Item *)item {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", kItemGUIDAttributeName, item.guId];
    [coreDataManager removeEntityWithName:kItemEntityTitle byPredicate:predicate];
}

@end
