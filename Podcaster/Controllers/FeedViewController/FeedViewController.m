//
//  ViewController.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedViewController+Constraints.h"
#import "FeedViewController+CollectionView.h"
#import "FeedViewController+SettingsViewControllerDelegate.h"
#import "MP3CollectionViewCell.h"
#import "TEDCollectionViewCell.h"
#import "Constants.h"
#import "UIColor+CustomColors.h"
#import "CollectionViewFlowLayout.h"
#import "FileManager.h"

@interface FeedViewController ()

- (void)presentSettingsViewController;

@end

@implementation FeedViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.items = [[NSArray alloc] init];
    self.dataManager = [[DataManager alloc] init];
    [self.dataManager fetchData:self];
    [self setupViews];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SettingIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(presentSettingsViewController)];
    rightBarButtonItem.tintColor = UIColor.themeColor;
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    } else {
        // Fallback on earlier versions
    }
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

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicator.hidesWhenStopped = YES;
        _activityIndicator.color = UIColor.themeColor;
        _activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _activityIndicator;
}

#pragma mark - Methods

- (void)viewWillLayoutSubviews {
    [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - Target actions

- (void)presentSettingsViewController {
    SettingsViewController *settingsVC = [[SettingsViewController alloc] init];
    settingsVC.delegate = self;
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:settingsVC];
    [self presentViewController:navVC animated:YES completion:nil];
}

@end
