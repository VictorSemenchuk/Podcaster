//
//  DataManager+Fetching.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DataManager+Fetching.h"
#import "ItemCoreDataService+Fetching.h"
#import "UIImage+Getting.h"

@implementation DataManager (Fetching)

#pragma mark - Fetching

- (void)refetchData {
    [self fetchData];
}

- (void)fetchData:(id)sender {
    self.delegate = sender;
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
    if (![item.image.localPreviewUrl isEqualToString:@""]) {
        UIImage *image = [UIImage getImageFromPath:item.image.localPreviewUrl withSandboxFolderType:kCaches];
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
            FileManager *fileManager = [FileManager sharedFileManager];
            NSString *fileName = [fileManager getFilenameFromStringURL:item.image.webUrl];
            NSString *filePath = [NSString stringWithFormat:@"/%@/%@", kPreviewImageDirestory, fileName];
            [fileManager createFileWithData:data atPath:filePath withCompressionFactor:compressionFactor withSandboxFolderType:kCaches];
            item.image.localPreviewUrl = filePath;
            UIImage *image = [UIImage getImageFromPath:item.image.localPreviewUrl withSandboxFolderType:kCaches];
            completionBlock(image);
        }];
    }
}


@end
