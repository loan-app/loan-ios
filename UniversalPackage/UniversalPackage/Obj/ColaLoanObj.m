//
//  ColaLoanObj.m
//  ColaLoanYok
//
//  Created by Single_Nobel on 2018/8/21.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "ColaLoanObj.h"
static ColaLoanObj *clObj;
@implementation ColaLoanObj
+(ColaLoanObj *)defaultIntstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!clObj) {
            clObj = [[ColaLoanObj alloc]init];
        }
    });
    return clObj;
}
@end
@implementation Event
@end

@implementation Order
@end

@implementation Banner
@end

@implementation Notice
@end
