//
//  NetworkingManager.h
//  Forecast
//
//  Created by David on 6/8/17.
//  Copyright © 2017 David. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NetworkingManager : NSObject


- (void) getForecastForCity: (NSString *)city andState: (NSString *)state withCompletion:(void (^)(bool, NSMutableArray*)) callback;

- (void) getImageFromIconURL: (NSString *)urlString withCompletion:(void (^)(UIImage*)) callback;
+ (id)sharedManager;
@end
