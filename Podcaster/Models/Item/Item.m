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

@implementation Item

- (instancetype)initWithDictionary:(NSDictionary *)dictionary andSourceType:(SourceType)sourceType {
    self = [super init];
    if (self) {
        _sourceType = sourceType;
        _guId = dictionary[kItemEntityFieldGUID][@"value"];
        _title = dictionary[kItemEntityFieldTitle];
        _author = dictionary[kItemEntityFieldAuthor];
        _details = dictionary[kItemEntityFieldDetails];
        _duration = dictionary[kItemEntityFieldDuration];
        _imageWebLink = dictionary[kItemEntityFieldImage][@"href"];
        _contentWebLink = dictionary[kItemEntityFieldContent][@"url"];
        _pubDate = [DateFormatter getDateFromString:dictionary[kItemEntityFieldPubDate] byFormat:@"E, dd MMM yyyy HH:mm:ss Z"];
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
        //_image = [[ImageContent alloc] initWithMO:itemMO.image];
        _content = [[MediaContent alloc] initWithMO:itemMO.content];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"GUID: %@,\n title: %@,\n author: %@,\n details: %@,\n duration: %@,\n pubDate: %@,\n sourceType: %d,\n imageWebLink: %@,\n contentWebLink: %@\n-----------\n", self.guId, self.title, self.author, self.details, self.duration, self.pubDate, self.sourceType, self.imageWebLink, self.contentWebLink];
}

@end
