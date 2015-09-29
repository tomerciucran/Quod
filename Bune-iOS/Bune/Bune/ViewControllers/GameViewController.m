//
//  GameViewController.m
//  Bune
//
//  Created by Tomer Ciucran on 10/07/14.
//  Copyright (c) 2014 tomerciucran. All rights reserved.
//

#import "GameViewController.h"
#import "SIAlertView.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lifeCount = 5;
    self.currentScore = 0;
    
    self.bannerView.adUnitID = AdUnitID;
    self.bannerView.rootViewController = self;
    self.bannerView.delegate = self;
    [self.bannerView loadRequest:[GADRequest request]];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", self.currentScore];
    
    self.questionItemArray = [[NSMutableArray alloc] init];
    
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        self.button1 = [[HTPressableButton alloc] initWithFrame:CGRectMake(50, 400, 100, 100) buttonStyle:HTPressableButtonStyleCircular];
        self.button1.buttonColor = [UIColor ht_carrotColor];
        self.button1.shadowColor = [UIColor ht_pumpkinColor];
        self.button1.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        [self.button1 addTarget:self action:@selector(button1Clicked) forControlEvents:UIControlEventTouchUpInside];
        [self.button1 addTarget:self action:@selector(button1Touched) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:self.button1];
        
        self.button2 = [[HTPressableButton alloc] initWithFrame:CGRectMake(170, 400, 100, 100) buttonStyle:HTPressableButtonStyleCircular];
        self.button2.buttonColor = [UIColor ht_carrotColor];
        self.button2.shadowColor = [UIColor ht_pumpkinColor];
        self.button2.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        [self.button2 addTarget:self action:@selector(button2Clicked) forControlEvents:UIControlEventTouchUpInside];
        [self.button2 addTarget:self action:@selector(button2Touched) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:self.button2];
        
        self.bannerView.frame = CGRectMake(0, 568, 320, 50);
    } else {
        self.button1 = [[HTPressableButton alloc] initWithFrame:CGRectMake(50, 380, 100, 40) buttonStyle:HTPressableButtonStyleRounded];
        self.button1.buttonColor = [UIColor ht_carrotColor];
        self.button1.shadowColor = [UIColor ht_pumpkinColor];
        self.button1.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        [self.button1 addTarget:self action:@selector(button1Clicked) forControlEvents:UIControlEventTouchUpInside];
        [self.button1 addTarget:self action:@selector(button1Touched) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:self.button1];
        
        self.button2 = [[HTPressableButton alloc] initWithFrame:CGRectMake(170, 380, 100, 40) buttonStyle:HTPressableButtonStyleRounded];
        self.button2.buttonColor = [UIColor ht_carrotColor];
        self.button2.shadowColor = [UIColor ht_pumpkinColor];
        self.button2.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        [self.button2 addTarget:self action:@selector(button2Clicked) forControlEvents:UIControlEventTouchUpInside];
        [self.button2 addTarget:self action:@selector(button2Touched) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:self.button2];
        
        self.bannerView.frame = CGRectMake(0, 480, 320, 50);
    }
    
    self.life1.frame = CGRectMake(179, 39, 20, 20);
    self.life1.alpha = 1.0;
    self.life2.frame = CGRectMake(207, 39, 20, 20);
    self.life2.alpha = 1.0;
    self.life3.frame = CGRectMake(235, 39, 20, 20);
    self.life3.alpha = 1.0;
    self.life4.frame = CGRectMake(263, 39, 20, 20);
    self.life4.alpha = 1.0;
    self.life5.frame = CGRectMake(291, 39, 20, 20);
    self.life5.alpha = 1.0;
    
    self.dataService = [[InstagramDataService alloc] initWithDelegate:self];
    self.collectionView.dataSource = nil;
    
    [self loadNewData];
    
    self.button1.hidden = YES;
    self.button2.hidden = YES;
    self.pageControlView.hidden = YES;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.clipsToBounds = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - Sounds and vibration

