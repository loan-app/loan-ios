//
//  secondCell.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/20.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface secondCell : UITableViewCell
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *suptitleLab;
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *detail;
@property(assign,nonatomic)NSInteger status;
@end
