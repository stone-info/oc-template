//
// Created by stone on 2019-05-11.
// Copyright (c) 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNGeo, SNAddress, SNCompany;

@interface SNRACModel : NSObject

@property (nonatomic, strong) SNAddress *address;
@property (nonatomic, copy) NSString    *phone;
@property (nonatomic, copy) NSString    *website;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) SNCompany *company;
@property (nonatomic, copy) NSString    *username;
@property (nonatomic, copy) NSString    *email;
@property (nonatomic, copy) NSString    *name;


@end

@interface SNGeo : NSObject

@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;


@end

@interface SNAddress : NSObject

@property (nonatomic, strong) SNGeo  *geo;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *suite;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *zipcode;


@end

@interface SNCompany : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *catchPhrase;
@property (nonatomic, copy) NSString *bs;


@end