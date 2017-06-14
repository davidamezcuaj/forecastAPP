//
//  CustomTableViewCell.h
//  Forecast
//
//  Created by David on 6/9/17.
//  Copyright © 2017 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTempLow;
@property (weak, nonatomic) IBOutlet UILabel *lblTempHigh;
@property (weak, nonatomic) IBOutlet UILabel *lblTextualDescription;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleDay;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end
