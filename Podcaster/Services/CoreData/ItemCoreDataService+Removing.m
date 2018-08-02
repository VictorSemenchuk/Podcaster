//
//  ItemCoreDataService+Removing.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ItemCoreDataService+Removing.h"

@implementation ItemCoreDataService (Removing)

#pragma mark - Removing

- (void)removeItem:(Item *)item {
    CoreDataManager *coreDataManager = [[CoreDataManager alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", kItemGUIDAttributeName, item.guid];
    [coreDataManager removeEntityWithName:kItemEntityTitle byPredicate:predicate];
}

@end
