//
//  ViewController.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ViewController.h"
#import "XMLParserService.h"
#import "Constants.h"
#import "SourceType.h"
#import "Item.h"

@interface ViewController () <XMLParserServiceDelegate>

@property (nonatomic) XMLParserService *xmlParserService;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.redColor;
    self.xmlParserService = [[XMLParserService alloc] initWithSourceType:kMP3
                                                                                 tags:@[kItemEntityFieldTitle,
                                                                                        kItemEntityFieldAuthor,
                                                                                        kItemEntityFieldDetails,
                                                                                        kItemEntityFieldDuration,
                                                                                        kItemEntityFieldPubDate
                                                                                        ]
                                                                               rssUrl:kMP3SourceTypeUrl];
    self.xmlParserService.delegate = self;
    [self.xmlParserService startParsing];
}

#pragma mark - XMLParserServiceDelegate

- (void)wasParsedItems:(NSArray *)items {
    for (Item *item in items) {
        NSLog(@"%@", item);
    }
}

@end
