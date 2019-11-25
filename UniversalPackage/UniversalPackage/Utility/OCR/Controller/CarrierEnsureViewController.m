//
//  CarrierEnsureViewController.m
//  UniversalPackage
//
//  Created by cyc on 2019/11/6.
//  Copyright © 2019 Levin. All rights reserved.
//

#import "CarrierEnsureViewController.h"

@interface CarrierEnsureViewController()

@property (nonatomic, strong) UITextField *phoneNumText;
@property (nonatomic, strong) UITextField *nameText;
@property (nonatomic, strong) UITextField *IDText;
@property (nonatomic, strong) UITextField *pswText;

@property (nonatomic, strong) UIScrollView *bgScrollView;

@end

@implementation CarrierEnsureViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.BaseNavgationBar.title = @"运营商认证";
    
    kWeakSelf(self);
    self.BaseNavgationBar.leftClickBack = ^{
        [weakself.navigationController popToRootViewControllerAnimated:YES];
    };
    
    [self setupUI];
}

- (void)setupUI {
    
    self.bgScrollView = [[UIScrollView alloc] init];
    self.bgScrollView.backgroundColor = kRGB(235, 235, 235);
    self.bgScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.bgScrollView];
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(0);
        make.top.mas_equalTo(kNavBarHeight);
    }];
    
    self.phoneNumText = [UITextField new];
    self.phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    self.nameText = [UITextField new];
    self.IDText = [UITextField new];
    self.IDText.keyboardType = UIKeyboardTypeAlphabet;
    self.pswText = [UITextField new];
    self.pswText.keyboardType = UIKeyboardTypeNumberPad;
    NSArray *icons = @[@"shouji.png",@"xingming.png",@"shenfenzheng.png",@"mima.png"];
    NSArray *titles = @[@"手机号码：",@"姓名：    ",@"身份证：  ",@"服务密码："];
    NSArray *placeHolders = @[@"手机号码",@"姓名",@"身份证号",@"请输入您的服务密码"];
    NSArray *textFields = @[self.phoneNumText,self.nameText,self.IDText,self.pswText];
    
    for (int index = 0; index < 4; index ++) {
        [self addViewWithIcon:icons[index]
                        title:titles[index]
                    textField:textFields[index]
                  placeHolder:placeHolders[index]
                        index:index];
    }
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:normal];
    [commitBtn setTitle:@"确认提交" forState:normal];
    commitBtn.layer.cornerRadius = 5;
    commitBtn.backgroundColor = kRGB(0.35 * 255, 0.36 * 255, 0.82 * 255);
    [commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgScrollView addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(4 * 60 + 40);
        make.leading.mas_equalTo(20);
        make.width.mas_equalTo(kWidth - 40);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *tipLabel = [UILabel new];
    tipLabel.text = @"温馨提示：";
    tipLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.bgScrollView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(commitBtn);
        make.top.mas_equalTo(commitBtn.mas_bottom).with.offset(30);
    }];
    
    UILabel *pswTipLabel = [UILabel new];
    pswTipLabel.text = @"服务密码：";
    pswTipLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.bgScrollView addSubview:pswTipLabel];
    [pswTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(tipLabel);
        make.top.mas_equalTo(tipLabel.mas_bottom);
    }];
    
    UILabel *detailLabel = [UILabel new];
    detailLabel.numberOfLines = 0;
    detailLabel.font = [UIFont systemFontOfSize:14];
    detailLabel.text = @"由一组6位或者8位阿拉伯数字组成客户身份识别密码。\n忘记服务密码？怎么办：\n电信：发送免费短信指令“MMXG#旧密码#新密码”到10001，或者拨打10000按照语音提示一步步操作\n联通：发送免费短信指令“MMCZ#6位新密码”到10010，或者拨打10010按照语音提示一步步操作\n移动：拨打10086，拨通后按拨号键“4”，然后按“1”选择【忘记密码服务】，然后再根据语音提示输入身份证号后根据提示继续操作，直至提示密码修改成功，一般会有一条含有服务密码的短信提醒，妥善保存";
    [self.bgScrollView addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(pswTipLabel);
        make.top.mas_equalTo(pswTipLabel.mas_bottom);
        make.width.mas_equalTo(kWidth - 40);
    }];
    
    [self.bgScrollView updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(detailLabel.mas_bottom).with.offset(40);
    }];
    
}

- (void)addViewWithIcon:(NSString *)icon
                   title:(NSString *)title
               textField:(UITextField *)textField
             placeHolder:(NSString *)placeHolder
                   index:(NSInteger)index
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, index * 60, kWidth, 60)];
    view.backgroundColor = [UIColor whiteColor];
    [self.bgScrollView addSubview:view];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    [view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(30);
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = title;
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(img.mas_trailing).with.offset(10);
        make.centerY.mas_equalTo(0);
    }];
    
    textField.placeholder = placeHolder;
    [view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.trailing.mas_equalTo(view.mas_trailing);
        make.leading.mas_equalTo(titleLabel.mas_trailing).with.offset(10);
    }];
    if (index != 0) {
        UIView *line = [UIView new];
        line.backgroundColor = kLineColor;
        [view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(15);
            make.trailing.mas_equalTo(- 15);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
}

- (void)commitBtnClick {
    
    if (self.phoneNumText.text.length == 0) {
        [MBProgressHUD bnt_showMessage:@"请填写手机号"  delay:1];
        return;
    }
    
    if (self.nameText.text.length == 0) {
        [MBProgressHUD bnt_showMessage:@"请输入姓名"  delay:1];
        return;
    }
    
    if (self.IDText.text.length == 0) {
        [MBProgressHUD bnt_showMessage:@"请输入身份证号"  delay:1];
        return;
    }
    
    if (self.pswText.text.length == 0) {
        [MBProgressHUD bnt_showMessage:@"请输入服务密码"  delay:1];
        return;
    }
    [MBProgressHUD bnt_indeterminateWithMessage:@"" toView:self.view];
    kWeakSelf(self)
    [[NetworkUtils sharedInstance] carrierEnsureWithPhoneNum:self.phoneNumText.text
                                                        name:self.nameText.text
                                                          ID:self.IDText.text
                                                         psw:self.pswText.text
                                                utilsSuccess:^(id response)
    {
        [MBProgressHUD hideHUDView:weakself.view];
        if ([BaseTool responseWithNetworkDealResponse:response]) {
            [weakself.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [MBProgressHUD bnt_showMessage:response[kMessageStr] delay:kMubDelayTime];
        }
    } utilsFail:^(NSString *error) {
        [MBProgressHUD hideHUDView:weakself.view];
    }];
}

@end
