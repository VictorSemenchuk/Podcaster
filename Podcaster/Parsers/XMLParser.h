//
//  XMLParser.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SourceType.h"

@protocol XMLParserDelegate <NSObject>

- (void)wasParsedXMLForSourceType:(SourceType)sourceType data:(NSArray *)data;

@end

@interface XMLParser : NSObject

@property (weak, nonatomic) id<XMLParserDelegate> delegate;

- (instancetype)initWithTags:(NSArray *)tags rssUrl:(NSString *)stringUrl;
- (instancetype)initWithTags:(NSArray *)tags rssUrl:(NSString *)stringUrl sourceType:(SourceType)sourceType;
- (void)startParsing;

@end
