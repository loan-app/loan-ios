//
//  HomeViewController.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/17.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "StartoverView.h"

#import "Home_firstView.h"
#import "firstProgressView.h"
#import "secondprogressView.h"
#import "Home_secondView.h"
#import "YokycleScrollView.h"
#import "RollingView.h"
#import "OrderDetailViewController.h"

#import "RealNameViewController.h"
#import "KelePersonViewController.h"
#import "FaceViewController.h"
#import "CarrierEnsureViewController.h"

static NSString *cellIdentifier = @"baseCell";
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,CDDRollingDelegate,YokycleScrollViewDelegate,SecondProgressViewDelegate>
@property(strong,nonatomic)UITableView *basetableview;
@property(strong,nonatomic)UIView *headView;
@property(strong,nonatomic)UIView *buttomView;

@property(strong,nonatomic)RollingView *rollingView;
@property(strong,nonatomic)YokycleScrollView *scrollView;

@property(strong,nonatomic)Home_firstView *firstView;
@property(strong,nonatomic)firstProgressView *firstProView;
@property(strong,nonatomic)secondprogressView *secondProView;
@property(strong,nonatomic)Home_secondView *secondView;
@property(strong,nonatomic)NSArray *ImgNameArr;
@property(strong,nonatomic)NSArray *NoticeArr;
@property(strong,nonatomic)UIImageView *bannerImgView;
@end
@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.BaseNavgationBar.title = @"首页";
    [self setupUI];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
}
-(void)setupUI{
    self.BaseNavgationBar.backgroundColor = kWhiteColor;
    [self.view addSubview:self.basetableview];
    self.basetableview.tableHeaderView = self.headView;
    [self.headView addSubview:self.rollingView];
    [self.headView addSubview:self.scrollView];
    [self.headView addSubview:self.bannerImgView];
    [self.headView addSubview:self.buttomView];
    [self.buttomView addSubview:self.firstView];
    [self setUpContanConstraints];
}
-(void)setUpContanConstraints{

    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(kWidth);
        make.height.mas_equalTo(120 * kscale);
    }];
    [self.bannerImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(kWidth);
        make.height.mas_equalTo(120 * kscale);
    }];
    [self.rollingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom);
        make.width.mas_equalTo(kWidth);
        make.height.mas_equalTo(30);
    }];

    [self.buttomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rollingView.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kWidth);
        make.height.mas_equalTo(500);
    }];
    
}

-(void)initData{
    kWeakSelf(self);
        [[NetworkUtils sharedInstance]getCurrentLoanOrderWithUtilsSuccess:^(id response) {
            if ([BaseTool responseWithNetworkDealResponse:response]) {
                [weakself selectUI:response];
            }else{
                [self.buttomView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [self.buttomView addSubview:self.firstView];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary ];
                [dic setObject:@"200~2w" forKey:@"amount"];
                [dic setObject:@"填写身份资料即可借款" forKey:@"descTop"];
                [dic setObject:@"立即借款" forKey:@"descMid"];
                self.firstView.dataDic = dic;
            }
        } utilsFail:^(NSString *error) {
            [MBProgressHUD bnt_showError:error];
        }];
    
//        [[NetworkUtils sharedInstance]rewordBannerAndNoticeutilSuccess:^(id response) {
//            if ([BaseTool responseWithNetworkDealResponse:response]) {
//                self.ImgNameArr = [NSArray yy_modelArrayWithClass:[Banner class] json:response[@"data"][@"banner"]];
//                self.NoticeArr = [NSArray yy_modelArrayWithClass:[Notice class] json:response[@"data"][@"notice"] ];
//                [weakself selectNotice];
//                [self headerendRefreshing];
//                
//            }else{
//                [self headerendRefreshing];
//            }
//        } utilsFail:^(NSString *error) {
//            [self headerendRefreshing];
//            [MBProgressHUD bnt_showError:error];
//        }];
  

}
/** 根据数据判断入口 **/
-(void)selectNotice{
    if (self.NoticeArr.count>0) {
        NSMutableArray *mArr = [NSMutableArray array];
        for (Notice *notiObj in self.NoticeArr) {
            [mArr addObject:notiObj.noticeTitle];
        }
        self.rollingView.dataArr = mArr;
        self.rollingView.hidden = NO;
        [self.rollingView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
        }];
    }else{
        [self.rollingView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        self.rollingView.hidden = YES;
    }
    if (self.ImgNameArr.count>0) {
        self.scrollView.hidden = NO;
        self.scrollView.dataArr = self.ImgNameArr;
        self.bannerImgView.hidden = YES;
    }else{
        self.scrollView.hidden = YES;
        self.bannerImgView.hidden = NO;
    }

}

