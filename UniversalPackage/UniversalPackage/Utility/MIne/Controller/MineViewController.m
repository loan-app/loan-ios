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
@interface MineViewController ()<HeadViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic)MineHeadView *headView;
@property(strong,nonatomic)NSArray *dataArr;
@end
static NSString *mineCell = @"minecell";
@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.BaseNavgationBar.hidden =YES;
    self.view.backgroundColor = kF5F5F5Color;
    [self setupUI];
    _dataArr = @[@[@"我的资料",@"查看资料"],@[@"借款记录",@"查看记录"],@[@"银行卡",@"查看银行卡"],@[@"帮助中心",@"查看帮助中心"],@[@"更多",@"查看更多"]];
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
                self.headView.phoneLab.text = response[@"data"][@"userPhone"];
            }
        } utilsFail:^(NSString *error) {
        }];
    }else{
        self.headView.phoneLab.text = @"点击登录";
        
    }
    
}
-(void)setupUI{
    [self.view addSubview:self.headView];
    [self.view addSubview:self.collectionView];
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
