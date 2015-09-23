//
//  BaseEntity.h
//  Bune
//
//  Created by Tomer Ciucran on 10/07/14.
//  Copyright (c) 2014 tomerciucran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+AutoMagicCoding.h"

@interface BaseEntity : NSObject

- (id) initWithDictionaryRepresentation: (NSDictionary *) aDict;

@end
