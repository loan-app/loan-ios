//
//  OrderDetailViewController.m
//  UniversalPackage
//
//  Created by cyc on 2019/10/27.
//  Copyright © 2019 Levin. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()

//@property (nonatomic, strong) UILabel *

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账单详情";
}

#pragma mark - setter & getter

- (void)setOrder:(Order *)order {

    _order = order;
    [self requestOrderDetail];
}

//获取订单详情
- (void)requestOrderDetail {
    
    [[NetworkUtils sharedInstance]getCurrentLoanOrderWithUtilsSuccess:^(id response) {
        if ([BaseTool responseWithNetworkDealResponse:response]) {
        }else{
        }
    } utilsFail:^(NSString *error) {
        [MBProgressHUD bnt_showError:error];
    }];
}

@end
