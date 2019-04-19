//
//  HomeViewController.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/17.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController
@property (nonatomic, assign) BOOL isHeaderRefresh;
@property (nonatomic, assign) BOOL isFooterRefresh;


//头部刷新的方法
- (void)headerRefresh;
//停止刷新方法
- (void)headerendRefreshing ;
@end
