//
//  XMLParser.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "XMLParser.h"

@interface XMLParser () <NSXMLParserDelegate>

@property (nonatomic) NSXMLParser *parser;
@property (nonatomic) NSString *element;

@property (assign, nonatomic) SourceType sourceType;
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

- (instancetype)initWithTags:(NSArray *)tags rssUrl:(NSString *)stringUrl sourceType:(SourceType)sourceType {
    self = [super init];
    if (self) {
        _tags = tags;
        _stringUrl = stringUrl;
        _sourceType = sourceType;
    }
    return self;
}

#pragma mark - Methods

- (void)startParsing {
    [self resetResults];
    NSURL *url = [NSURL URLWithString:self.stringUrl];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"Source file location: %@", location);
            NSData *data = [NSData dataWithContentsOfURL:location];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.parser = [[NSXMLParser alloc] initWithData:data];
                self.parser.delegate = self;
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_async(queue, ^{
                    [self.parser parse];
                });
            });
        } else {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
        [session invalidateAndCancel];
    }];
    [task resume];
}

- (void)resetResults {
    self.items = [[NSMutableArray alloc] init];
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    self.element = elementName;
    if ([self.element isEqualToString:@"item"]) {
        self.item = [[NSMutableDictionary alloc] init];
        for (NSString *tag in self.tags) {
            self.item[tag] = [[NSMutableString alloc] init];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    for (NSString *tag in self.tags) {
        if ([self.element isEqualToString:tag]) {
            [self.item[tag] appendString:string];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"item"]) {
        [self.items addObject:self.item];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"%lu", self.items.count);
    if (self.delegate) {
        [self.delegate wasParsedXMLForSourceType:self.sourceType data:[self.items copy]];
    }
}


@end
