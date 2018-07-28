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
#import "ContentViewController.h"
#import "SplitViewController.h"

@implementation FeedViewController (CollectionView)

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Item *item = self.items[indexPath.row];
    switch (item.sourceType) {
        case kMP3: {
            MP3CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMP3CollectionViewCellIdentifier forIndexPath:indexPath];
            [cell setValueForItem:item];
            return cell;
            break;
        }
        case kTED: {
            TEDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTEDCollectionViewCellIdentifier forIndexPath:indexPath];
            [cell setValueForItem:item];
            return cell;
        }
    }
}

#pragma mark - UICollectionViewDelegate/FlowLayout

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Item *item = self.items[indexPath.row];
    ContentViewController *contentVC = [[ContentViewController alloc] init];
    contentVC.item = item;
    [self.splitViewController showDetailViewController:contentVC sender:nil];
}

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
