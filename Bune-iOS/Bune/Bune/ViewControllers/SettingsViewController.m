//
//  SettingsViewController.m
//  Bune
//
//  Created by IMC on 06/02/15.
//  Copyright (c) 2015 tomerciucran. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "SettingsViewController.h"
#import "SIAlertView.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"v%@", appVersion];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [self.soundSwitch setOn:[[userDefaults objectForKey:@"soundSwitchState"] intValue]];
    [self.vibrateSwitch setOn:[[userDefaults objectForKey:@"vibrateSwitchState"] intValue]];
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)closeButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)soundSwitchChanged:(id)sender {
    UISwitch *switchController = (UISwitch*)sender;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([switchController isOn]) {
        [userDefaults setInteger:1 forKey:@"soundSwitchState"];
    } else {
        [userDefaults setInteger:0 forKey:@"soundSwitchState"];
    }
}

- (IBAction)sendMailButtonAction:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setToRecipients:@[@"tciucran@gmail.com"]];
        [composeViewController setSubject:@""];
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareButtonAction:(id)sender {
    NSURL *shareURL = [NSURL URLWithString:@"http://itunes.apple.com/app/id964814938"];
    NSArray *activityItems = @[@"Having fun with Bune!",shareURL];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes =  @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePostToWeibo, UIActivityTypePrint, UIActivityTypeAddToReadingList,UIActivityTypeSaveToCameraRoll,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypePostToFlickr];
    [activityVC setValue:@"Bune iPhone App" forKey:@"subject"];
    [self presentViewController:activityVC animated:YES completion:nil];
    
    [activityVC setCompletionHandler:^(NSString *activityType, BOOL completed)
     {}];
}

- (IBAction)vibrateSwitchChanged:(id)sender {
    UISwitch *switchController = (UISwitch*)sender;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([switchController isOn]) {
        [userDefaults setInteger:1 forKey:@"vibrateSwitchState"];
    } else {
        [userDefaults setInteger:0 forKey:@"vibrateSwitchState"];
    }
}

- (IBAction)resetButtonAction:(id)sender {
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Warning" andMessage:@"Are you sure you want to reset your highscore?"];
    [alertView addButtonWithTitle:@"No" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
        [alertView dismissAnimated:YES];
    }];
    [alertView addButtonWithTitle:@"Yes" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nil forKey:@"highScore"];
        [defaults synchronize];
    }];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alertView show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
