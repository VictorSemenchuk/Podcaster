//
//  ItemProtocol.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SourceType.h"

@protocol ItemProtocol <NSObject>

@property (nonatomic) NSString *guid;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *author;
@property (nonatomic) NSString *details;
@property (nonatomic) NSString *duration;
@property (nonatomic) NSDate *pubDate;
@property (nonatomic) NSUInteger hashSum;
@property (nonatomic) SourceType sourceType;

@property (nonatomic) ImageContentCoreData *image;
@property (nonatomic) MediaContentCoreData *content;

@end
