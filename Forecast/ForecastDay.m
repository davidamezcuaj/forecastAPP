//
//  ForecastDay.m
//  Forecast
//
//  Created by David on 6/8/17.
//  Copyright © 2017 David. All rights reserved.
//

#import "ForecastDay.h"

const NSString *KEY_Period = @"period";
const NSString *KEY_Title = @"title";
const NSString *KEY_IconURL = @"icon_url";
const NSString *KEY_Conditions= @"conditions";
const NSString *KEY_High = @"high";
const NSString *KEY_Low = @"low";
const NSString *KEY_Fahrenheit = @"fahrenheit";
const NSString *KEY_Celsius = @"celsius";
const NSString *KEY_Date = @"date";
const NSString *KEY_Weekday = @"weekday";
const NSString *KEY_Day = @"day";
const NSString *KEY_MonthName = @"monthname_short";


@implementation ForecastDay


+ (ForecastDay *) jsonToObject: (NSDictionary *)json{
    
    ForecastDay *forecastDay = [[ForecastDay alloc] init];
    
    forecastDay.period = [[json objectForKey: KEY_Period] integerValue];
    forecastDay.title = [json objectForKey: KEY_Title];
    forecastDay.iconURL = [json objectForKey: KEY_IconURL];
    forecastDay.textualDescription = [json objectForKey: KEY_Conditions];
    forecastDay.highTempFahrenheit = [[json objectForKey: KEY_High] objectForKey:KEY_Fahrenheit];
    forecastDay.highTempCelsius = [[json objectForKey: KEY_High] objectForKey:KEY_Celsius];
    forecastDay.lowTempFahrenheit = [[json objectForKey: KEY_High] objectForKey:KEY_Fahrenheit];
    forecastDay.lowTempCelsius = [[json objectForKey: KEY_High] objectForKey:KEY_Celsius];
    forecastDay.weekday = [[json objectForKey: KEY_Date] objectForKey:KEY_Weekday];
    forecastDay.day = [[json objectForKey: KEY_Date] objectForKey:KEY_Day];
    forecastDay.monthDay = [[json objectForKey: KEY_Date] objectForKey:KEY_MonthName];
    
    return forecastDay;
}


- (NSDictionary *) objToJSON: (ForecastDay *) forecastDay{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject: [NSNumber numberWithInteger: forecastDay.period] forKey: KEY_Period];
    [dict setObject:forecastDay.title forKey: KEY_Title];
    [dict setObject:forecastDay.iconURL forKey: KEY_IconURL];
    NSDictionary *highDict = [[NSDictionary alloc] initWithObjects:@[forecastDay.highTempFahrenheit, forecastDay.highTempCelsius] forKeys:@[KEY_Fahrenheit, KEY_Celsius]];
    [dict setObject:highDict forKey: KEY_High];
    NSDictionary *lowDict = [[NSDictionary alloc] initWithObjects:@[forecastDay.lowTempFahrenheit, forecastDay.lowTempCelsius] forKeys:@[KEY_Fahrenheit, KEY_Celsius]];
    [dict setObject:lowDict forKey: KEY_Low];
    
    return dict;
}


@end
