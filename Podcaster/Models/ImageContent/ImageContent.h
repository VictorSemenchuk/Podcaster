//
//  ImageContent.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ImageContentCoreData;
@interface ImageContent : NSObject

@property (nonatomic) NSString *localPreviewUrl;
@property (nonatomic) NSString *localFullUrl;
@property (nonatomic) NSString *webUrl;

- (instancetype)initWithWebUrl:(NSString *)webUrl localPreviewUrl:(NSString *)localPreviewUrl andLocalFullUrl:(NSString *)locatlFullUrl;
- (instancetype)initWithMO:(ImageContentCoreData *)imageMO;

@end
