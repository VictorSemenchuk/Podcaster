//
//  XMLParser.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "XMLParser.h"
#import "DownloadManager.h"

@interface XMLParser () <NSXMLParserDelegate>

@property (nonatomic) NSXMLParser *parser;
@property (nonatomic) NSString *element;
@property (nonatomic) NSString *itemName;

@property (nonatomic) NSArray *tags;
@property (nonatomic) NSString *stringUrl;
@property (nonatomic) NSMutableArray *items;
@property (nonatomic) NSMutableDictionary *item;

- (void)resetResults;

@end

@implementation XMLParser

#pragma mark - Inits

- (instancetype)initWithTags:(NSArray *)tags rssUrl:(NSString *)stringUrl {
    self = [super init];
    if (self) {
        _tags = tags;
        _stringUrl = stringUrl;
    }
    return self;
}

#pragma mark - Methods

- (void)startParsing:(void (^)(NSArray *))completionBlock {
    [self resetResults];
    [DownloadManager downloadXMLFileFormURL:self.stringUrl withCompletionBlock:^(NSData *data) {
        self.parser = [[NSXMLParser alloc] initWithData:data];
        self.parser.delegate = self;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            BOOL flag = [self.parser parse];
            if (flag) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock([self.items copy]);
                });
            }
        });
    }];
}

- (void)resetResults {
    self.items = [[NSMutableArray alloc] init];
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    self.element = elementName;
    if ([self.element isEqualToString:@"item"]) {
        self.item = [[NSMutableDictionary alloc] init];
        self.itemName = self.element;
    } else if (([self.tags containsObject:self.element]) && ([attributeDict.allKeys count] > 0)) {
        self.item[self.element] = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([string isEqualToString:@"Compassionate Coding with April Wensel"]) {
        NSLog(@"Wooray");
    }
    if ([self.itemName isEqualToString:@"item"]) {
        for (NSString *tag in self.tags) {
            if ([self.element isEqualToString:tag]) {
                if (self.item[tag] == nil) {
                    self.item[tag] = [[NSMutableString alloc] init];
                    [self.item[tag] appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
                } else if (([self.item[tag] isKindOfClass:NSMutableDictionary.class]) && ([tag isEqualToString:@"guid"])) {
                    if (self.item[tag][@"value"] != nil) {
                        return;
                    }
                    self.item[tag][@"value"] = [[NSMutableString alloc] init];
                    [self.item[tag][@"value"] appendString:string];
                }
            }
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"item"]) {
        self.itemName = @"";
        [self.items addObject:self.item];
    }
}

@end
