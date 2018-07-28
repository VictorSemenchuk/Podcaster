//
//  Item.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SourceType.h"
#import "ImageContent.h"
#import "MediaContent.h"
#import "PersistentSourceType.h"

@class ItemCoreData;
@interface Item : NSObject

@property (nonatomic) NSString *guId;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *author;
@property (nonatomic) NSString *details;
@property (nonatomic) NSString *duration;
@property (nonatomic) NSDate *pubDate;
@property (assign, nonatomic) SourceType sourceType;

@property (nonatomic) ImageContent *image;
@property (nonatomic) MediaContent *content;

@property (assign, nonatomic) PersistentSourceType persistentSourceType;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary andSourceType:(SourceType)sourceType;
- (instancetype)initWithMO:(ItemCoreData *)itemMO;

@end
