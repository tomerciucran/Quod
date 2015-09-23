//
//  ImageDataService.h
//  Bune
//
//  Created by Tomer Ciucran on 10/07/14.
//  Copyright (c) 2014 tomerciucran. All rights reserved.
//

#import "BaseDataService.h"
#import "QuestionItem.h"
#import "QuestionParser.h"

@protocol InstagramDataDelegate <NSObject>
@optional
- (void)instagramResultRetrieved:(QuestionItem*)item nextQuestion:(BOOL)loadNextQuestion;
@end

@interface InstagramDataService : BaseDataService
@property (nonatomic, assign) id<InstagramDataDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *questionArray;
@property (nonatomic) int count;

- (void)getInstagramData:(BOOL)loadNextQuestion;
@end
