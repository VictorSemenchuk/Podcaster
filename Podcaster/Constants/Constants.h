//
//  Constants.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef Constants_h
#define Constants_h

#pragma mark - Entity fields

extern NSString * const kItemEntityXMLFieldGUID;
extern NSString * const kItemEntityXMLFieldTitle;
extern NSString * const kItemEntityXMLFieldAuthor;
extern NSString * const kItemEntityXMLFieldDetails;
extern NSString * const kItemEntityXMLFieldDuration;
extern NSString * const kItemEntityXMLFieldPubDate;
extern NSString * const kItemEntityXMLFieldImage;
extern NSString * const kItemEntityXMLFieldContent;

#pragma mark - Data source links

extern NSString * const kMP3SourceTypeUrl;
extern NSString * const kTEDSourceTypeUrl;

#pragma mark - Cell identifiers

extern NSString * const kMP3CollectionViewCellIdentifier;
extern NSString * const kTEDCollectionViewCellIdentifier;

#pragma mark - Font sizes

extern const float kFontSizeSmall;
extern const float kFontSizeRegular;
extern const float kFontSizeHeavy;
extern const float kFontSizeHuge;
extern const float kFontSizeHugeHeavy;

#pragma mark - Assets

extern NSString * const kMP3ItemImagePlaceholder;
extern NSString * const kTEDItemImagePlaceholder;
extern NSString * const kTEDItemImagePlaceholderHuge;

#pragma mark - Paddings

extern const float kLeftRightPadding;
extern const float kTopBottomPadding;

#pragma mark - Sizes

extern const float kMP3ImagePlaceholderWidth;
extern const float kMP3ImagePlaceholderHeight;
extern const float kTEDImagePlaceholderWidth;
extern const float kTEDImagePlaceholderHeight;

#pragma mark - Directories

extern NSString * const kPreviewImageDirestory;
extern NSString * const kFullSizeImageDirectory;
extern NSString * const kVideoDirectory;
extern NSString * const kAudioDirectory;

#pragma mark - Keys for UserDefaults

extern NSString * const kUserDefaultsMP3SourceKey;
extern NSString * const kUserDefaultsTEDSourceKey;
extern NSString * const kUserDefaultsOfflineModeKey;

#endif /* Constants_h */
