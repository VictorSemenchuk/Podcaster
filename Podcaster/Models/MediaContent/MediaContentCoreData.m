//
//  MediaContentCoreData.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "MediaContentCoreData.h"

@implementation MediaContentCoreData

@dynamic localUrl;
@dynamic webUrl;

- (instancetype)initWithContent:(MediaContent *)content andContext:(NSManagedObjectContext *)context {
    MediaContentCoreData *contentMO = [NSEntityDescription insertNewObjectForEntityForName:kContentEntityTitle inManagedObjectContext:context];
    [contentMO setValue:content.webUrl forKey:kContentWebLinkAttributeName];
    [contentMO setValue:content.localUrl forKey:kContentLocalLinkAttributeName];
    return contentMO;
}

@end
