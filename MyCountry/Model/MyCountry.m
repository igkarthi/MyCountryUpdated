//
//  MyCountry.m
//  MyCountry
//
//  Created by Mac i7 on 21/02/18.
//  Copyright © 2018 Smaat Apps & Technologies Pvt Ltd. All rights reserved.
//

#import "MyCountry.h"

@implementation MyCountry
@synthesize title, description, ImageHref;
- (instancetype)initWithDictionary:(NSDictionary *)mycountryData
{
    self = [super init];
    if (self)
    {
        title = mycountryData[@"title"];
        description = mycountryData[@"description"];
        ImageHref = mycountryData[@"imageHref"];
    }
    return self;
}

@end
