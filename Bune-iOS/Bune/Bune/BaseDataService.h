//
//  BaseDataService.h
//  Bune
//
//  Created by Tomer Ciucran on 10/07/14.
//  Copyright (c) 2014 tomerciucran. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HTTPPOST @"POST"
#define HTTPPUT @"PUT"
#define HTTPGET @"GET"
#define HTTPDELETE @"DELETE"

@interface BaseDataService : NSObject
@property (nonatomic, assign) id delegate;
@property (nonatomic, strong) NSMutableArray *taskArray;

-(id) initWithDelegate:(id)delegate;
-(NSMutableURLRequest*) getURLRequestWithURL:(NSURL*) url data:(NSDictionary*)data httpMethod:(NSString*) method;
-(NSMutableURLRequest*) getGzipURLRequestWithURL:(NSURL*) url;

- (void)invalidateService;
- (void)cleanTasks;

@end
