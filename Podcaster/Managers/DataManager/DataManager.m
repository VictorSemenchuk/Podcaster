//
//  DataManager.m
//  Podcaster
//
//  Created by Victor Macintosh on 28/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DataManager.h"
#import "FileManager.h"
#import "DownloadManager.h"
#import "DataManager+Preparing.h"

@interface DataManager ()

- (NSArray *)itemsSorting:(NSArray *)items;

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
    
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(dispatchGroup, queue, ^{
        [self.itemCoreDataService fetchItemsToDictionaryWithCompletionBlock:^(NSMutableDictionary *items) {
            self.entitiesCoreDataItems = items;
        }];
    });
    dispatch_group_enter(dispatchGroup);
    dispatch_group_async(dispatchGroup, queue, ^{
        [self.xmlParserServiceMP3 startParsing:^(NSArray *items) {
            self.entitiesMP3Items = items;
            dispatch_group_leave(dispatchGroup);
        }];
    });
    dispatch_group_enter(dispatchGroup);
    dispatch_group_async(dispatchGroup, queue, ^{
        [self.xmlParserServiceTED startParsing:^(NSArray *items) {
            self.entitiesTEDItems = items;
            dispatch_group_leave(dispatchGroup);
        }];
    });
    
    dispatch_group_notify(dispatchGroup, queue, ^{
        [self processItems];
    });
    
}

- (void)refetchData {
    [self.itemCoreDataService fetchItemsToDictionaryWithCompletionBlock:^(NSMutableDictionary *items) {
        self.entitiesCoreDataItems = items;
    }];
    [self processItems];
}

+ (void)getPreviewImageForItem:(Item *)item completionBlock:(void (^)(UIImage *))completionBlock {
    FileManager *fileManager = [FileManager sharedFileManager];
    if (![item.image.localUrl isEqualToString:@""]) {
        UIImage *image = [fileManager getImageFromPath:item.image.localUrl withSandboxFolderType:kCaches];
        completionBlock(image);
    } else {
        DownloadManager *downloadManager = [[DownloadManager alloc] init];
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
        [downloadManager downloadFileForURL:url withCompletionBlock:^(NSData *data) {
            NSString *fileName = [fileManager getFilenameFromStringURL:item.image.webUrl];
            NSString *filePath = [NSString stringWithFormat:@"/%@/%@", kPreviewImageDirestory, fileName];
            [fileManager createFileWithData:data atPath:filePath withCompressionFactor:compressionFactor withSandboxFolderType:kCaches];
            item.image.localUrl = filePath;
            UIImage *image = [fileManager getImageFromPath:item.image.localUrl withSandboxFolderType:kCaches];
            completionBlock(image);
        }];
    }
}

#pragma mark - Item processing

- (void)processItems {
    self.items = [[NSMutableArray alloc] init];
    if (self.entitiesMP3Items.count != 0) {
        [self comparationRemoteItems:self.entitiesMP3Items withLocalItems:self.entitiesCoreDataItems];
    }
    if (self.entitiesTEDItems.count != 0) {
        [self comparationRemoteItems:self.entitiesTEDItems withLocalItems:self.entitiesCoreDataItems];
    }
    [self.items addObjectsFromArray:self.entitiesCoreDataItems.allValues];
    NSArray *sortedItems = [self itemsSorting:self.items];
    [self.delegate dataWasFetched:sortedItems];
}

- (void)comparationRemoteItems:(NSArray *)remoteItems withLocalItems:(NSMutableDictionary *)localItems {
    for (Item *item in remoteItems) {
        if (localItems[item.guId]) {
            [self.items addObject:localItems[item.guId]];
            [self.entitiesCoreDataItems removeObjectForKey:item.guId];
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

@end
