//
//  ViewController.m
//  Bune
//
//  Created by Tomer Ciucran on 10/07/14.
//  Copyright (c) 2014 tomerciucran. All rights reserved.
//

#import "MainViewController.h"
#import "GameViewController.h"
#import "UIColor+HTColor.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.startButton = [[HTPressableButton alloc] initWithFrame:CGRectMake(110, 250, 100, 100) buttonStyle:HTPressableButtonStyleCircular];
    self.startButton.buttonColor = [UIColor ht_carrotColor];
    self.startButton.shadowColor = [UIColor ht_pumpkinColor];
    self.startButton.disabledButtonColor = [UIColor ht_concreteColor];
    self.startButton.disabledShadowColor = [UIColor ht_asbestosColor];
    self.startButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(startTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startButton];
    
    self.rateButton = [[HTPressableButton alloc] initWithFrame:CGRectMake(135, 360, 50, 50) buttonStyle:HTPressableButtonStyleCircular];
    self.rateButton.buttonColor = [UIColor ht_carrotColor];
    self.rateButton.shadowColor = [UIColor ht_pumpkinColor];
    self.rateButton.disabledButtonColor = [UIColor ht_concreteColor];
    self.rateButton.disabledShadowColor = [UIColor ht_asbestosColor];
    self.rateButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [self.rateButton setTitle:@"Rate" forState:UIControlStateNormal];
    [self.rateButton addTarget:self action:@selector(rateTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rateButton];
}

- (void)checkConnection
{
    self.reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    self.isConnected = [self.reachability isReachable];
    if (!self.isConnected) {
        UIAlertView* errorAlert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Please check your network connection." delegate:nil cancelButtonTitle:@"Tamam" otherButtonTitles:nil];
        [errorAlert show];
        self.startButton.enabled = NO;
        self.rateButton.enabled = NO;
    } else {
        self.startButton.enabled = YES;
        self.rateButton.enabled = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self checkConnection];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.highScoreLabel.text = [NSString stringWithFormat:@"Highscore: %i", [[defaults objectForKey:@"highScore"] intValue]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)appWillEnterForeground
{
    [self checkConnection];
}

- (IBAction)infoButtonTapped:(id)sender {
    
}

- (void)startTapped
{
    [self performSegueWithIdentifier:@"GameViewSegue" sender:nil];
}

- (void)rateTapped
{
    NSURL *appStoreURL = [NSURL URLWithString:@"http://itunes.apple.com/app/id964814938"];
    [[UIApplication sharedApplication] openURL:appStoreURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
