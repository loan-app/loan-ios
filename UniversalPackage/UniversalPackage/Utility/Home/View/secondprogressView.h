//
//  secondprogressView.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/20.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface secondprogressView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSArray *titleArr;
@property(strong,nonatomic)NSArray *detailArr;
@property(strong,nonatomic)UIView *backView;
@property(strong,nonatomic)UITableView *tableview;
@property(strong,nonatomic)UIButton *confirmBtn;
@property(copy,nonatomic)void(^repayBack)(NSString *url);
@property(strong,nonatomic)Order *orderObj;
@end
