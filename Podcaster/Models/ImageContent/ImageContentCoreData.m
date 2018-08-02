//
//  ImageContentCoreData.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/26/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ImageContentCoreData.h"

@implementation ImageContentCoreData

@dynamic localPreviewUrl;
@dynamic localFullUrl;
@dynamic webUrl;

- (instancetype)initWithImage:(ImageContent *)image andContext:(NSManagedObjectContext *)context {
    ImageContentCoreData *imageMO = [NSEntityDescription insertNewObjectForEntityForName:kImageEntityTitle inManagedObjectContext:context];
    [imageMO setValue:image.webUrl forKey:kImageWebLinkAttributeName];
    [imageMO setValue:image.localPreviewUrl forKey:kImagePreviewLocalLinkAttributeName];
    [imageMO setValue:image.localFullUrl forKey:kImageFullLocalLinkAttributeName];
    return imageMO;
}

@end
