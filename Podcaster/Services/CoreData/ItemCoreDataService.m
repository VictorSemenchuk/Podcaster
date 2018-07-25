//
//  ItemCoreDataService.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/25/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ItemCoreDataService.h"

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
    }];
}

@end