- (void)makeSoundAndVibration:(NSString*)soundPath
{
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int isSoundOn = [[userDefaults objectForKey:@"soundSwitchState"] intValue];
    int isVibrationOn = [[userDefaults objectForKey:@"vibrateSwitchState"] intValue];
    
    if (isSoundOn == 1 && isVibrationOn == 1) {
        AudioServicesPlayAlertSound (soundID);
    } else if (isSoundOn == 1 && isVibrationOn == 0) {
        AudioServicesPlaySystemSound (soundID);
    } else if (isSoundOn == 0 && isVibrationOn == 1) {
        AudioServicesPlayAlertSound (kSystemSoundID_Vibrate);
    }
}

- (void)looseLifeSound
{
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"loseLiife" ofType:@"aif"];
    [self makeSoundAndVibration:soundPath];
}

- (void)correctSound
{
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"correct" ofType:@"aif"];
    [self makeSoundAndVibration:soundPath];
}

- (void)endGameSound
{
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"lose_2" ofType:@"aif"];
    [self makeSoundAndVibration:soundPath];
}

- (void)loadNewGame
{
    [self resetLifes];
    self.currentScore = 0;
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", self.currentScore];
    [self.questionItemArray removeAllObjects];
    self.button1.userInteractionEnabled = NO;
    self.button2.userInteractionEnabled = NO;
    self.collectionView.hidden = YES;
    [self loadNewData];
}

- (void)resetLifes
{
    self.life1.frame = CGRectMake(179, 39, 20, 20);
    self.life1.alpha = 1.0;
    self.life2.frame = CGRectMake(207, 39, 20, 20);
    self.life2.alpha = 1.0;
    self.life3.frame = CGRectMake(235, 39, 20, 20);
    self.life3.alpha = 1.0;
    self.life4.frame = CGRectMake(263, 39, 20, 20);
    self.life4.alpha = 1.0;
    self.life5.frame = CGRectMake(291, 39, 20, 20);
    self.life5.alpha = 1.0;
    self.lifeCount = 5;
}

- (void)instagramResultRetrieved:(QuestionItem *)item nextQuestion:(BOOL)loadNextQuestion
{
    self.questionItem = item;
    
    if (self.questionItem) {
        [self.questionItemArray addObject:self.questionItem];
        
        if (self.questionItemArray.count < 5) {
            [self.dataService getInstagramData:YES];
        } else {
            if (loadNextQuestion) {
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [self performSelector:@selector(loadNextQuestion) withObject:nil afterDelay:0.5];
                });
            }
        }
    }
    
    
    
//    QuestionItem *questionItem = [[QuestionItem alloc] init];
//    questionItem = self.questionItemArray[0];
//    
//    [self.collectionView setContentOffset:CGPointMake(0, 0)];
//    self.pageControlView.currentPage = 0;
//    [self.collectionView setDataSource:self];
//    [self.collectionView reloadData];
//    
//    [self.button1 setTitle:questionItem.answers[0] forState:UIControlStateNormal];
//    [self.button2 setTitle:questionItem.answers[1] forState:UIControlStateNormal];
//    
//    if (self.button1.titleLabel.text.length > 10) {
//        self.button1.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
//    } else {
//        self.button1.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
//    }
//    
//    if (self.button2.titleLabel.text.length > 10) {
//        self.button2.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
//    } else {
//        self.button2.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
//    }
//    
//    self.collectionView.hidden = NO;
//    self.button1.hidden = NO;
//    self.button2.hidden = NO;
//    self.pageControlView.hidden = NO;
}
- (IBAction)closeButtonAction:(id)sender {
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Warning" andMessage:@"Are you sure you want to end this game?"];
    [alertView addButtonWithTitle:@"No" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
        [alertView dismissAnimated:YES];
    }];
    [alertView addButtonWithTitle:@"Yes" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alertView show];
}

- (IBAction)button1Clicked {
    [self manageButtons:self.button1];
    self.button1TouchCount = 0;
    self.button2TouchCount = 0;
}
- (IBAction)button2Clicked {
    [self manageButtons:self.button2];
    self.button1TouchCount = 0;
    self.button2TouchCount = 0;
}

