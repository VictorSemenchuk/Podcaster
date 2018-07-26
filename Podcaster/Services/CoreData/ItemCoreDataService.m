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

@implementation ItemCoreDataService

- (void)addNewItem:(Item *)item {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    [coreDataManager addNewInstanceForEntityWithName:@"Item" withAssigningBlock:^(NSManagedObject *currentEntity, NSManagedObjectContext *context) {
        [currentEntity setValue:item.guId forKey:@"guid"];
        [currentEntity setValue:item.title forKey:@"title"];
        [currentEntity setValue:item.author forKey:@"author"];
        [currentEntity setValue:item.details forKey:@"details"];
        [currentEntity setValue:item.duration forKey:@"duration"];
        [currentEntity setValue:item.pubDate forKey:@"pubDate"];
        [currentEntity setValue:[NSNumber numberWithInteger:item.sourceType] forKey:@"sourceType"];
        
        NSManagedObject *imageEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:context];
        [imageEntity setValue:item.image.webUrl forKey:@"webUrl"];
        [imageEntity setValue:item.image.localUrl forKey:@"localUrl"];
        
        NSManagedObject *contentEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Content" inManagedObjectContext:context];
        [contentEntity setValue:item.content.webUrl forKey:@"webUrl"];
        [contentEntity setValue:item.content.localUrl forKey:@"localUrl"];
        
        [currentEntity setValue:imageEntity forKey:@"image"];
        [currentEntity setValue:contentEntity forKey:@"content"];
    }];
}

- (NSArray *)loadTasksForListWithId:(NSUInteger)listId {
    NSMutableArray<Item *> *items = [[NSMutableArray alloc] init];
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSArray *results = [coreDataManager fetchEntitiesWithName:@"item" byPredicate:nil];
    if (results) {
        for (ItemCoreData *itemMO in results) {
            Item *item = [[Item alloc] initWithMO:itemMO];
            [items addObject:item];
        }
    }
    return [items copy];
}

@end
