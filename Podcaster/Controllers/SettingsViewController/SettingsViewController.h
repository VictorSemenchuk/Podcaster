//
//  SettingsViewController.h
//  Podcaster
//
//  Created by Victor Macintosh on 28/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewControllerDelegate <NSObject>

- (void)settingsWereChanged;

@end

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) id<SettingsViewControllerDelegate> delegate;

@end
