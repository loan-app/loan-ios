//
//  FeedBackViewController.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/6/15.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "FeedBackViewController.h"
#import "OpinionTextViewTableCell.h"
#import "UploadPhotoCell.h"

static NSString * kOpinionTypeCell = @"kOpinionTypeCell";
static NSString * kOpinionTextCell = @"kOpinionTextCell";
static NSString * kUploadPhotoCell = @"kUploadPhotoCell";
@interface FeedBackViewController ()<UpLoadDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSString * typeString;
@property (nonatomic, strong) NSArray * selectPhotoAry;
@property (nonatomic, strong) OpinionTextViewTableCell *opinionTextView;
@property (nonatomic, copy) NSString * questionImgOne;
@property (nonatomic, copy) NSString * questionImgTwo;
@property (nonatomic, copy) NSString * questionImgThree;

@property(strong,nonatomic)UITableView *baseTableView;
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.BaseNavgationBar.backgroundColor = kWhiteColor;
    self.BaseNavgationBar.title = @"意见反馈";
    [self initTabelView];
}



- (void)initTabelView {
    [self.view addSubview:self.baseTableView];
    [self.baseTableView registerClass:[OpinionTextViewTableCell class] forCellReuseIdentifier:kOpinionTextCell];
    [self.baseTableView registerClass:[UploadPhotoCell class] forCellReuseIdentifier:kUploadPhotoCell];
    
}
-(UITableView *)baseTableView{
    if (!_baseTableView) {
        _baseTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWidth, kHeight-kNavBarHeight) style:UITableViewStylePlain];
        _baseTableView.delegate =self;
        _baseTableView.dataSource = self;
    }
    return _baseTableView;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0){
        _opinionTextView = [tableView dequeueReusableCellWithIdentifier:kOpinionTextCell];
        if (_opinionTextView == nil) {
            _opinionTextView = [[OpinionTextViewTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kOpinionTextCell];
        }
        return _opinionTextView;
    }
    else {
        UploadPhotoCell * upLoadCell = [tableView dequeueReusableCellWithIdentifier:kUploadPhotoCell];
        if (upLoadCell == nil) {
            upLoadCell = [[UploadPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kUploadPhotoCell];
        }
        upLoadCell.selectionStyle = UITableViewCellSelectionStyleNone;
        upLoadCell.delegate = self;
        return upLoadCell;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return BntAltitude(200);
    }else{
        return BntAltitude(100);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return BntAltitude(43);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return BntAltitude(70);
    }else {
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView * buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, BntAltitude(90))];
        UIButton * submitBtn = [UIButton configureOnNormalFont:Font(kFont) titleColor:kWhiteColor backGround:k595Color title:@"提交反馈" cornerRadius:BntLength(22) borderWith:0.0f borderColor:kWhiteColor.CGColor];
        [buttonView addSubview:submitBtn];
        submitBtn.frame = CGRectMake(BntLength(37), BntAltitude(40), kWidth - BntLength(74), BntAltitude(44));
        
        [submitBtn addTarget:self action:@selector(submitOpinionCellBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.baseTableView addSubview:buttonView];
        return buttonView;
    }else {
        return  nil;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, BntAltitude(43))];
    view1.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    UILabel * sectionLabel = [UILabel configWithFont:Font(kFont) TextColor:ksixsixColor background:kTableViewColor title:@""];
    [sectionLabel sizeToFit];
    [view1 addSubview:sectionLabel];
    [sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1).mas_offset(BntLength(20));
        make.top.equalTo(view1).mas_offset(BntAltitude(13));
        make.height.mas_offset(BntAltitude(17));
    }];
    if(section == 0) {
        sectionLabel.text = @"问题描述（必填）";
        return view1;
    }else{
        sectionLabel.text = @"问题截图（最多三张，选填）";
        return view1;
    }
}


#pragma mark - 选择的类型



- (void)upLoadDelegateWithAry:(NSArray *)photoAry {
    _selectPhotoAry = photoAry;
    //    NSLog(@"-----%ld----", _selectPhotoAry.count);
}

#pragma mark - 提交意见反馈按钮事件

