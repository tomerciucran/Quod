//
//  InstagramParser.m
//  Bune
//
//  Created by Tomer Ciucran on 10/07/14.
//  Copyright (c) 2014 tomerciucran. All rights reserved.
//

#import "QuestionParser.h"

@implementation QuestionParser

+ (QuestionItem*) parse:(NSData*) data trueHashtag:(NSString*)trueHashtag answersArray:(NSMutableArray*)answers
{
    @try {
        NSError *error;
        NSDictionary *mainDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        QuestionItem *item = [[QuestionItem alloc] initWithDictionaryRepresentation:mainDictionary];
        NSArray *dataArray = [[NSArray alloc] init];
        dataArray = [mainDictionary objectForKey:@"data"];
        
        if (dataArray.count == 0) {
            NSLog(@"0 data");
            
            return nil;
        }
        else
        {
            NSMutableArray *dataMutableArray = [dataArray mutableCopy];
            
            [self shuffleMutableArray:dataMutableArray];
            
            NSDictionary *firstImageDic = [dataMutableArray[0] objectForKey:@"images"];
            NSDictionary *secondImageDic = [dataMutableArray[1] objectForKey:@"images"];
            
            NSDictionary *firstLowResolutionDic = [firstImageDic objectForKey:@"low_resolution"];
            NSDictionary *secondLowResolutionDic = [secondImageDic objectForKey:@"low_resolution"];
            
            NSString *firstLowResolutionInstagramImageUrl = [firstLowResolutionDic objectForKey:@"url"];
            NSString *secondLowResolutionInstagramImageUrl = [secondLowResolutionDic objectForKey:@"url"];
            
            item.firstImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:firstLowResolutionInstagramImageUrl]]];
            item.secondImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:secondLowResolutionInstagramImageUrl]]];
            
            item.trueHashtag = trueHashtag;
            item.answers = answers;
            
            return item;
        }
        
        
    }
    @catch (NSException *exception) {
        return nil;
    }
}

+ (void)shuffleMutableArray:(NSMutableArray*)mArray
{
    int index;
    for (int i = 0; i < mArray.count; i++) {
        index = arc4random() % mArray.count;
        [mArray exchangeObjectAtIndex:index withObjectAtIndex:i];
    }
}

@end
