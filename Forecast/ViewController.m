//
//  ViewController.m
//  Forecast
//
//  Created by David on 6/8/17.
//  Copyright © 2017 David. All rights reserved.
//

#import "ViewController.h"
#import "NetworkingManager.h"
#import "CustomTableViewCell.h"
#import "ForecastDay.h"

@interface ViewController () <UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *forecastDayArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *txtCity;

@property (weak, nonatomic) IBOutlet UITextField *txtState;

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.forecastDayArray = [[NSMutableArray alloc] init];
    
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//PRAGMA MARK: Search IBAction
- (IBAction)searchForecastDay:(UIButton *)sender {
    
    [self.forecastDayArray removeAllObjects];
    [self.tableView reloadData];
    
    
    NSString *city = self.txtCity.text;
    NSString *state = self.txtState.text;
    city = [city stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    if (city.length > 0 && state.length == 2){
        
        [[NetworkingManager sharedManager] getForecastForCity:city andState:state withCompletion:^(bool status, NSMutableArray *forecastDays){
            if(status){
                NSLog(@"%@",forecastDays);
                self.forecastDayArray = forecastDays;
                [self.tableView reloadData];
            } else{
                [self showAlertWith:@"Error" andSubTitle:[NSString stringWithFormat:@"No results found for %@,%@. Please try a different input.", city, state]];
                NSLog(@"Error retrieving from API");
            }
        }];
    } else{
        [self showAlertWith:@"Error" andSubTitle:@"Please enter State and City"];
         NSLog(@"Input error");
    }

}

//PRAGMA MARK: Table View DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.forecastDayArray.count > 0){
        return 3;
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    ForecastDay *currentDay = (ForecastDay*) self.forecastDayArray[indexPath.row];
    
    cell.lblTitleDay.text = [NSString stringWithFormat:@" %@, %@ %@", currentDay.weekday, currentDay.monthDay, currentDay.day];
    cell.lblTempLow.text = currentDay.lowTempFahrenheit;
    cell.lblTempHigh.text = currentDay.highTempFahrenheit;
    cell.lblTextualDescription.text = currentDay.textualDescription;
    
    if (currentDay.iconImg != nil){
        cell.imgView.image = currentDay.iconImg;
        [cell.activityIndicator stopAnimating];
    } else{
        [cell.activityIndicator startAnimating];
        // download image in background;
        [[NetworkingManager sharedManager] getImageFromIconURL:currentDay.iconURL withCompletion:^(UIImage *img){
            if (img != nil){
                currentDay.iconImg = img;
                [self.tableView reloadRowsAtIndexPaths: @[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [cell.activityIndicator stopAnimating];
            }
        }];
        
    }
    
    cell.backgroundColor = [UIColor colorWithRed:65.0f/255.0f
                                           green:147.0f/255.0f
                                            blue:168.0f/255.0f
                                           alpha:0.5f];
    
    
    //To achieve card like layout
    cell.layer.borderWidth = 10;
    cell.layer.borderColor = [[UIColor colorWithRed:65.0f/255.0f
                                             green:147.0f/255.0f
                                              blue:168.0f/255.0f
                                             alpha:1.0f] CGColor];
    
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowRadius = 4;
    cell.layer.shadowOpacity = 0.2;
    cell.layer.masksToBounds = false;
    cell.clipsToBounds = false;
    
    return cell;
}

//PRAGMA MARK: Helper Functions
- (void) showAlertWith:(NSString *)title andSubTitle:(NSString *)subTitle{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:subTitle
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