- (void)button1Touched{
    self.button1TouchCount++;
    if (self.button1TouchCount == 5 && self.button2TouchCount == 5) {
        [self resetLifes];
    }
    if (self.button1TouchCount - self.button2TouchCount > 1 || self.button1TouchCount - self.button2TouchCount < -1) {
        self.button1TouchCount = 0;
        self.button2TouchCount = 0;
    }
}

- (void)button2Touched{
    self.button2TouchCount++;
    if (self.button1TouchCount == 5 && self.button2TouchCount == 5) {
        [self resetLifes];
    }
    if (self.button1TouchCount - self.button2TouchCount > 1 || self.button1TouchCount - self.button2TouchCount < -1) {
        self.button1TouchCount = 0;
        self.button2TouchCount = 0;
    }
}

- (void)manageButtons:(UIButton*)button
{
    QuestionItem *questionItem = [[QuestionItem alloc] init];
    questionItem = self.questionItemArray[0];
    
    if ([button.titleLabel.text isEqualToString:questionItem.trueHashtag]) {//right answer
        [self correctSound];
        self.currentScore++;
        self.scoreLabel.text = [NSString stringWithFormat:@"%i", self.currentScore];
        
        [UIView animateWithDuration:0.4 animations:^{
            self.plusCircle.frame = CGRectMake(self.plusCircle.frame.origin.x-50, self.plusCircle.frame.origin.y-50, self.plusCircle.frame.size.width+100, self.plusCircle.frame.size.height+100);
            self.plusCircle.alpha = 0.4;
        }completion:^(BOOL finished){
            [UIView animateWithDuration:0.4 animations:^{
                self.plusCircle.alpha = 0.0;
            }completion:^(BOOL finished){
                self.plusCircle.frame = CGRectMake(85, 150, 150, 150);
                self.plusCircle.alpha = 0.0;
            }];
        }];
        
    } else {//wrong answer
        [self looseLifeSound];
        [UIView animateWithDuration:0.4 animations:^{
            self.minusHeart.frame = CGRectMake(self.minusHeart.frame.origin.x-50, self.minusHeart.frame.origin.y-50, self.minusHeart.frame.size.width+100, self.minusHeart.frame.size.height+100);
            self.minusHeart.alpha = 0.4;
        }completion:^(BOOL finished){
            [UIView animateWithDuration:0.4 animations:^{
                self.minusHeart.alpha = 0.0;
            }completion:^(BOOL finished){
                self.minusHeart.frame = CGRectMake(85, 150, 150, 150);
                self.minusHeart.alpha = 0.0;
            }];
        }];
        
        self.lifeCount--;
        if (self.lifeCount == 4) {
            [self animateLooseLife:self.life1];
        } else if (self.lifeCount == 3) {
            [self animateLooseLife:self.life2];
        } else if (self.lifeCount == 2) {
            [self animateLooseLife:self.life3];
        } else if (self.lifeCount == 1) {
            [self animateLooseLife:self.life4];
        } else if (self.lifeCount == 0) {
            [self animateLooseLife:self.life5];
        }
    }
    [self.questionItemArray removeObjectAtIndex:0];
    
    if (self.lifeCount < 0) {
        [self endGameSound];
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Game Over" andMessage:[NSString stringWithFormat:@"Score: %i", self.currentScore]];
        [alertView addButtonWithTitle:@"New Game" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
            [self loadNewGame];
        }];
        [alertView addButtonWithTitle:@"Main Menu" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
            double delayInSeconds = 0.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                //code to be executed on the main queue after delay
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }];
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView show];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (![defaults objectForKey:@"highScore"]) {
            [defaults setInteger:self.currentScore forKey:@"highScore"];
        } else {
            if (self.currentScore > [[defaults objectForKey:@"highScore"] intValue]) {
                [defaults setInteger:self.currentScore forKey:@"highScore"];
            }
        }
        [defaults synchronize];
        
        
    } else {
        self.button1.userInteractionEnabled = NO;
        self.button2.userInteractionEnabled = NO;
        
        if (self.questionItemArray.count == 1 || self.questionItemArray.count == 2 || self.questionItemArray.count == 3 || self.questionItemArray.count == 4) {
            [self.dataService getInstagramData:NO];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self performSelector:@selector(loadNextQuestion) withObject:nil afterDelay:1.5];
            });
        } else if (self.questionItemArray.count == 0) {
            [self loadNewData];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self performSelector:@selector(loadNextQuestion) withObject:nil afterDelay:1.5];
            });
        }
    }
}

