//
//  Constants.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - Entity fields

NSString * const kItemEntityFieldGUID = @"guid";
NSString * const kItemEntityFieldTitle = @"title";
NSString * const kItemEntityFieldAuthor = @"itunes:author";
NSString * const kItemEntityFieldDetails = @"description";
NSString * const kItemEntityFieldDuration = @"itunes:duration";
NSString * const kItemEntityFieldPubDate = @"pubDate";
NSString * const kItemEntityFieldImage = @"itunes:image";
NSString * const kItemEntityFieldContent = @"enclosure";

#pragma mark - Data source links

NSString * const kMP3SourceTypeUrl = @"https://rss.simplecast.com/podcasts/4669/rss";
NSString * const kTEDSourceTypeUrl = @"http://feeds.feedburner.com/tedtalks_video";

#pragma mark - Cell identifiers

NSString * const kMP3CollectionViewCellIdentifier = @"kMP3CollectionViewCellIdentifier";

#pragma mark - Colors

//UIColor * const kFeedCollectionViewBGColor = [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:245.0/255.0 alpha:255.0/255.0];
