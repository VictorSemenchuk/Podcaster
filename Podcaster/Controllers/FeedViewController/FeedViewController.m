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

@interface FeedViewController ()

@end

@implementation FeedViewController

#pragma mark - LifeCycle

- (void)loadView {
    [super loadView];
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
    
    [self setupViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.xmlParserServiceMP3 startParsing];
    [self.xmlParserServiceTED startParsing];
}

#pragma mark - Lazy initing properties

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.backgroundColor = UIColor.greenColor;
    }
    return _collectionView;
}

@end
