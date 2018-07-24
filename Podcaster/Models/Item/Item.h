//
//  Item.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SourceType.h"

@interface Item : NSObject

@property (nonatomic) NSString *guId;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *author;
@property (nonatomic) NSString *details;
@property (nonatomic) NSString *duration;
@property (nonatomic) NSString *pubDate;
@property (assign, nonatomic) SourceType sourceType;

@property (nonatomic) NSString *imageWebLink;
@property (nonatomic) NSString *contentWebLink;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary andSourceType:(SourceType)sourceType;

@end
