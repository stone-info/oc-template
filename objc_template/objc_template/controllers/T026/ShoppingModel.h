//
//  ShoppingModel.h
//  005_UITableView
//
//  Created by stone on 2018/7/27.
//  Copyright © 2018年 stone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingModel : NSObject
@property(nonatomic, copy) NSString *image;
@property(nonatomic, copy) NSString *money;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) NSInteger count;
@end
