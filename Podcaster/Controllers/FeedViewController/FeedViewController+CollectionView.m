//
//  FeedViewController+CollectionView.m
//  Podcaster
//
//  Created by Victor Macintosh on 24/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FeedViewController+CollectionView.h"
#import "MP3CollectionViewCell.h"

@implementation FeedViewController (CollectionView)

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.entitiesMP3Items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MP3CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMP3CollectionViewCellIdentifier forIndexPath:indexPath];
    [cell setValueForItem:self.entitiesMP3Items[indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate/FlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.bounds.size.width - 20.0, 80.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

@end
