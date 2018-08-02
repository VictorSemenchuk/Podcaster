//
//  XMLParserService.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "XMLParserService.h"
#import "Item.h"
#import "DataManager.h"
#import "EntitiesConstants.h"

@interface XMLParserService ()

@property (assign, nonatomic) SourceType sourceType;
@property (nonatomic) NSArray *tags;
@property (nonatomic) NSString *rssUrl;
@property (nonatomic) XMLParser *parser;

@end

@implementation XMLParserService

#pragma mark - Inits

- (instancetype)initWithSourceType:(SourceType)sourceType tags:(NSArray *)tags rssUrl:(NSString *)rssUrl {
    self = [super init];
    if (self) {
        _sourceType = sourceType;
        _tags = tags;
        _rssUrl = rssUrl;
    }
    return self;
}

#pragma mark - Methods

- (void)startParsing:(void (^)(NSArray *))completionBlock {
    _parser = [[XMLParser alloc] initWithTags:self.tags rssUrl:self.rssUrl];
    [self.parser startParsing:^(NSArray *data) {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (NSDictionary *item in data) {
            Item * modelItem = [[Item alloc] initWithDictionary:item andSourceType:self.sourceType];
            [items addObject:modelItem];
        }
        completionBlock([items copy]);
    }];
}

#pragma mark - XMLParserDelegate

- (void)wasParsedData:(NSArray *)data {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSDictionary *item in data) {
        Item * modelItem = [[Item alloc] initWithDictionary:item andSourceType:self.sourceType];
        [items addObject:modelItem];
    }
}

@end
