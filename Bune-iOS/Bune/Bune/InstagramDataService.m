//
//  ImageDataService.m
//  Bune
//
//  Created by Tomer Ciucran on 10/07/14.
//  Copyright (c) 2014 tomerciucran. All rights reserved.
//

#import "InstagramDataService.h"

@implementation InstagramDataService

- (void)getInstagramData:(BOOL)loadNextQuestion
{
    if (self.count == 0) {
        self.questionArray = [[NSMutableArray alloc] init];
    }
    self.count++;
    
    NSMutableArray *answers = [[NSMutableArray alloc] init];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Hashtags" ofType:@"plist"]];
    NSArray *array = [dictionary objectForKey:@"Countries"];
    NSMutableArray *countriesMutableArray = [array mutableCopy];
    
    [self shuffleMutableArray:countriesMutableArray];
    
    [answers addObject:countriesMutableArray[0]];
    [answers addObject:countriesMutableArray[1]];
    
    int r = arc4random() % 2;
    
    NSString *trueHashtag = [answers[r] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSMutableURLRequest* urlRequest = [self getURLRequestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=%@", trueHashtag, CLIENT_ID]] data:nil httpMethod:HTTPGET];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest
                                                completionHandler:^(NSData *data,
                                                                    NSURLResponse *response,
                                                                    NSError *error) {
                                                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                                                        
//                                                        [self cleanTasks];
                                                        
                                                        if (self.delegate != nil) {
                                                            [self.delegate instagramResultRetrieved:[QuestionParser parse:data trueHashtag:trueHashtag answersArray:answers] nextQuestion:loadNextQuestion];
                                                        }
                                                    });
                                                }];
    
    [self.taskArray addObject:dataTask];
    [dataTask resume];
}

- (void) invalidateService
{
    self.delegate = nil;
    [super invalidateService];
}

- (void)shuffleMutableArray:(NSMutableArray*)mArray
{
    int index;
    for (int i = 0; i < mArray.count; i++) {
        index = arc4random() % mArray.count;
        [mArray exchangeObjectAtIndex:index withObjectAtIndex:i];
    }
}

@end
