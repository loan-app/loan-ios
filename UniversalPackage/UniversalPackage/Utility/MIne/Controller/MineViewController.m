//
//  MineViewController.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/17.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "AboutViewController.h"
#import "MineHeadView.h"
#import "MineCell.h"
#import "RealNameViewController.h"
#import "FaceViewController.h"
#import "KelePersonViewController.h"
@interface MineViewController ()<HeadViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>
@property(strong,nonatomic)MineHeadView *headView;
@property(strong,nonatomic)NSArray *dataArr;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *loginBtn;
@end
static NSString *mineCell = @"minecell";
@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.BaseNavgationBar.title = @"我的";
    self.view.backgroundColor = kF5F5F5Color;
    [self setupUI];
    _dataArr = @[@[@"我的资料",@"查看资料"],@[@"借款记录",@"查看记录"],@[@"银行卡",@"查看银行卡"],@[@"帮助中心",@"查看帮助中心"],@[@"更多",@"查看更多"]];
    self.dataArr = @[@"我的账单",@"我的银行卡",@"相关协议"];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
    
}
-(void)initData{
    if (kisToken) {
        [[NetworkUtils sharedInstance]rewordPersonInfoWithUtilsSuccess:^(id response) {
            if ([BaseTool responseWithNetworkDealResponse:response]) {
                if ([BaseTool Imageisexit:response[@"data"][@"imgHead"]]) {
                    [self.headView.headImgView sd_setImageWithURL:response[@"data"][@"imgHead"]];
                }
                //self.headView.phoneLab.text = response[@"data"][@"userPhone"];
                [self.loginBtn setTitle:@"退出登录" forState:normal];
            }
        } utilsFail:^(NSString *error) {
        }];
    }else{
        //self.headView.phoneLab.text = @"点击登录";
        [self.loginBtn setTitle:@"立即登录" forState:normal];
    }
    
}
-(void)setupUI{
    //[self.view addSubview:self.headView];
    //[self.view addSubview:self.collectionView];
    [self.view addSubview:self.tableView];
}
-(MineHeadView *)headView{
    if (!_headView) {
        _headView = [[MineHeadView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 184)];
        _headView.backgroundColor = kWhiteColor;
        _headView.hdelegate = self;
    }
    return _headView;
}
-(void)clickWithHeadView:(UIGestureRecognizer *)sender{
    if (kisToken) {
        //        sender.view.userInteractionEnabled = NO;
    }else{
        //        sender.view.userInteractionEnabled = YES;
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, self.view.frame.size.width, self.view.frame.size.height - kNavBarHeight) style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorColor = kRGB(187, 187, 187);
    }
    return _tableView;
}

- (UIView *)footerView {
    
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 140)];
        [_footerView addSubview:self.loginBtn];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.5)];
        line.backgroundColor = kRGB(187, 187, 187);
        [_footerView addSubview:line];
    }
    return _footerView;
}

- (UIButton *)loginBtn {
    
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(26, 100, self.view.frame.size.width - 52, 40);
        [_loginBtn setTitle:@"立即登录" forState:normal];
        [_loginBtn setTitleColor:kRGB(16, 16, 16) forState:normal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _loginBtn.layer.borderColor = kRGB(187, 187, 187).CGColor;
        _loginBtn.layer.borderWidth = 1.f;
        _loginBtn.layer.cornerRadius = 4.f;
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (void)loginBtnClick {
    
    if (!kisToken) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    } else {
        [MBProgressHUD bnt_indeterminateWithMessage:@"" toView:self.view];
        kWeakSelf(self)
        [[NetworkUtils sharedInstance] loginOutWithUtilsSuccess:^(id response) {
            [MBProgressHUD hideHUDView:weakself.view];
            if ([BaseTool responseWithNetworkDealResponse:response]) {
                [self.loginBtn setTitle:@"立即登录" forState:normal];
            } else {
                [MBProgressHUD bnt_showMessage:response[kMessageStr] delay:kMubDelayTime];
            }
        } utilsFail:^(NSString *error) {
            [MBProgressHUD hideHUDView:weakself.view];
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 62.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 140;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    for (UIView *v in cell.contentView.subviews) {
        [v removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!kisToken) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    } else {
        KeleWebToolViewController *webVC = [[KeleWebToolViewController alloc]init];
        NSString *pathString = @"";
        switch (indexPath.row) {
            case 0://我的账单
            {
                pathString = korderHistoryHtml;
            }
                break;
            case 1://我的银行卡
            {
                pathString = kBankCardHtml;
            }
                break;//相关协议
            case 2:
            {
                pathString = [NSString stringWithFormat:@"%@%@",kRegisterAgreement, kAliasName];
            }
                break;
            default:
                break;
        }
        
        webVC.loadUrlString = [NSString stringWithFormat:@"%@%@",kHTTPH5, pathString];
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout. itemSize = CGSizeMake((kWidth-30)/2, 80);
        _layout.minimumLineSpacing =10;
        _layout.minimumInteritemSpacing =1;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame)+10, kWidth, 300) collectionViewLayout:_layout];
        [_collectionView registerClass:[MineCell class] forCellWithReuseIdentifier:mineCell];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kF5F5F5Color;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
    }
    return _collectionView;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);//top  left buttom right;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:mineCell forIndexPath:indexPath];
    cell.dataArr = self.dataArr[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (kisToken) {
        if (indexPath.row == 4) {
            AboutViewController *aboutVC = [[AboutViewController alloc]init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }else{
            KeleWebToolViewController *webVC = [[KeleWebToolViewController alloc]init];
            if (indexPath.row == 0) {
                webVC.loadUrlString = [NSString stringWithFormat:@"%@%@",kHTTPH5,kcenterHtml];
            }else if(indexPath.row ==1){
                webVC.loadUrlString = [NSString stringWithFormat:@"%@%@",kHTTPH5,korderHistoryHtml];
                
            }else if (indexPath.row == 2){
                webVC.loadUrlString = [NSString stringWithFormat:@"%@%@",kHTTPH5,kBankCardHtml];
                
            }else if (indexPath.row == 3){
                webVC.loadUrlString = [NSString stringWithFormat:@"%@%@",kHTTPH5,kHelpCenterHtml];
                
            }
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