-(void)selectUI:(id)response{
    [self.buttomView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger index = [ response[@"data"][@"orderStatus"] integerValue];
    switch (index) {
        case 0:
        {
            [self loanSelect];
        }
            break;
        case 1:
        {
            [self.buttomView addSubview:self.firstProView];
            NSArray *arr =response[@"data"][@"loanBeforeList"] ;
            self.firstProView.eventArr = [NSArray yy_modelArrayWithClass:[Event class] json:arr];
            
        }
            break;
        case 2:
        {
            [self.buttomView addSubview:self.secondView];
            
            self.secondView.orderObj = [Order yy_modelWithJSON:response[@"data"]];
        }
            break;
        case 3:{//待还款
            
            [self.buttomView addSubview:self.secondProView];
            self.secondProView.orderObj = [Order yy_modelWithJSON:response[@"data"]];
        }
            break;
        case 4:{//已逾期
            
            [self.buttomView addSubview:self.secondProView];
            self.secondProView.orderObj = [Order yy_modelWithJSON:response[@"data"]];
        }
            break;
            
        default:
            break;
    }

}

-(void)loanSelect{
    [self.buttomView addSubview:self.firstView];
    [[NetworkUtils sharedInstance]getorderHomeWithUtilsSuccess:^(id response) {
        if ([BaseTool responseWithNetworkDealResponse:response]) {
            self.firstView.dataDic = response[@"data"];
        }else{
            NSLog(@"2");
        }
    } utilsFail:^(NSString *error) {
        [MBProgressHUD bnt_showError:error];
    }];
}

#pragma mark - delegate
- (void)orderDetail:(Order *)order {
    KeleWebToolViewController *webVC = [[KeleWebToolViewController alloc]init];
    webVC.loadUrlString = order.url;//[NSString stringWithFormat:@"%@%@%@",kHTTPH5, kOrderDetail,order.orderId];
    [self.navigationController pushViewController:webVC animated:YES];
}

/** UI懒加载 **/
-(RollingView *)rollingView{
    if (!_rollingView) {
        _rollingView = [[RollingView alloc]initWithFrame:CGRectMake(0, 1, kWidth, 30) LeftImage:@"ic_notice" Interval:4 RollingTime:0.2 TitleFont:14 TitleColor:k333Color];
        _rollingView.delegate = self;
        _rollingView.backgroundColor = kWhiteColor;
    }
    return _rollingView;
}
-(void)dc_RollingViewSelectWithActionAtIndex:(NSInteger)index{
    Notice *notObj = self.NoticeArr[index];
    if (isValidStr(notObj.noticeUrl)) {
        KeleWebToolViewController *webVC = [[KeleWebToolViewController alloc]init];
        webVC.loadUrlString = notObj.noticeUrl;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
-(YokycleScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[YokycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth,120 * kscale)];
        _scrollView.delegate = self;
    }
    return _scrollView;
}
-(void)cycleScrollView:(YokycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    Banner *banObj = self.ImgNameArr[index];
    if (isValidStr(banObj.bannerUrl)) {
        KeleWebToolViewController *webVC = [[KeleWebToolViewController alloc]init];
        webVC.loadUrlString = banObj.bannerUrl;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

-(UIImageView *)bannerImgView{
    if (!_bannerImgView) {
        _bannerImgView = [[UIImageView alloc]init];
        _bannerImgView.image = kImageName(@"banner.jpeg");
        _bannerImgView.hidden = NO;
    }
    return _bannerImgView;
}
-(UIView *)buttomView{
    if (!_buttomView) {
        _buttomView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, kWidth, 500)];

    }
    return _buttomView;
}
-(Home_firstView *)firstView{
    if (!_firstView) {
        kWeakSelf(self);
        _firstView = [[Home_firstView alloc]initWithFrame:CGRectMake(0, 0, self.buttomView.frame.size.width
                                                                     , self.buttomView.frame.size.height-40)];
        _firstView.confirmClickBack = ^(NSString *url) {
            [weakself firstViewClick:url];
        };
    }
    return _firstView;
}
-(void)firstViewClick:(NSString *)url{
    kWeakSelf(self);
    if (kisToken) {
        [[NetworkUtils sharedInstance] getUserStatusWithUtilsSuccess:^(id response) {
            
            if ([BaseTool responseWithNetworkDealResponse:response]) {
                NSDictionary *result = response[@"data"];
                if (!result[@"realName"] || ([result[@"realName"] integerValue] != 2 && [result[@"realName"] integerValue] != 1)) {
                    RealNameViewController *realNameVC = [RealNameViewController new];
                    [weakself.navigationController pushViewController:realNameVC animated:YES];
                    return ;
                }
                
                if (!result[@"userDetails"] || ([result[@"userDetails"] integerValue] != 2 && [result[@"userDetails"] integerValue] != 1)) {
                    KelePersonViewController *personVC = [KelePersonViewController new];
                    [weakself.navigationController pushViewController:personVC animated:YES];
                    return ;
                }
                
                if (!result[@"liveness"] || ([result[@"liveness"] integerValue] != 2 && [result[@"liveness"] integerValue] != 1)) {
                    FaceViewController *faceVC = [FaceViewController new];
                    [weakself.navigationController pushViewController:faceVC animated:YES];
                    return ;
                }
                
                if (!result[@"mobile"] || ([result[@"mobile"] integerValue] != 2 && [result[@"mobile"] integerValue] != 1)) {
                    CarrierEnsureViewController *carrierEnsureVC = [CarrierEnsureViewController new];
                    [weakself.navigationController pushViewController:carrierEnsureVC animated:YES];
                    return ;
                }
                if (!result[@"bindbank"] || ([result[@"bindbank"] integerValue] != 2 && [result[@"bindbank"] integerValue] != 1)) {
                    
                    KeleWebToolViewController *firstVC = [[KeleWebToolViewController alloc]init];
                    firstVC.loadUrlString = [NSString stringWithFormat:@"%@%@", kHTTPH5, kBindBank];;
                    [weakself.navigationController pushViewController:firstVC animated:YES];
                    return;
                }
                KeleWebToolViewController *firstVC = [[KeleWebToolViewController alloc]init];
                firstVC.loadUrlString = url;
                [weakself.navigationController pushViewController:firstVC animated:YES];
                
            }
        } utilsFail:^(NSString *error) {
            
        }];
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

-(Home_secondView *)secondView{
    if (!_secondView) {
        kWeakSelf(self);
        _secondView = [[Home_secondView alloc]initWithFrame:CGRectMake(0, 0,self.buttomView.frame.size.width, self.buttomView.frame.size.height)];

        _secondView.selectBack = ^(NSString *url) {
            [weakself selectCLick:url];
        };
    }
    return _secondView;
}
-(void)selectCLick:(NSString *)url{
    KeleWebToolViewController *firstVC = [[KeleWebToolViewController alloc]init];
    firstVC.loadUrlString = url;
    [self.navigationController pushViewController:firstVC animated:YES];
}

-(firstProgressView *)firstProView{
    if (!_firstProView) {
        _firstProView = [[firstProgressView alloc]initWithFrame:CGRectMake(0, 0, self.buttomView.frame.size.width, self.buttomView.frame.size.height-60)];

    }
    return _firstProView;
}

-(secondprogressView *)secondProView{
    if (!_secondProView) {
        kWeakSelf(self);
        _secondProView = [[secondprogressView alloc]initWithFrame:CGRectMake(0, 0, self.buttomView.frame.size.width, self.buttomView.frame.size.height-10)];
        _secondProView.delegate = self;
        _secondProView.repayBack = ^(NSString *url) {
            [weakself setondClick:url];
        };
    }
    return _secondProView;
}
-(void)setondClick:(NSString *)url{
    if (kisToken) {
        KeleWebToolViewController *firstVC = [[KeleWebToolViewController alloc]init];
        firstVC.loadUrlString = url;
        [self.navigationController pushViewController:firstVC animated:YES];
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}
/** 轮播图数组 **/
-(NSMutableArray *)ImgNameArr{
    if (!_ImgNameArr) {
        _ImgNameArr = [NSMutableArray array];
    }
    return _ImgNameArr;
}
-(NSMutableArray *)NoticeArr{
    if (!_NoticeArr) {
        _NoticeArr = [NSMutableArray array];
    }
    return _NoticeArr;
}

/** 没有轮播 --显示默认 **/



#pragma mark ** Tableview 初始化
-(UIView *)headView{
    if (!_headView) {
        CGFloat bheight = iPhone5s || iPhone4s ? 0 : kNavBarHeight+45;
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-bheight)];
        _headView.backgroundColor = kRGB(240, 240, 240);
    }
    return _headView;
}
-(UITableView *)basetableview{
    if (!_basetableview) {
        _basetableview = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWidth, kHeight) style:UITableViewStylePlain];
        [_basetableview registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
        _basetableview.delegate = self;
        _basetableview.dataSource = self;
        _basetableview.showsVerticalScrollIndicator = NO;
        _basetableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _basetableview.backgroundColor = kRGB(240, 240, 240);
        //self.isHeaderRefresh =YES;
    }
    return _basetableview;
}
- (void)setIsHeaderRefresh:(BOOL)isHeaderRefresh
{
    _isHeaderRefresh = isHeaderRefresh;
    if (_isHeaderRefresh) {
        MJRefreshNormalHeader *gifheader= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        gifheader.lastUpdatedTimeLabel.hidden = YES;
        [gifheader setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
        [gifheader setTitle:@"松开即可刷新" forState:MJRefreshStatePulling];
        [gifheader setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
        gifheader.lastUpdatedTimeLabel.hidden = NO;
        _basetableview.mj_header = gifheader;
        _basetableview.mj_header.automaticallyChangeAlpha = YES;
        
    }else{
        _basetableview.mj_header = nil;
    }
}
-(void)headerRefresh{
    [self initData];
}
#pragma mark -  ----------停止刷新的方法-----------
//停止刷新
- (void)headerendRefreshing {
    if (_basetableview != nil) {
        [_basetableview.mj_header endRefreshing];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
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
