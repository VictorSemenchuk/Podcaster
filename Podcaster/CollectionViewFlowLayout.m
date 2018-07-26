//
//  CollectionViewFlowLayout.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/26/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "CollectionViewFlowLayout.h"

@implementation CollectionViewFlowLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
