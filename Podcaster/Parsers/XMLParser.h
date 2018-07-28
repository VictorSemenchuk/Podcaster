//
//  XMLParser.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLParser : NSObject

- (instancetype)initWithTags:(NSArray *)tags rssUrl:(NSString *)stringUrl;
- (void)startParsing:(void(^)(NSArray *data))completionBlock;

@end