- (void)loadNewData
{
    self.collectionView.hidden = YES;
    self.button1.hidden = YES;
    self.button2.hidden = YES;
    self.pageControlView.hidden = YES;
    
//    self.spinKit = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStylePlane color:[UIColor whiteColor]];
//    self.spinKit.frame = CGRectMake(140, 223, 20, 20);
//    [self.view addSubview:self.spinKit];
//    [self.spinKit startAnimating];
    [self.activityIndicator startAnimating];
    
    [self.dataService getInstagramData:YES];
}

- (void)loadNextQuestion
{
//    [self.spinKit stopAnimating];
    [self.activityIndicator stopAnimating];
    
    self.collectionView.hidden = NO;
    self.button1.hidden = NO;
    self.button2.hidden = NO;
    self.pageControlView.hidden = NO;
    
    self.button1.userInteractionEnabled = YES;
    self.button2.userInteractionEnabled = YES;
    [self.collectionView setDataSource:self];
    [self.collectionView setContentOffset:CGPointMake(0, 0)];
    self.pageControlView.currentPage = 0;
    [self.collectionView reloadData];
    
    QuestionItem *questionItem = [[QuestionItem alloc] init];
    questionItem = self.questionItemArray[0];
    
    [self.button1 setTitle:questionItem.answers[0] forState:UIControlStateNormal];
    [self.button2 setTitle:questionItem.answers[1] forState:UIControlStateNormal];
    
    if (self.button1.titleLabel.text.length > 10) {
        self.button1.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
    } else {
        self.button1.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    }
    
    if (self.button2.titleLabel.text.length > 10) {
        self.button2.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
    } else {
        self.button2.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    }
}

- (void)animateLooseLife:(UIImageView*)lifeImageView
{
    [UIView animateWithDuration:0.3 animations:^{
        lifeImageView.frame = CGRectMake(lifeImageView.frame.origin.x, lifeImageView.frame.origin.y+10, lifeImageView.frame.size.width, lifeImageView.frame.size.height);
        lifeImageView.alpha = 0.0;
    }];
}

#pragma mark - Collection View

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"imageCell";
    ImageCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    QuestionItem *questionItem = [[QuestionItem alloc] init];
    questionItem = self.questionItemArray[0];
    
    if (indexPath.row == 0) {
        cell.imageView.image = questionItem.firstImage;
    } else {
        cell.imageView.image = questionItem.secondImage;
    }
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    NSInteger numberOfCells = self.view.frame.size.width / 320;
    NSInteger edgeInsets = (self.view.frame.size.width - (numberOfCells * 320)) / (numberOfCells + 1);
    
    return UIEdgeInsetsMake(0, edgeInsets, 0, edgeInsets);
}

#pragma mark - Scroll View

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.collectionView.frame.size.width - 50;
    
    NSInteger currentPage = self.collectionView.contentOffset.x / pageWidth;
    
    self.pageControlView.currentPage = currentPage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.dataService invalidateService];
}

#pragma mark - AdBanner delegates

- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
    
    if (!self.bannerIsVisible) {
        [UIView animateWithDuration:0.5 animations:^{
            if ([UIScreen mainScreen].bounds.size.height == 568) {
                self.bannerView.frame = CGRectMake(0, 518, 320, 50);
            } else {
                self.bannerView.frame = CGRectMake(0, 430, 320, 50);
            }
            self.bannerIsVisible = YES;
        }];
    }
}

- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adViewDidFailToReceiveAdWithError: %@", [error localizedDescription]);
    
    if (self.bannerIsVisible) {
        [UIView animateWithDuration:0.5 animations:^{
            if ([UIScreen mainScreen].bounds.size.height == 568) {
                self.bannerView.frame = CGRectMake(0, 568, 320, 50);
            } else {
                self.bannerView.frame = CGRectMake(0, 480, 320, 50);
            }
            self.bannerIsVisible = NO;
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