- (void)submitOpinionCellBtnAction:(UIButton *)sender {

    kWeakSelf(self);
    if (_selectPhotoAry.count != 0) {
        sender.enabled = NO;
       
        if (self.selectPhotoAry.count == 1) {
            [[NetworkUtils sharedInstance] uploadImgWith:self.selectPhotoAry[0] MaxLength:100 utilsSuccess:^(id response) {
                if ([BaseTool responseWithNetworkDealResponse:response]) {
                    if (isValidStr(response[@"data"][@"url"])) {
                        [weakself submitFeedBack:response[@"data"][@"url"]];
                    }
                }
            } utilsFail:^(NSString *error) {
                NSLog(@"%@",error);
            }];
        }else if (self.selectPhotoAry.count == 2) {
            [MBProgressHUD bnt_indeterminateWithMessage:@"提交中,请稍候" toView:self.view];
            dispatch_queue_t queue = dispatch_queue_create("two", DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(queue, ^{
                [[NetworkUtils sharedInstance] uploadImgWith:self.selectPhotoAry[0] MaxLength:100  utilsSuccess:^(id response) {
                    if ([BaseTool responseWithNetworkDealResponse:response]) {
                        if (isValidStr(response[@"data"][@"url"])) {
                            weakself.questionImgOne = response[@"data"][@"url"];
                        }
                    }
                } utilsFail:^(NSString *error) {
                    
                }];
            });
            dispatch_barrier_async(queue, ^{
                [[NetworkUtils sharedInstance] uploadImgWith:self.selectPhotoAry[1] MaxLength:100  utilsSuccess:^(id response) {
                    if ([BaseTool responseWithNetworkDealResponse:response]) {
                        if (isValidStr(response[@"data"][@"url"])) {
                            weakself.questionImgTwo = response[@"data"][@"url"];
                        }
                        if (isValidStr(weakself.questionImgOne) || isValidStr(weakself.questionImgTwo)) {
                            [weakself submitFeedBack:[NSString stringWithFormat:@"%@|%@", weakself.questionImgOne, weakself.questionImgTwo]];
                        }
                    }
                } utilsFail:^(NSString *error) {
                    
                }];
            });

            
        }else {
            
            [MBProgressHUD bnt_indeterminateWithMessage:@"提交中,请稍候" toView:self.view];
            dispatch_queue_t queue = dispatch_queue_create("three", DISPATCH_QUEUE_CONCURRENT);
            dispatch_async(queue, ^{
                [[NetworkUtils sharedInstance] uploadImgWith:self.selectPhotoAry[0] MaxLength:100  utilsSuccess:^(id response) {
                    if ([BaseTool responseWithNetworkDealResponse:response]) {
                        if (isValidStr(response[@"data"][@"url"])) {
                            weakself.questionImgOne = response[@"data"][@"url"];
                        }
                    }
                } utilsFail:^(NSString *error) {
                    
                }];
                [[NetworkUtils sharedInstance] uploadImgWith:self.selectPhotoAry[1] MaxLength:100  utilsSuccess:^(id response) {
                    if ([BaseTool responseWithNetworkDealResponse:response]) {
                        if (isValidStr(response[@"data"][@"url"])) {
                            weakself.questionImgTwo = response[@"data"][@"url"];
                        }
                        
                    }
                } utilsFail:^(NSString *error) {
                    
                }];
            });
            dispatch_barrier_async(queue, ^{
                [[NetworkUtils sharedInstance] uploadImgWith:self.selectPhotoAry[2] MaxLength:100  utilsSuccess:^(id response) {
                    if ([BaseTool responseWithNetworkDealResponse:response]) {
                        if (isValidStr(response[@"data"][@"url"])) {
                            weakself.questionImgThree = response[@"data"][@"url"];
                            if (isValidStr(weakself.questionImgOne) && isValidStr(weakself.questionImgTwo) && isValidStr(weakself.questionImgThree)) {
                                [weakself submitFeedBack:[NSString stringWithFormat:@"%@|%@|%@", weakself.questionImgOne, weakself.questionImgTwo, weakself.questionImgThree]];
                            }
                        }
                    }
                } utilsFail:^(NSString *error) {
                    
                }];
                
                
            });

        }

        sender.enabled = YES;
    }else if (!isValidStr(self.opinionTextView.opionView.yiJianTextView.oponionTextView.text)){
        [MBProgressHUD bnt_showMessage:@"请填写必选项!" delay:kMubDelayTime];
    }else {
        //不提交照片
        sender.enabled = NO;
        [self submitFeedBack:@""];
        sender.enabled = YES;
    }
}

- (void)submitFeedBack:(NSString *)questionImg {
    kWeakSelf(self);
    [[NetworkUtils sharedInstance] feedBackWithNetWorkType:@"其他问题" questionDesc:_opinionTextView.opionView.yiJianTextView.oponionTextView.text questionImg:questionImg UtilsSuccess:^(id response) {
        if ([BaseTool responseWithNetworkDealResponse:response]) {
            [MBProgressHUD hideHUDView:self.view];
            [MBProgressHUD bnt_showMessage:@"感谢您的反馈" delay:kMubDelayTime];
            [weakself.navigationController popViewControllerAnimated:YES];
        }else {
            [MBProgressHUD bnt_showMessage:response[kMessageStr] delay:kMubDelayTime];
        }
    } utilsFail:^(NSString *error) {
        [MBProgressHUD bnt_showMessage:error delay:kMubDelayTime];
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = BntAltitude(43);
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
}







@end
