//
//  ViewController.h
//  Bune
//
//  Created by Tomer Ciucran on 10/07/14.
//  Copyright (c) 2014 tomerciucran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "BaseViewController.h"
#import "HTPressableButton.h"

@interface MainViewController : BaseViewController

@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic) BOOL isConnected;
@property (strong, nonatomic) IBOutlet UILabel *highScoreLabel;

@property (nonatomic, strong) HTPressableButton *startButton;
@property (nonatomic, strong) HTPressableButton *rateButton;

@end
