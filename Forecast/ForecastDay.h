//
//  ForecastDay.h
//  Forecast
//
//  Created by David on 6/8/17.
//  Copyright © 2017 David. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ForecastDay : NSObject

@property (nonatomic) NSInteger period;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *iconURL;
@property (strong, nonatomic) NSString *textualDescription;
@property (strong, nonatomic) NSString *lowTempFahrenheit;
@property (strong, nonatomic) NSString *lowTempCelsius;
@property (strong, nonatomic) NSString *highTempFahrenheit;
@property (strong, nonatomic) NSString *highTempCelsius;
@property (strong, nonatomic) NSString *weekday;
@property (strong, nonatomic) NSString *day;
@property (strong, nonatomic) NSString *monthDay;
@property (strong, nonatomic) UIImage *iconImg;


+ (ForecastDay *) jsonToObject: (NSDictionary *)json;

@end
