//
//  FeedViewController+Constraints.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FeedViewController+Constraints.h"
#import "FeedViewController+CollectionView.h"

@implementation FeedViewController (Constraints)

- (void)setupViews {
    //rightBarButtonItem
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SettingIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(presentSettingsViewController)];
    rightBarButtonItem.tintColor = UIColor.themeColor;
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    //collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.backgroundColor = [UIColor collectionViewBGColorVS];
    self.collectionView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:MP3CollectionViewCell.class forCellWithReuseIdentifier:kMP3CollectionViewCellIdentifier];
    [self.collectionView registerClass:TEDCollectionViewCell.class forCellWithReuseIdentifier:kTEDCollectionViewCellIdentifier];
    
    //activityIndicator
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.color = UIColor.themeColor;
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self setupConstraints];
}

- (void)setupConstraints {
    self.navigationItem.title = @"Feed";
    
    [self.view addSubview:self.collectionView];
    [self.collectionView addSubview:self.activityIndicator];
    [NSLayoutConstraint activateConstraints:@[[self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                              [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                              [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                              [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                                              [self.activityIndicator.topAnchor constraintEqualToAnchor:self.collectionView.topAnchor constant:50.0],
                                              [self.activityIndicator.centerXAnchor constraintEqualToAnchor:self.collectionView.centerXAnchor],
                                              [self.activityIndicator.widthAnchor constraintEqualToConstant:20.0],
                                              [self.activityIndicator.heightAnchor constraintEqualToAnchor:self.activityIndicator.widthAnchor]
                                              ]];
    [self.activityIndicator startAnimating];
}

@end
