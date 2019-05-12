//
//  T072UserModel.h
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@class T072Geo, T072Address, T072Company;

@interface T072UserModel : NSObject <IGListDiffable>

@property (nonatomic, assign) NSInteger   ID;
@property (nonatomic, copy) NSString      *name;
@property (nonatomic, copy) NSString      *username;
@property (nonatomic, copy) NSString      *email;
@property (nonatomic, copy) NSString      *phone;
@property (nonatomic, copy) NSString      *website;
@property (nonatomic, strong) T072Address *address;
@property (nonatomic, strong) T072Company *company;

@end

@interface T072Geo : NSObject <IGListDiffable>

@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;

@end

@interface T072Address : NSObject <IGListDiffable>

@property (nonatomic, copy) NSString  *street;
@property (nonatomic, copy) NSString  *suite;
@property (nonatomic, copy) NSString  *city;
@property (nonatomic, copy) NSString  *zipcode;
@property (nonatomic, strong) T072Geo *geo;

@end

@interface T072Company : NSObject <IGListDiffable>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *catchPhrase;
@property (nonatomic, copy) NSString *bs;

@end

NS_ASSUME_NONNULL_END
