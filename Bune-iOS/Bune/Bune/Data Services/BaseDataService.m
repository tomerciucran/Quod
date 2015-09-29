//
//  BaseDataService.m
//  Bune
//
//  Created by Tomer Ciucran on 10/07/14.
//  Copyright (c) 2014 tomerciucran. All rights reserved.
//

#import "BaseDataService.h"

@implementation BaseDataService

- (id) initWithDelegate:(id)delegate{
    self = [super init];
    if (self) {
        if (delegate != nil) {
            self.delegate = delegate;
        }
    }
    return self;
}

- (NSMutableURLRequest*) getURLRequestWithURL:(NSURL*) url data:(NSDictionary*)data httpMethod:(NSString*) method{
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    if (data != nil) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
        [urlRequest setHTTPBody:jsonData];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"UserCode"] != nil) {
        [urlRequest setValue:[defaults objectForKey:@"UserCode"] forHTTPHeaderField:@"UserCode"];
    }
    
    if ([defaults objectForKey:@"DeviceID"] != nil) {
        [urlRequest setValue:[defaults objectForKey:@"DeviceID"] forHTTPHeaderField:@"DeviceID"];
    }
    
    //[urlRequest setValue:[NSString stringWithFormat:@"%d", PLATFORM_ID] forHTTPHeaderField:@"PlatformId"];
    [urlRequest setHTTPMethod:method];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    return urlRequest;
}

- (NSMutableURLRequest*) getGzipURLRequestWithURL:(NSURL*) url{
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    return urlRequest;
}

- (void)invalidateService
{
    for (NSURLSessionDataTask *task in self.taskArray) {
        [task cancel];
    }
}

- (void)cleanTasks
{
    int i = 0;
    while (i < self.taskArray.count) {
        NSURLSessionDataTask *task = self.taskArray[i];
        if (task.state == NSURLSessionTaskStateCompleted) {
            [self.taskArray removeObject:task];
        } else {
            i++;
        }
    }
}

@end