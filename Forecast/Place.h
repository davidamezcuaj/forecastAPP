//
//  place.h
//  Forecast
//
//  Created by David on 6/9/17.
//  Copyright © 2017 David. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject


@property (nonatomic) NSString *city;
@property (nonatomic) NSString *state;
@property (nonatomic) NSString *abbreviation;
@property (nonatomic) NSString *population;
@property (nonatomic) NSString *rank;
@property (nonatomic) NSNumber *latitude;
@property (nonatomic) NSNumber *longitude;

@end
