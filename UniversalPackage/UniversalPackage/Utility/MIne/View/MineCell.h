//
//  MineCell.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/20.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCell : UICollectionViewCell
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *nameLab;
@property(copy,nonatomic)NSArray *dataArr;
@end
