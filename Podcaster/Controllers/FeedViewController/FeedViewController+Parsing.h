//
//  FeedViewController+Parsing.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FeedViewController.h"
#import "XMLParserService.h"
#import "SourceType.h"

@interface FeedViewController (Parsing) <XMLParserServiceDelegate>

- (void)setupXMLServiceForSourceType:(SourceType)sourceType;
- (NSString *)getUrlForSourceType:(SourceType)sourceType;

@end
