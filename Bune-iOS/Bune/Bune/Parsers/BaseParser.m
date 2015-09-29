//
//  BaseParser.m
//  Bune
//
//  Created by Tomer Ciucran on 10/07/14.
//  Copyright (c) 2014 tomerciucran. All rights reserved.
//

#import "BaseParser.h"

@implementation BaseParser

+(BOOL) isObjectExists:(NSObject*)object{
    if (![object isKindOfClass:[NSNull class]] && object != nil ) {
        return YES;
    }
    
    return NO;
}
@end
