//
//  Home_secondView.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/20.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home_secondView : UIView
@property(strong,nonatomic)UIImageView *imageView;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *suptitleLab;
@property(strong,nonatomic)UIView *topView;
@property(strong,nonatomic)UIButton *selectBtn;

@property(strong,nonatomic)Order *orderObj;
@property(copy,nonatomic)NSString  *url;
@property(copy,nonatomic)void(^selectBack)(NSString *url);
@end
