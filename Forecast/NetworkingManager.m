//
//  NetworkingManager.m
//  Forecast
//
//  Created by David on 6/8/17.
//  Copyright © 2017 David. All rights reserved.
//

#import "NetworkingManager.h"
#import "ForecastDay.h"

@implementation NetworkingManager


static NSString const *API_BASE_URL = @"https://api.wunderground.com/api/36ab37c812f4cefe";


+ (id)sharedManager {
    static NetworkingManager *shared = nil;
    static dispatch_once_t onceToken; dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}


- (void) getForecastForCity: (NSString *)city andState: (NSString *)state withCompletion:(void (^)(bool , NSMutableArray*)) callback{
    
    NSString *urlString = [NSString stringWithFormat:@"%@/forecast/q/%@/%@.json",API_BASE_URL, state, city];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: url];
    
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error){
        
        if (!error){
            
            @try{
                NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                NSArray *jsonArray = [[[json objectForKey:@"forecast"] objectForKey:@"simpleforecast"] objectForKey:@"forecastday"];
                NSMutableArray *forecastArray = [[NSMutableArray alloc] init];
                
                for (NSDictionary *item in jsonArray) {
                    ForecastDay *obj = [ForecastDay jsonToObject:item];
                    [forecastArray addObject:obj];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(true, forecastArray);
                });
                
                
            } @catch(NSException *e){
                NSLog(@"Exception: %@", e);
                dispatch_async(dispatch_get_main_queue(), ^{
                 callback(false, nil);
                });
            }
            
        } else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(false, nil);
            });
        }
         
     }];
    
    [task resume];
}


- (void) getImageFromIconURL: (NSString *)urlString withCompletion:(void (^)(UIImage*)) callback{
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: url];
    
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error){
        
        if (!error && data){
            UIImage *img = [[UIImage alloc] initWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                 callback(img);
             });
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(nil);
        });
        
    }];
    [task resume];
}

@end
