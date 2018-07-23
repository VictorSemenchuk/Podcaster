//
//  XMLParser.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XMLParserDelegate <NSObject>

- (void)wasParsedData:(NSArray *)data;

@end

@interface XMLParser : NSObject

@property (weak, nonatomic) id<XMLParserDelegate> delegate;

- (instancetype)initWithTags:(NSArray *)tags rssUrl:(NSString *)stringUrl;
- (void)startParsing;

@end
