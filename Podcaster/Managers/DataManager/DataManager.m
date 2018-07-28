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
#import "ItemCoreDataService.h"
#import "ItemCoreDataService.h"
#import "DataManager+Preparing.h"

@interface DataManager ()

@property (nonatomic) ItemCoreDataService *itemCoreDataService;

- (NSArray *)itemsSorting:(NSArray *)items;

@end

@implementation DataManager

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Fetching

- (void)fetchData:(id)sender {
    self.delegate = sender;
    
    self.tags = @[kItemEntityXMLFieldGUID,
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
    ItemCoreDataService *itemCoreDataService = [[ItemCoreDataService alloc] init];
    
    self.entitiesCoreDataItems = [itemCoreDataService fetchItemsToDictionary];
    [self.xmlParserServiceMP3 startParsing];
    [self.xmlParserServiceTED startParsing];
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
    if (self.entitiesTEDItems.count != 0 && self.entitiesMP3Items.count != 0) {
        NSArray *sortedItems = [self itemsSorting:self.items];
        [self.delegate itemsWasProcessed:sortedItems];
    } else {
        return;
    }
}

- (NSArray *)itemsSorting:(NSArray *)items {
    NSArray *sortedItems;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kItemPubDateAttributeName ascending:NO];
    sortedItems = [items sortedArrayUsingDescriptors:@[sortDescriptor]];
    return sortedItems;
}

@end
