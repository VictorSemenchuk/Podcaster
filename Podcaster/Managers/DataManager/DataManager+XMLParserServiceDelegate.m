//
//  DataManager+XMLParserServiceDelegate.m
//  Podcaster
//
//  Created by Victor Macintosh on 28/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DataManager+XMLParserServiceDelegate.h"

@implementation DataManager (XMLParserServiceDelegate)

- (void)wasParsedItems:(NSArray *)items forSourceType:(SourceType)sourceType {
    NSArray *loadedItems = items;
    switch (sourceType) {
        case kMP3:
            self.entitiesMP3Items = items;
            break;
        case kTED:
            self.entitiesTEDItems = items;
            break;
        default:
            break;
    }
    for (Item *item in loadedItems) {
        if (self.entitiesCoreDataItems[item.guid]) {
            [self.items addObject:self.entitiesCoreDataItems[item.guid]];
        } else {
            [self.items addObject:item];
        }
    }
    [self processItems];
}

@end
