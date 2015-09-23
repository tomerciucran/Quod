//
//  BaseEntity.m
//  Bune
//
//  Created by Tomer Ciucran on 10/07/14.
//  Copyright (c) 2014 tomerciucran. All rights reserved.
//

#import "BaseEntity.h"

@implementation BaseEntity

+ (BOOL) AMCEnabled
{
    return YES;
}

- (id) initWithDictionaryRepresentation: (NSDictionary *) aDict
{
    self = [super initWithDictionaryRepresentation:aDict];
    
    return self;
}

@end
