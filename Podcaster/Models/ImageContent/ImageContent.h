//
//  ImageContent.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImageContentCoreData;
@interface ImageContent : NSObject

@property (nonatomic) NSString *localUrl;
@property (nonatomic) NSString *webUrl;

- (instancetype)initWithWebUrl:(NSString *)webUrl andLocalUrl:(NSString *)localUrl;
- (instancetype)initWithMO:(ImageContentCoreData *)imageMO;

@end
