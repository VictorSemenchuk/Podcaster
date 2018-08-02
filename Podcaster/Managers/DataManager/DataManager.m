//
//  DataManager.m
//  Podcaster
//
//  Created by Victor Macintosh on 28/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DataManager.h"
#import "DataManager+Preparing.h"
#import "DataManager+DownloadManagerDelegate.h"
#import "ItemCoreDataService+Fetching.h"
#import "ItemCoreDataService+Updating.h"
#import "ItemCoreDataService+Saving.h"
#import "ItemCoreDataService+Removing.h"
#import "UIImage+Getting.h"

@interface DataManager ()

- (NSArray *)itemsSorting:(NSArray *)items;
- (Item *)updateLocalItemIfNeededByItem:(Item *)remoteItem;

@end

@implementation DataManager

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        _tags = @[kItemEntityXMLFieldGUID,
                      kItemEntityXMLFieldTitle,
                      kItemEntityXMLFieldAuthor,
                      kItemEntityXMLFieldDetails,
                      kItemEntityXMLFieldDuration,
                      kItemEntityXMLFieldPubDate,
                      kItemEntityXMLFieldImage,
                      kItemEntityXMLFieldContent
                      ];
        [self setupXMLServiceForSourceType:kMP3];
        [self setupXMLServiceForSourceType:kTED];
        _itemCoreDataService = [[ItemCoreDataService alloc] init];
    }
    return self;
}

#pragma mark - Item processing

- (void)processItems {
    self.items = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsMP3SourceKey] && ![[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsOfflineModeKey]) {
        [self comparationRemoteItems:self.entitiesMP3Items withLocalItems:self.entitiesCoreDataItems];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsTEDSourceKey] && ![[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsOfflineModeKey]) {
        [self comparationRemoteItems:self.entitiesTEDItems withLocalItems:self.entitiesCoreDataItems];
    }
    [self.items addObjectsFromArray:self.entitiesCoreDataItems.allValues];
    NSArray *sortedItems = [self itemsSorting:self.items];
    [self.delegate dataWasFetched:sortedItems];
}

- (void)comparationRemoteItems:(NSArray *)remoteItems withLocalItems:(NSMutableDictionary *)localItems {
    for (Item *item in remoteItems) {
        if ([item.guId isEqualToString:@"f764aa71-4ea4-411d-8634-79bd6313dcf9"]) {
            NSLog(@"");
        }
        if (localItems[item.guId]) {
            Item *currentItem = [self updateLocalItemIfNeededByItem:item];
            [self.items addObject:currentItem];
            [self.entitiesCoreDataItems removeObjectForKey:currentItem.guId];
        } else {
            [self.items addObject:item];
        }
    }
}

- (NSArray *)itemsSorting:(NSArray *)items {
    NSArray *sortedItems;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kItemPubDateAttributeName ascending:NO];
    sortedItems = [items sortedArrayUsingDescriptors:@[sortDescriptor]];
    return sortedItems;
}

- (Item *)updateLocalItemIfNeededByItem:(Item *)remoteItem {
    Item *returnItem;
    Item *localItem = self.entitiesCoreDataItems[remoteItem.guId];
    if (localItem.hashSum != remoteItem.hashSum) {
        ItemCoreDataService *coreDataService = [[ItemCoreDataService alloc] init];
        returnItem = [coreDataService updateAndGetItemByNewItem:remoteItem];
    } else {
        returnItem = localItem;
    }
    return returnItem;
}

@end
