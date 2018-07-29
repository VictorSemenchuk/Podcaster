//
//  ImageContent.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ImageContent.h"
#import "ImageContentCoreData.h"

@implementation ImageContent

- (instancetype)initWithWebUrl:(NSString *)webUrl localPreviewUrl:(NSString *)localPreviewUrl andLocalFullUrl:(NSString *)localFullUrl {
    self = [super init];
    if (self) {
        _webUrl = webUrl;
        _localPreviewUrl = localPreviewUrl;
        _localFullUrl = localFullUrl;
    }
    return self;
}

- (instancetype)initWithMO:(ImageContentCoreData *)imageMO {
    self = [super init];
    if (self) {
        _webUrl = imageMO.webUrl;
        _localPreviewUrl = imageMO.localPreviewUrl;
        _localFullUrl = imageMO.localFullUrl;
    }
    return self;
}

@end
