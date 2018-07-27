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

@property (nonatomic) NSString *localUrl;
@property (nonatomic) NSString *webUrl;

@property (nonatomic) UIImage *image;

- (instancetype)initWithWebUrl:(NSString *)webUrl andLocalUrl:(NSString *)localUrl;
- (instancetype)initWithMO:(ImageContentCoreData *)imageMO;

@end
