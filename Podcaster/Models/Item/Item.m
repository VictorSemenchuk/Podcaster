//
//  Item.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "Item.h"
#import "Constants.h"
#import "DateFormatter.h"
#import "ItemCoreData.h"
#import "FileManager.h"
#import "Constants.h"

@implementation Item

- (instancetype)initWithGUID:(NSString *)guid title:(NSString *)title author:(NSString *)author details:(NSString *)details duration:(NSString *)duration pubData:(NSDate *)pubDate {
    self = [super init];
    if (self) {
        _guId = guid;
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
        _guId = dictionary[kItemEntityXMLFieldGUID][@"value"];
        _title = dictionary[kItemEntityXMLFieldTitle];
        _author = dictionary[kItemEntityXMLFieldAuthor];
        _details = dictionary[kItemEntityXMLFieldDetails];
        _duration = dictionary[kItemEntityXMLFieldDuration];
        _pubDate = [DateFormatter getDateFromString:dictionary[kItemEntityXMLFieldPubDate] byFormat:@"E, dd MMM yyyy HH:mm:ss Z"];
        
        NSString *imageWebLink = dictionary[kItemEntityXMLFieldImage][@"href"];
        _image = [[ImageContent alloc] initWithWebUrl:imageWebLink localPreviewUrl:[[FileManager sharedFileManager] localFilePathForWebURL:imageWebLink atDirectory:kPreviewImageDirestory withSandboxFolderType:kCaches] andLocalFullUrl:@""];
        
        NSString *contentWebLink = dictionary[kItemEntityXMLFieldContent][@"url"];
        _content = [[MediaContent alloc] initWithWebUrl:contentWebLink andLocalUrl:@""];
        
        _persistentSourceType = kRemote;
        _hashSum = [self hashFunc];
    }
    return self;
}

- (instancetype)initWithMO:(ItemCoreData *)itemMO {
    self = [super init];
    if (self) {
        _guId = itemMO.guid;
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

- (NSUInteger)hashFunc {
    return [self.guId hash] ^ [self.title hash] ^ [self.author hash] ^ [self.details hash] ^ [self.duration hash] ^ [self.pubDate hash];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"GUID: %@,\n title: %@,\n author: %@,\n details: %@,\n duration: %@,\n pubDate: %@,\n sourceType: %d,\n", self.guId, self.title, self.author, self.details, self.duration, self.pubDate, self.sourceType];
}

@end
