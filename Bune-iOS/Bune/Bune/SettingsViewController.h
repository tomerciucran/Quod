//
//  SettingsViewController.h
//  Bune
//
//  Created by IMC on 06/02/15.
//  Copyright (c) 2015 tomerciucran. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingsViewController : BaseViewController<MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *versionLabel;
@property (strong, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *vibrateSwitch;

@end
