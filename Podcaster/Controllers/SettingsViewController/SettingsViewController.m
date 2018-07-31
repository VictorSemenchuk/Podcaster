//
//  SettingsViewController.m
//  Podcaster
//
//  Created by Victor Macintosh on 28/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsViewController+Constraints.h"

@interface SettingsViewController ()

@property (assign, nonatomic) BOOL settingsWereChanged;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.settingsWereChanged = NO;
    [self setupViews];
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
