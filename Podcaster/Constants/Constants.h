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

extern NSString * const kItemEntityFieldGUID;
extern NSString * const kItemEntityFieldTitle;
extern NSString * const kItemEntityFieldAuthor;
extern NSString * const kItemEntityFieldDetails;
extern NSString * const kItemEntityFieldDuration;
extern NSString * const kItemEntityFieldPubDate;
extern NSString * const kItemEntityFieldImage;
extern NSString * const kItemEntityFieldContent;

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

#pragma mark - Assets

extern NSString * const kMP3ItemImagePlaceholder;
extern NSString * const kTEDItemImagePlaceholder;

#pragma mark - Paddings

extern const float kCollectionViewLeftRightPadding;
extern const float kCollectionViewTopBottomPadding;

#pragma mark - Sizes

extern const float kMP3ImagePlaceholderWidth;
extern const float kMP3ImagePlaceholderHeight;
extern const float kTEDImagePlaceholderWidth;
extern const float kTEDImagePlaceholderHeight;

#endif /* Constants_h */
