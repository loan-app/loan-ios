//
//  firstCell.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/20.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface firstCell : UITableViewCell
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *suptimeLab;
@property(strong,nonatomic)UILabel *scripLab;
@property(strong,nonatomic)UIView *lineView;
@property(strong,nonatomic)UIImageView *singImgView;
@property(strong,nonatomic)Event *eventObj;
@property(assign,nonatomic)NSInteger length;
@property(assign,nonatomic)NSInteger row;
@end
