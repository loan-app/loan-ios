//
//  firstProgressView.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/20.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface firstProgressView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableview;
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)NSArray *eventArr;
@end
