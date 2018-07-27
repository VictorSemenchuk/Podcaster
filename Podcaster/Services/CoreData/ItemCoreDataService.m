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

- (void)addNewItem:(Item *)item {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    [coreDataManager addNewInstanceForEntityWithName:kItemEntityTitle withAssigningBlock:^(NSManagedObject *currentEntity, NSManagedObjectContext *context) {
        [currentEntity setValue:item.guId forKey:kItemGUIDAttributeName];
        [currentEntity setValue:item.title forKey:kItemTitleAttributeName];
        [currentEntity setValue:item.author forKey:kItemAuthorAttributeName];
        [currentEntity setValue:item.details forKey:kItemDetailsAttributeName];
        [currentEntity setValue:item.duration forKey:kItemDurationAttributeName];
        [currentEntity setValue:item.pubDate forKey:kItemPubDateAttributeName];
        [currentEntity setValue:[NSNumber numberWithInteger:item.sourceType] forKey:kItemSourceTypeAttributeName];
        
        NSManagedObject *imageEntity = [NSEntityDescription insertNewObjectForEntityForName:kImageEntityTitle inManagedObjectContext:context];
        [imageEntity setValue:item.image.webUrl forKey:kImageWebLinkAttributeName];
        [imageEntity setValue:item.image.localUrl forKey:kImageLocalLinkAttributeName];
        
        NSManagedObject *contentEntity = [NSEntityDescription insertNewObjectForEntityForName:kContentEntityTitle inManagedObjectContext:context];
        [contentEntity setValue:item.content.webUrl forKey:kContentWebLinkAttributeName];
        [contentEntity setValue:item.content.localUrl forKey:kContentLocalLinkAttributeName];
        
        [currentEntity setValue:imageEntity forKey:kItemImageAttributeName];
        [currentEntity setValue:contentEntity forKey:kItemContentAttributeName];
    }];
}

- (NSArray *)loadTasksForListWithId:(NSUInteger)listId {
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

@end
