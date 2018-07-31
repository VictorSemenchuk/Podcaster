//
//  SettingsViewController.h
//  Podcaster
//
//  Created by Victor Macintosh on 28/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+CustomColors.h"
#import "Constants.h"

@protocol SettingsViewControllerDelegate <NSObject>

- (void)dismiss;
- (void)settingsWereChanged;
- (void)switchedOfflineMode:(UISwitch *)sender;
- (void)switchedTEDSource:(UISwitch *)sender;
- (void)switchedMP3Source:(UISwitch *)sender;

@end

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) id<SettingsViewControllerDelegate> delegate;

@end
