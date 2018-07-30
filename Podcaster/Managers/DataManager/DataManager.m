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

@interface DataManager ()

- (void)fetchData;
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

#pragma mark - Fetching

- (void)fetchData:(id)sender {
    self.delegate = sender;
    [self fetchData];
}

- (void)refetchData {
    [self fetchData];
}

- (void)fetchData {
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(dispatchGroup, queue, ^{
        NSPredicate *predicate;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsMP3SourceKey] && [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsTEDSourceKey]) {
            predicate = [NSPredicate predicateWithFormat: @"%K == %d OR %K == %d", kItemSourceTypeAttributeName, kMP3, kItemSourceTypeAttributeName, kTED];
        } else if ([[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsMP3SourceKey]) {
            predicate = [NSPredicate predicateWithFormat: @"%K == %d", kItemSourceTypeAttributeName, kMP3];
        } else if ([[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsTEDSourceKey]) {
            predicate = [NSPredicate predicateWithFormat: @"%K == %d", kItemSourceTypeAttributeName, kTED];
        } else if (![[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsMP3SourceKey] && ![[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsTEDSourceKey]) {
            predicate = [NSPredicate predicateWithFormat: @"%K != %d AND %K != %d", kItemSourceTypeAttributeName, kMP3, kItemSourceTypeAttributeName, kTED];
        }
        [self.entitiesCoreDataItems removeAllObjects];
        [self.itemCoreDataService fetchItemsToDictionaryByPredicate:predicate withCompletionBlock:^(NSMutableDictionary *items) {
            self.entitiesCoreDataItems = items;
        }];
    });
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsMP3SourceKey] && self.entitiesMP3Items.count == 0 && ![[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsOfflineModeKey]) {
        dispatch_group_enter(dispatchGroup);
        dispatch_group_async(dispatchGroup, queue, ^{
            [self.xmlParserServiceMP3 startParsing:^(NSArray *items) {
                self.entitiesMP3Items = items;
                dispatch_group_leave(dispatchGroup);
            }];
        });
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsTEDSourceKey] && self.entitiesTEDItems.count == 0 && ![[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsOfflineModeKey]) {
        dispatch_group_enter(dispatchGroup);
        dispatch_group_async(dispatchGroup, queue, ^{
            [self.xmlParserServiceTED startParsing:^(NSArray *items) {
                self.entitiesTEDItems = items;
                dispatch_group_leave(dispatchGroup);
            }];
        });
    }
    dispatch_group_notify(dispatchGroup, queue, ^{
        [self processItems];
    });
}

+ (void)getPreviewImageForItem:(Item *)item completionBlock:(void (^)(UIImage *))completionBlock {
    FileManager *fileManager = [FileManager sharedFileManager];
    if (![item.image.localPreviewUrl isEqualToString:@""]) {
        UIImage *image = [fileManager getImageFromPath:item.image.localPreviewUrl withSandboxFolderType:kCaches];
        completionBlock(image);
    } else {
        float compressionFactor;
        NSString *url;
        switch (item.sourceType) {
            case kMP3:
                url = item.image.webUrl;
                compressionFactor = 0.1;
                break;
            case kTED:
                url = [item.image.webUrl stringByAppendingString:@"w=300"];
                compressionFactor = 1.0;
                break;
        }
        [DownloadManager downloadFileForURL:url withCompletionBlock:^(NSData *data) {
            NSString *fileName = [fileManager getFilenameFromStringURL:item.image.webUrl];
            NSString *filePath = [NSString stringWithFormat:@"/%@/%@", kPreviewImageDirestory, fileName];
            [fileManager createFileWithData:data atPath:filePath withCompressionFactor:compressionFactor withSandboxFolderType:kCaches];
            item.image.localPreviewUrl = filePath;
            UIImage *image = [fileManager getImageFromPath:item.image.localPreviewUrl withSandboxFolderType:kCaches];
            completionBlock(image);
        }];
    }
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

#pragma mark - Saving/Removing

- (void)saveItemToPersistent:(Item *)item completionBlock:(void(^)(void))completionBlock {
    if (item.persistentSourceType == kCoreData) return;
    
    self.item = [[Item alloc] initWithDictionary:item.sourceDictionary andSourceType:item.sourceType];;
    
    DownloadManager *downloadManager = [[DownloadManager alloc] init];
    downloadManager.delegate = self;
    [downloadManager downloadFileInBackgroundForURL:item.content.webUrl forItem:item];
    
    [DownloadManager downloadFileForURL:item.image.webUrl withCompletionBlock:^(NSData *data) {
        FileManager *fileManager = [FileManager sharedFileManager];
        ItemCoreDataService *itemCoreDataService = [[ItemCoreDataService alloc] init];
        NSString *fileName = [fileManager getFilenameFromStringURL:item.image.webUrl];
        NSString *filePath = [NSString stringWithFormat:@"/%@/%@", kFullSizeImageDirectory, fileName];
        [fileManager createFileWithData:data atPath:filePath withSandboxFolderType:kDocuments];
        self.item.image.localFullUrl = filePath;
        
        [itemCoreDataService saveNewItem:self.item];
        completionBlock();
    }];
}

+ (void)removeItemFromPersistent:(Item *)item completionBlock:(void (^)(void))completionBlock {
    ItemCoreDataService *itemCoreDataService = [[ItemCoreDataService alloc] init];
    FileManager *fileManager = [FileManager sharedFileManager];
    if ([fileManager fileIsExistForPath:item.content.localUrl withSandboxFolderType:kDocuments]) {
        [fileManager removeFileFromPath:item.content.localUrl withSandboxFolderType:kDocuments];
    }
    if ([fileManager fileIsExistForPath:item.image.localFullUrl withSandboxFolderType:kDocuments]) {
        [fileManager removeFileFromPath:item.image.localFullUrl withSandboxFolderType:kDocuments];
    }
    [itemCoreDataService removeItem:item];
    item.content.localUrl = @"";
    item.image.localFullUrl = @"";
    completionBlock();
}

@end
