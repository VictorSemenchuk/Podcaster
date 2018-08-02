//
//  ItemCoreDataService+Saving.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ItemCoreDataService+Saving.h"

@implementation ItemCoreDataService (Saving)

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

@end
