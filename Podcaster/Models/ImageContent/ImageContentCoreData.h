//
//  ImageContentCoreData.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/26/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ImageContent.h"
#import "EntitiesConstants.h"

@interface ImageContentCoreData : NSManagedObject

@property (nonatomic) NSString *localPreviewUrl;
@property (nonatomic) NSString *localFullUrl;
@property (nonatomic) NSString *webUrl;

- (instancetype)initWithImage:(ImageContent *)image andContext:(NSManagedObjectContext *)context;

@end
