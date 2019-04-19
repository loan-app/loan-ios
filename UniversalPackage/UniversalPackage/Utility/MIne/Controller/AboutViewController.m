//
//  AboutViewController.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/20.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "AboutViewController.h"
#import "FeedBackViewController.h"
#import "BaseCell.h"
@interface AboutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableview;
@property(strong,nonatomic)NSArray *dataArr;
@property(strong,nonatomic)UIButton *loginOutBtn;
@end
static NSString *baseCellId = @"baseCell";
@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGB(245, 245, 245);
    self.BaseNavgationBar.title =  @"更多";
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.loginOutBtn];
    [self initData];
    // Do any additional setup after loading the view.
}
-(void)initData{
    _dataArr =  @[@"意见反馈"];
    [self.tableview reloadData];
}
-(UIButton *)loginOutBtn{
    if (!_loginOutBtn) {
        _loginOutBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableview.frame)+10, kWidth, 50)];
        [_loginOutBtn setTitle:@"退出账号" forState:UIControlStateNormal];
        _loginOutBtn.backgroundColor = kWhiteColor;
        [_loginOutBtn setTitleColor:k333Color forState:UIControlStateNormal];
        [_loginOutBtn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginOutBtn;
}
-(void)loginOut{
    [BaseTool loginOutUser];
    [self.navigationController popViewControllerAnimated:YES];
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWidth, 50) style:UITableViewStylePlain];
        [_tableview registerClass:[BaseCell class] forCellReuseIdentifier:baseCellId];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate   = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseCell *cell  = [tableView dequeueReusableCellWithIdentifier:baseCellId forIndexPath:indexPath];
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FeedBackViewController *feedVC = [[FeedBackViewController alloc]init];
    [self.navigationController pushViewController:feedVC animated:YES];
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
