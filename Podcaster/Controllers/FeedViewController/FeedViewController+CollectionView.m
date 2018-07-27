//
//  FeedViewController+CollectionView.m
//  Podcaster
//
//  Created by Victor Macintosh on 24/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FeedViewController+CollectionView.h"
#import "MP3CollectionViewCell.h"
#import "TEDCollectionViewCell.h"
#import "ItemCoreDataService.h"

@implementation FeedViewController (CollectionView)

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.entitiesTEDItems count] + [self.entitiesMP3Items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < [self.entitiesTEDItems count]) {
        TEDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTEDCollectionViewCellIdentifier forIndexPath:indexPath];
        Item *item = self.entitiesTEDItems[indexPath.row];
        [cell setValueForItem:item];
        return cell;
    } else {
        MP3CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMP3CollectionViewCellIdentifier forIndexPath:indexPath];
        [cell setValueForItem:self.entitiesMP3Items[indexPath.row - self.entitiesTEDItems.count]];
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate/FlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.bounds.size.width, 155.0 + 8.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

@end
