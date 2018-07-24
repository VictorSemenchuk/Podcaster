//
//  XMLParserService.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLParser.h"
#import "SourceType.h"

@protocol XMLParserServiceDelegate <NSObject>

- (void)wasParsedItems:(NSArray *)items forSourceType:(SourceType)sourceType;

@end

@interface XMLParserService : NSObject

@property (weak, nonatomic) id<XMLParserServiceDelegate> delegate;

- (instancetype)initWithSourceType:(SourceType)sourceType tags:(NSArray *)tags rssUrl:(NSString *)rssUrl;
- (void)startParsing;

@end
