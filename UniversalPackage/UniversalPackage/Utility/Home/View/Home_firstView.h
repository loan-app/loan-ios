//
//  Home_firstView.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/17.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home_firstView : UIView
@property(strong,nonatomic)UILabel *positionLab;
@property(strong,nonatomic)UILabel *moneyLab;
@property(strong,nonatomic)UILabel *scriptionLab;
@property(strong,nonatomic)UIView  *topView;
@property(strong,nonatomic)UILabel *buttomLab;
@property(strong,nonatomic)UIButton *confirmBtn;
@property(copy,nonatomic)void(^confirmClickBack)(NSString *url);
@property(strong,nonatomic)NSDictionary *dataDic;
@end
