//
//  GameViewController.h
//  Bune
//
//  Created by Tomer Ciucran on 10/07/14.
//  Copyright (c) 2014 tomerciucran. All rights reserved.
//

@import GoogleMobileAds;

#import <AudioToolbox/AudioToolbox.h>
#import "BaseViewController.h"
#import "InstagramDataService.h"
#import "ImageCollectionViewCell.h"
#import "QuestionItem.h"
#import "HTPressableButton.h"
#import "UIColor+HTColor.h"
#import "RTSpinKitView.h"

@interface GameViewController : BaseViewController<InstagramDataDelegate, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, GADBannerViewDelegate>

@property (nonatomic, strong) InstagramDataService *dataService;

@property (nonatomic, strong) QuestionItem *questionItem;

@property (strong, nonatomic) HTPressableButton *button1;
@property (strong, nonatomic) HTPressableButton *button2;

@property (nonatomic, strong) NSMutableArray *countriesMutableArray;
@property (nonatomic, strong) NSString *trueHashtag;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) int lifeCount;

@property (weak, nonatomic) IBOutlet UIImageView *life1;
@property (weak, nonatomic) IBOutlet UIImageView *life2;
@property (weak, nonatomic) IBOutlet UIImageView *life3;
@property (weak, nonatomic) IBOutlet UIImageView *life4;
@property (weak, nonatomic) IBOutlet UIImageView *life5;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControlView;

@property (nonatomic, strong) NSMutableArray *questionItemArray;
//@property (nonatomic) int currentQuestionIndex;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *plusCircle;
@property (weak, nonatomic) IBOutlet UIImageView *minusHeart;

@property (nonatomic) int currentScore;
@property (nonatomic) int successCount;
@property (nonatomic) BOOL dataLoopCompleted;

@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;
@property (nonatomic) BOOL bannerIsVisible;

@property (nonatomic, strong) RTSpinKitView *spinKit;

@property (nonatomic) int button1TouchCount;
@property (nonatomic) int button2TouchCount;

@end
