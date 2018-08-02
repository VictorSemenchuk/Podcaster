//
//  ItemCoreDataService+Saving.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ItemCoreDataService+Saving.h"
#import "ItemCoreData.h"

@implementation ItemCoreDataService (Saving)

#pragma mark - Saving

- (void)saveNewItem:(Item *)item {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    [coreDataManager addNewInstanceForEntityWithName:kItemEntityTitle withAssigningBlock:^(NSManagedObject *currentEntity, NSManagedObjectContext *context) {
        currentEntity = [[ItemCoreData alloc] initWithItem:item andContext:context];
    }];
}

@end
