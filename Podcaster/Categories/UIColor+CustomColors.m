//
//  UIColor+CustomColors.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/25/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "UIColor+CustomColors.h"

@implementation UIColor (CustomColors)

+ (UIColor *)lightGrayColorVS {
    return [UIColor colorWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:255.0/255.0];
}

+ (UIColor *)darkGrayColorVS {
    return [UIColor colorWithRed:41.0/255.0 green:41.0/255.0 blue:41.0/255.0 alpha:255.0/255.0];
}

+ (UIColor *)collectionViewBGColorVS {
    return [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:245.0/255.0 alpha:255.0/255.0];
}

+ (UIColor *)separatorColor {
    return [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:255.0/255.0];
}

@end
