//
//  contactCell.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/23.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "numModel.h"
@interface contactCell : UITableViewCell
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *phoneLab;
@property(strong,nonatomic)numModel *numObj;
@end
