//
//  MyCountryTests.m
//  MyCountryTests
//
//  Created by Mac i7 on 17/02/18.
//  Copyright © 2018 icommtechnologies. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MyCountryListViewController.h"
#import "MyCountry.h"

@interface MyCountryTests : XCTestCase

@property MyCountryListViewController *vcToTest;
@property NSURLSession *session;

@end

@implementation MyCountryTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _vcToTest = [[MyCountryListViewController alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


-(void) testParserMethod {
   
    NSDictionary *jsonDict= @{ @"title" : @"title",
                              @"description" : @"description",
                              @"imageHref" : @"imageHref",
                              };
    MyCountry *object = [[MyCountry alloc]initWithDictionary:jsonDict];
    
    XCTAssertTrue([object.title isEqualToString:jsonDict[@"title"]],@"title are not equal %@ %@", object.title, jsonDict[@"title"]);
    XCTAssertTrue([object.description isEqualToString:jsonDict[@"description"]],@"description are not equal %@ %@", object.title, jsonDict[@"description"]);
    XCTAssertTrue([object.ImageHref isEqualToString:jsonDict[@"imageHref"]],@"imagehref are not equal %@ %@", object.ImageHref, jsonDict[@"imageHref"]);
    
}


- (void)testURL
{
    NSURL *URL = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"];
    NSString *description = [NSString stringWithFormat:@"GET %@", URL];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:URL
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      XCTAssertNotNil(data, "data should not be nil");
                                      XCTAssertNil(error, "error should be nil");
                                      
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                          XCTAssertEqual(httpResponse.statusCode, 200, @"HTTP response status code should be 200");
                                          XCTAssertEqualObjects(httpResponse.URL.absoluteString, URL.absoluteString, @"HTTP response URL should be equal to original URL");
                                          XCTAssertEqualObjects(httpResponse.MIMEType, @"text/plain", @"HTTP response content type should be text/plain");
                                      } else {
                                          XCTFail(@"Response was not NSHTTPURLResponse");
                                      }
                                      
                                      [expectation fulfill];
                                  }];
    
    [task resume];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);    
        }
        [task cancel];
    }];
}


- (void)testReverseString {
    
    NSString *strOriginal = @"canda";
    
    [_vcToTest reverseString];
     NSString *strReverse = _vcToTest.stringReverse;
    XCTAssertEqualObjects(strOriginal, strReverse);
}

- (void)testStringUpdate {
    
    NSString *strExpected = @"mycountry";
    [_vcToTest updateString];
    NSString *strResult = _vcToTest.stringUpdate;
    XCTAssertEqualObjects(strExpected, strResult);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
