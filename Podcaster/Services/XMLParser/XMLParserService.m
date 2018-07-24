//
//  XMLParserService.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "XMLParserService.h"
#import "Item.h"

@interface XMLParserService () <XMLParserDelegate>

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
        _parser = [[XMLParser alloc] initWithTags:tags rssUrl:rssUrl];
    }
    return self;
}

#pragma mark - Methods

- (void)startParsing {
    self.parser.delegate = self;
    [self.parser startParsing];
}

#pragma mark - XMLParserDelegate

- (void)wasParsedData:(NSArray *)data {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSDictionary *item in data) {
        Item *modelItem = [[Item alloc] initWithDictionary:item andSourceType:self.sourceType];
        [items addObject:modelItem];
    }
    [self.delegate wasParsedItems:items forSourceType:self.sourceType];
}

@end
