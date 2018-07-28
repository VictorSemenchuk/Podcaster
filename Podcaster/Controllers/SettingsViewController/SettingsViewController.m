//
//  SettingsViewController.m
//  Podcaster
//
//  Created by Victor Macintosh on 28/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "SettingsViewController.h"
#import "UIColor+CustomColors.h"
#import "Constants.h"



@interface SettingsViewController ()

@property (assign, nonatomic) BOOL settingsWereChanged;

- (void)setupViews;
- (void)dismiss;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settingsWereChanged = NO;
    
    self.navigationItem.title = @"Settings";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"CloseIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    leftBarButtonItem.tintColor = UIColor.themeColor;
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setupViews];
}

#pragma mark - Methods

- (void)setupViews {
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 40.0;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIStackView *firstStackView = [[UIStackView alloc] init];
    firstStackView.axis = UILayoutConstraintAxisVertical;
    firstStackView.spacing = 20.0;
    
    UILabel *firstLabel = [[UILabel alloc] init];
    firstLabel.font = [UIFont systemFontOfSize:kFontSizeHeavy weight:UIFontWeightSemibold];
    firstLabel.textColor = UIColor.darkTextColor;
    firstLabel.text = @"Sources";
    
    UIStackView *mp3SourceStack = [[UIStackView alloc] init];
    mp3SourceStack.axis = UILayoutConstraintAxisHorizontal;
    mp3SourceStack.distribution = UIStackViewDistributionFill;
    
    UILabel *mp3Label = [[UILabel alloc] init];
    mp3Label.font = [UIFont systemFontOfSize:kFontSizeRegular weight:UIFontWeightRegular];
    mp3Label.textColor = UIColor.darkTextColor;
    mp3Label.text = @"SimpleCast";
    
    UISwitch *mp3Switch = [[UISwitch alloc] init];
    [mp3Switch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsMP3SourceKey]];
    [mp3Switch setOnTintColor:UIColor.themeColor];
    [mp3Switch addTarget:self action:@selector(switchedMP3Source:) forControlEvents:UIControlEventValueChanged];
    
    [mp3SourceStack addArrangedSubview:mp3Label];
    [mp3SourceStack addArrangedSubview:mp3Switch];
    
    UIStackView *tedSourceStack = [[UIStackView alloc] init];
    tedSourceStack.axis = UILayoutConstraintAxisHorizontal;
    tedSourceStack.distribution = UIStackViewDistributionFill;
    
    UILabel *tedLabel = [[UILabel alloc] init];
    tedLabel.font = [UIFont systemFontOfSize:kFontSizeRegular weight:UIFontWeightRegular];
    tedLabel.textColor = UIColor.darkTextColor;
    tedLabel.text = @"TED";
    
    UISwitch *tedSwitch = [[UISwitch alloc] init];
    [tedSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsTEDSourceKey]];
    [tedSwitch setOnTintColor:UIColor.themeColor];
    [tedSwitch addTarget:self action:@selector(switchedTEDSource:) forControlEvents:UIControlEventValueChanged];
    
    [tedSourceStack addArrangedSubview:tedLabel];
    [tedSourceStack addArrangedSubview:tedSwitch];
    
    UIStackView *optionsStack = [[UIStackView alloc] init];
    optionsStack.axis = UILayoutConstraintAxisVertical;
    optionsStack.spacing = 5.0;
    [optionsStack addArrangedSubview:mp3SourceStack];
    [optionsStack addArrangedSubview:tedSourceStack];
    
    [firstStackView addArrangedSubview:firstLabel];
    [firstStackView addArrangedSubview:optionsStack];
    
    UIStackView *secondStackView = [[UIStackView alloc] init];
    secondStackView.axis = UILayoutConstraintAxisVertical;
    secondStackView.spacing = 20.0;
    
    UILabel *secondLabel = [[UILabel alloc] init];
    secondLabel.font = [UIFont systemFontOfSize:kFontSizeHeavy weight:UIFontWeightSemibold];
    secondLabel.textColor = UIColor.darkTextColor;
    secondLabel.text = @"Offline";
    
    UIStackView *offlineStack = [[UIStackView alloc] init];
    offlineStack.axis = UILayoutConstraintAxisHorizontal;
    offlineStack.distribution = UIStackViewDistributionFill;
    
    UILabel *offlineLabel = [[UILabel alloc] init];
    offlineLabel.font = [UIFont systemFontOfSize:kFontSizeRegular weight:UIFontWeightRegular];
    offlineLabel.textColor = UIColor.darkTextColor;
    offlineLabel.text = @"Offline mode";
    
    UISwitch *offlineSwitch = [[UISwitch alloc] init];
    [offlineSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsOfflineModeKey]];
    [offlineSwitch setOnTintColor:UIColor.themeColor];
    [offlineSwitch addTarget:self action:@selector(switchedOfflineMode:) forControlEvents:UIControlEventValueChanged];
    
    [offlineStack addArrangedSubview:offlineLabel];
    [offlineStack addArrangedSubview:offlineSwitch];
    
    [secondStackView addArrangedSubview:secondLabel];
    [secondStackView addArrangedSubview:offlineStack];
    
    [stackView addArrangedSubview:firstStackView];
    [stackView addArrangedSubview:secondStackView];
    
    [self.view addSubview:stackView];
    [NSLayoutConstraint activateConstraints: @[[stackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:kLeftRightPadding],
                                               [stackView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:kTopBottomPadding],
                                               [stackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-kLeftRightPadding]
                                               ]];
    
    
}

#pragma mark - Target actions

- (void)dismiss {
    if (self.settingsWereChanged) {
        [self.delegate settingsWereChanged];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)switchedMP3Source:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:kUserDefaultsMP3SourceKey];
    self.settingsWereChanged = YES;
}

- (void)switchedTEDSource:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:kUserDefaultsTEDSourceKey];
    self.settingsWereChanged = YES;
}

- (void)switchedOfflineMode:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:kUserDefaultsOfflineModeKey];
    self.settingsWereChanged = YES;
}

@end
