//
//  MyCountry.h
//  MyCountry
//
//  Created by Mac i7 on 21/02/18.
//  Copyright © 2018 Smaat Apps & Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCountry : NSObject

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *description;
@property (nonatomic, readonly) NSString *ImageHref;

- (instancetype)initWithDictionary:(NSDictionary *)mycountryData;
@end
