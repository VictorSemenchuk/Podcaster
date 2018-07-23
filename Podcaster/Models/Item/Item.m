//
//  Item.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "Item.h"
#import "Constants.h"

@implementation Item

- (instancetype)initWithDictionary:(NSDictionary *)dictionary andSourceType:(SourceType)sourceType {
    self = [super init];
    if (self) {
        _sourceType = sourceType;
        _title = dictionary[kItemEntityFieldTitle];
        _author = dictionary[kItemEntityFieldAuthor];
        _details = [dictionary[kItemEntityFieldDetails] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _duration = dictionary[kItemEntityFieldDuration];
        _pubDate = dictionary[kItemEntityFieldPubDate];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Title: %@, author: %@, details: %@, duration: %@, pubDate: %@, sourceType: %d", self.title, self.author, self.details, self.duration, self.pubDate, self.sourceType];
}

@end
