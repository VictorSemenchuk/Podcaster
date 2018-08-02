//
//  Item.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
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
@property (assign, nonatomic) NSUInteger hashSum;

@property (nonatomic) ImageContent *image;
@property (nonatomic) MediaContent *content;

@property (nonatomic) UIImage *itemImage;

@property (assign, nonatomic) PersistentSourceType persistentSourceType;
@property (nonatomic) NSDictionary *sourceDictionary;

- (instancetype)initWithGUID:(NSString *)guid title:(NSString *)title author:(NSString *)author details:(NSString *)details duration:(NSString *)duration pubData:(NSDate *)pubDate;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary andSourceType:(SourceType)sourceType;
- (instancetype)initWithMO:(ItemCoreData *)itemMO;
- (NSUInteger)hashFunc;
- (void)loadPreviewImageWithCompletionBlock:(void(^)(UIImage *image))completionBlock;

@end
