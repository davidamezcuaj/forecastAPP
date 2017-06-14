//
//  ForecastTests.m
//  ForecastTests
//
//  Created by David on 6/8/17.
//  Copyright © 2017 David. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NetworkingManager.h"



@interface ForecastTests : XCTestCase

@end

@implementation ForecastTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


- (void)testWebServiceRequest{
    
     NSString *urlString = @"https://api.wunderground.com/api/36ab37c812f4cefe/CA/San_Francisco.json";
    
     XCTestExpectation *expectation = [self expectationWithDescription:([NSString stringWithFormat:@"GET: %@", urlString])];
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: url];
    
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error){
        
        XCTAssertNotNil(data, "data should not be nil");
        XCTAssertNil(error, "error should be nil");
        
        if (response != nil){
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            XCTAssertEqual([response.URL absoluteString], [url absoluteString], "HTTP response should be equal to original URL");
            XCTAssertEqual(httpResponse.statusCode, 200, "HTPP response status code should be 200");
            XCTAssertTrue([response.MIMEType isEqualToString:@"application/json"], "HTTP response content type should be application/json");
        } else{
            XCTFail("Response was not NSHTTPURLRESPONSE");
        }
        [expectation fulfill];
    }];
    
    [task resume];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error){
        if (error){
            NSLog(@"Error:%@",error.localizedDescription);
        }
    }];

}

- (void)testWebServiceRequestFromNetworkingManager{
    
    XCTestExpectation *expectation = [self expectationWithDescription:(@"GET: getForecastForCity:San_Francisco andState:CA")];
    
    [[NetworkingManager sharedManager] getForecastForCity:@"San_Francisco" andState:@"CA" withCompletion:^(bool success, NSMutableArray* days){
        if (!success){
            XCTFail(@" API Request Fail");
        } else{
            if (days == nil || !(days.count > 0)){
                 XCTFail(@"Error parsing data");
            }
            [expectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error){
        if (error){
            NSLog(@"Error:%@",error.localizedDescription);
        }
    }];
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}



@end
