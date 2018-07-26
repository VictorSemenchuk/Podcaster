//
//  ViewController.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedViewController+Parsing.h"
#import "FeedViewController+Constraints.h"
#import "FeedViewController+CollectionView.h"
#import "MP3CollectionViewCell.h"
#import "TEDCollectionViewCell.h"
#import "Constants.h"
#import "UIColor+CustomColors.h"
#import "CollectionViewFlowLayout.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tags = @[kItemEntityFieldGUID,
                  kItemEntityFieldTitle,
                  kItemEntityFieldAuthor,
                  kItemEntityFieldDetails,
                  kItemEntityFieldDuration,
                  kItemEntityFieldPubDate,
                  kItemEntityFieldImage,
                  kItemEntityFieldContent
                  ];
    
    [self setupXMLServiceForSourceType:kMP3];
    [self setupXMLServiceForSourceType:kTED];
    [self.xmlParserServiceMP3 startParsing];
    [self.xmlParserServiceTED startParsing];
    
    [self setupViews];
}

#pragma mark - Lazy init properties

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CollectionViewFlowLayout *layout = [[CollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.backgroundColor = [UIColor collectionViewBGColorVS];
        _collectionView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:MP3CollectionViewCell.class forCellWithReuseIdentifier:kMP3CollectionViewCellIdentifier];
        [_collectionView registerClass:TEDCollectionViewCell.class forCellWithReuseIdentifier:kTEDCollectionViewCellIdentifier];
    }
    return _collectionView;
}

@end
