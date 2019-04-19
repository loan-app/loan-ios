//
//  OpinionView.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/5/31.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "OpinionTextView.h"
typedef void(^OpionionBlock)(void);
@interface OpinionView : UIView
@property (nonatomic, copy) OpionionBlock opinionBlock;
@property (nonatomic, strong) OpinionTextView * yiJianTextView;

@end
