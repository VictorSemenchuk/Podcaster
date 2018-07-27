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

NSString * const kItemEntityXMLFieldGUID = @"guid";
NSString * const kItemEntityXMLFieldTitle = @"title";
NSString * const kItemEntityXMLFieldAuthor = @"itunes:author";
NSString * const kItemEntityXMLFieldDetails = @"description";
NSString * const kItemEntityXMLFieldDuration = @"itunes:duration";
NSString * const kItemEntityXMLFieldPubDate = @"pubDate";
NSString * const kItemEntityXMLFieldImage = @"itunes:image";
NSString * const kItemEntityXMLFieldContent = @"enclosure";

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
const float kFontSizeHugeHeavy = 24.0;

#pragma mark - Assets

NSString * const kMP3ItemImagePlaceholder = @"MP3ItemImagePlaceholder";
NSString * const kTEDItemImagePlaceholder = @"TEDItemImagePlaceholder";
NSString * const kTEDItemImagePlaceholderHuge = @"TEDItemImagePlaceholderHuge";

#pragma mark - Paddings

const float kLeftRightPadding = 16.0;
const float kTopBottomPadding = 20.0;

#pragma mark - Padding

const float kMP3ImagePlaceholderWidth = 80.0;
const float kMP3ImagePlaceholderHeight = 80.0;
const float kTEDImagePlaceholderWidth = 140.0;
const float kTEDImagePlaceholderHeight = 80.0;

#pragma mark - Directories

NSString * const kPreviewImageDirestory = @"Previews";
NSString * const kFullSizeImageDirectory = @"Images";
