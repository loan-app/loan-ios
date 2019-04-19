//
//  ColaLoanObj.h
//  ColaLoanYok
//
//  Created by Single_Nobel on 2018/8/21.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColaLoanObj : NSObject
+(ColaLoanObj *)defaultIntstance;
@end

@interface Event:NSObject
@property(copy,nonatomic)NSString *event;
@property(copy,nonatomic)NSString *eventTime;
@property(copy,nonatomic)NSString *eventDescribe;
@end
@interface Order:NSObject
@property(copy,nonatomic)NSNumber *orderStatus;  //订单状态
@property(copy,nonatomic)NSNumber *remainDays;   //剩余/逾期天数
@property(copy,nonatomic)NSString *shouldRepay;  //应还金额
@property(copy,nonatomic)NSNumber *orderId;      //订单ID;
@property(copy,nonatomic)NSString *url ;  //跳转页面的url;
@property(copy,nonatomic)NSString *lastRepayTime;  //最迟回购日
@property(strong,nonatomic)NSArray<Event *> *loanBeforeList;
@end
@interface Banner:NSObject
@property(copy,nonatomic)NSString *bannerImgurl;
@property(copy,nonatomic)NSString *bannerUrl;
@end
@interface Notice:NSObject
@property(copy,nonatomic)NSString *noticeTitle;
@property(copy,nonatomic)NSString *noticeUrl;
@property(copy,nonatomic)NSNumber *noticeTag;
@end

