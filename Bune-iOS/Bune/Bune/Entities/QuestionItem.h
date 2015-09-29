//
//  InstagramItem.h
//  Bune
//
//  Created by Tomer Ciucran on 10/07/14.
//  Copyright (c) 2014 tomerciucran. All rights reserved.
//

#import "BaseEntity.h"

@interface QuestionItem : BaseEntity

@property (nonatomic, strong) UIImage *firstImage;
@property (nonatomic, strong) UIImage *secondImage;
@property (nonatomic, strong) NSString *trueHashtag;
@property (nonatomic, strong) NSString *trueHashtagEncoded;
@property (nonatomic, strong) NSMutableArray *answers;

@end
