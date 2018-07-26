//
//  MediaContent.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "MediaContent.h"

@implementation MediaContent

- (instancetype)initWithMO:(MediaContentCoreData *)contentMO {
    self = [super init];
    if (self) {
        _webUrl = contentMO.webUrl;
        _localUrl = contentMO.localUrl;
    }
    return self;
}

@end
