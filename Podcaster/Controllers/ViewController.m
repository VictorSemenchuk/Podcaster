//
//  ViewController.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ViewController.h"
#import "XMLParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.redColor;
    XMLParser *xmlParser = [[XMLParser alloc] initWithTags:@[@"title",
                                                             @"author",
                                                             @"description",
                                                             @"itunes:duration",
                                                             @"pubDate"]
                                                    rssUrl:@"https://rss.simplecast.com/podcasts/4669/rss"];
    [xmlParser startParsing];
    
}

@end
