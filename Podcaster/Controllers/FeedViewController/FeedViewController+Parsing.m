//
//  FeedViewController+Parsing.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FeedViewController+Parsing.h"

@implementation FeedViewController (Parsing)

- (void)setupXMLServiceForSourceType:(SourceType)sourceType {
    NSString *url = [self getUrlForSourceType:sourceType];
    switch (sourceType) {
        case kMP3:
            self.xmlParserServiceMP3 = [[XMLParserService alloc] initWithSourceType:sourceType
                                                                               tags:self.tags
                                                                             rssUrl:url];
            self.xmlParserServiceMP3.delegate = self;
            break;
        case kTED:
            self.xmlParserServiceTED = [[XMLParserService alloc] initWithSourceType:sourceType
                                                                               tags:self.tags
                                                                             rssUrl:url];
            self.xmlParserServiceTED.delegate = self;
            break;
        default:
            break;
    }
}

- (NSString *)getUrlForSourceType:(SourceType)sourceType {
    NSString *url = @"";
    switch (sourceType) {
        case kMP3:
            url = kMP3SourceTypeUrl;
            break;
        case kTED:
            url = kTEDSourceTypeUrl;
            break;
        default:
            break;
    }
    return url;
}

#pragma mark - XMLParserServiceDelegate

- (void)wasParsedItems:(NSArray *)items forSourceType:(SourceType)sourceType {
    switch (sourceType) {
        case kMP3:
            self.entitiesMP3Items = items;
            NSLog(@"kMP3 count = %lu", [self.entitiesMP3Items count]);
            break;
        case kTED:
            self.entitiesTEDItems = items;
            NSLog(@"kTED count = %lu", [self.entitiesTEDItems count]);
            break;
        default:
            break;
    }
}

@end
