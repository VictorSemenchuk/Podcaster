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
NSString * const kTEDCollectionViewCellIdentifier = @"kTEDCollectionViewCellIdentifier";

#pragma mark - Font sizes

const float kFontSizeSmall = 11.0;
const float kFontSizeRegular = 12.0;
const float kFontSizeHeavy = 14.0;
const float kFontSizeHuge = 16.0;

#pragma mark - Assets

NSString * const kMP3ItemImagePlaceholder = @"MP3ItemImagePlaceholder";
NSString * const kTEDItemImagePlaceholder = @"TEDItemImagePlaceholder";

#pragma mark - Paddings

const float kCollectionViewLeftRightPadding = 10.0;
const float kCollectionViewTopBottomPadding = 10.0;

#pragma mark - Padding

const float kMP3ImagePlaceholderWidth = 60.0;
const float kMP3ImagePlaceholderHeight = 60.0;
const float kTEDImagePlaceholderWidth = 106.0;
const float kTEDImagePlaceholderHeight = 60.0;
