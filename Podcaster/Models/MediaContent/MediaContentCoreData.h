//
//  MediaContentCoreData.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "EntitiesConstants.h"
#import "MediaContent.h"

@interface MediaContentCoreData : NSManagedObject

@property (nonatomic) NSString *localUrl;
@property (nonatomic) NSString *webUrl;

- (instancetype)initWithContent:(MediaContent *)content andContext:(NSManagedObjectContext *)context;

@end
