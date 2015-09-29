//
//  InstagramParser.h
//  Bune
//
//  Created by Tomer Ciucran on 10/07/14.
//  Copyright (c) 2014 tomerciucran. All rights reserved.
//

#import "BaseParser.h"
#import "QuestionItem.h"

@interface QuestionParser : BaseParser

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;

+ (QuestionItem*) parse:(NSData*) data trueHashtag:(NSString*)trueHashtag answersArray:(NSMutableArray*)answers;

@end
