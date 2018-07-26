//
//  Item.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SourceType.h"
//#import "ImageContentCoreData.h"
#import "MediaContentCoreData.h"

@interface ItemCoreData : NSManagedObject

@property (nonatomic) NSString *guid;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *author;
@property (nonatomic) NSString *details;
@property (nonatomic) NSString *duration;
@property (nonatomic) NSDate *pubDate;
@property (nonatomic) NSUInteger sourceType;

//@property (nonatomic) ImageContentCoreData *image;
@property (nonatomic) MediaContentCoreData *content;

@end
