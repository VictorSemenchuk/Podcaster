//
//  DataManager+Preparing.m
//  Podcaster
//
//  Created by Victor Macintosh on 28/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DataManager+Preparing.h"
#import "DataManager+XMLParserServiceDelegate.h"

@implementation DataManager (Preparing)

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

- (void)setupXMLServiceForSourceType:(SourceType)sourceType {
    NSString *url = [self getUrlForSourceType:sourceType];
    switch (sourceType) {
        case kMP3:
            self.xmlParserServiceMP3 = [[XMLParserService alloc] initWithSourceType:sourceType
                                                                               tags:self.tags
                                                                             rssUrl:url];
            self.entitiesMP3Items = [[NSArray alloc] init];
            break;
        case kTED:
            self.xmlParserServiceTED = [[XMLParserService alloc] initWithSourceType:sourceType
                                                                               tags:self.tags
                                                                             rssUrl:url];
            self.entitiesTEDItems = [[NSArray alloc] init];
            break;
        default:
            break;
    }
}

@end
