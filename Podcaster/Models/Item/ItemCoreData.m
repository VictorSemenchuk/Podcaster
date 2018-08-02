//
//  Item.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ItemCoreData.h"
#import "EntitiesConstants.h"

@implementation ItemCoreData

@dynamic guid;
@dynamic title;
@dynamic author;
@dynamic details;
@dynamic duration;
@dynamic pubDate;
@dynamic hashSum;
@dynamic sourceType;
@dynamic image;
@dynamic content;

- (instancetype)initWithItem:(Item *)item andContext:(NSManagedObjectContext *)context {
    ItemCoreData *itemMO = [NSEntityDescription insertNewObjectForEntityForName:kItemEntityTitle inManagedObjectContext:context];
    [itemMO setValue:item.guid forKey:kItemGUIDAttributeName];
    [itemMO setValue:item.title forKey:kItemTitleAttributeName];
    [itemMO setValue:item.author forKey:kItemAuthorAttributeName];
    [itemMO setValue:item.details forKey:kItemDetailsAttributeName];
    [itemMO setValue:item.duration forKey:kItemDurationAttributeName];
    [itemMO setValue:item.pubDate forKey:kItemPubDateAttributeName];
    [itemMO setValue:[NSNumber numberWithUnsignedInteger:item.hashSum] forKey:kItemSourceHashSumAttributeName];
    [itemMO setValue:[NSNumber numberWithInteger:item.sourceType] forKey:kItemSourceTypeAttributeName];
    [itemMO setValue:[[ImageContentCoreData alloc] initWithImage:item.image andContext:context] forKey:kItemImageAttributeName];
    [itemMO setValue:[[MediaContentCoreData alloc] initWithContent:item.content andContext:context] forKey:kItemContentAttributeName];
    return itemMO;
}

@end
