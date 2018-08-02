//
//  Item.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "Item.h"
#import "Constants.h"
#import "NSDate+Format.h"
#import "ItemCoreData.h"
#import "FileManager.h"
#import "Constants.h"
#import "DataManager+Fetching.h"

@implementation Item

#pragma mark - Inits

- (instancetype)initWithGUID:(NSString *)guid title:(NSString *)title author:(NSString *)author details:(NSString *)details duration:(NSString *)duration pubData:(NSDate *)pubDate {
    self = [super init];
    if (self) {
        _guid = guid;
        _title = title;
        _author = author;
        _details = details;
        _duration = duration;
        pubDate = pubDate;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary andSourceType:(SourceType)sourceType {
    self = [super init];
    if (self) {
        _sourceType = sourceType;
        _guid = dictionary[kItemEntityXMLFieldGUID][@"value"];
        _title = dictionary[kItemEntityXMLFieldTitle];
        _author = dictionary[kItemEntityXMLFieldAuthor];
        _details = dictionary[kItemEntityXMLFieldDetails];
        _duration = dictionary[kItemEntityXMLFieldDuration];
        _pubDate = [NSDate dateWithFormat:@"E, dd MMM yyyy HH:mm:ss Z" fromString:dictionary[kItemEntityXMLFieldPubDate]];
        
        NSString *imageWebLink = dictionary[kItemEntityXMLFieldImage][@"href"];
        _image = [[ImageContent alloc] initWithWebUrl:imageWebLink localPreviewUrl:[[FileManager sharedFileManager] localFilePathForWebURL:imageWebLink atDirectory:kPreviewImageDirestory withSandboxFolderType:kCaches] andLocalFullUrl:@""];
        
        NSString *contentWebLink = dictionary[kItemEntityXMLFieldContent][@"url"];
        _content = [[MediaContent alloc] initWithWebUrl:contentWebLink andLocalUrl:@""];
        
        _persistentSourceType = kRemote;
        _hashSum = [self hashFunc];
        _sourceDictionary = dictionary;
    }
    return self;
}

- (instancetype)initWithMO:(ItemCoreData *)itemMO {
    self = [super init];
    if (self) {
        _guid = itemMO.guid;
        _title = itemMO.title;
        _author = itemMO.author;
        _details = itemMO.details;
        _duration = itemMO.duration;
        _pubDate = itemMO.pubDate;
        _sourceType = (SourceType)itemMO.sourceType;
        _hashSum = itemMO.hashSum;
        _image = [[ImageContent alloc] initWithMO:itemMO.image];
        _content = [[MediaContent alloc] initWithMO:itemMO.content];
        
        _persistentSourceType = kCoreData;
    }
    return self;
}

#pragma mark - Methods

- (NSUInteger)hashFunc {
    return [self.guid hash] ^ [self.title hash] ^ [self.author hash] ^ [self.details hash] ^ [self.duration hash] ^ [self.pubDate hash];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"GUID: %@,\n title: %@,\n author: %@,\n details: %@,\n duration: %@,\n pubDate: %@,\n sourceType: %d,\n", self.guid, self.title, self.author, self.details, self.duration, self.pubDate, self.sourceType];
}

- (void)loadPreviewImageWithCompletionBlock:(void (^)(UIImage *))completionBlock {
    [DataManager getPreviewImageForItem:self completionBlock:^(UIImage *image) {
        completionBlock(image);
    }];
}

@end
