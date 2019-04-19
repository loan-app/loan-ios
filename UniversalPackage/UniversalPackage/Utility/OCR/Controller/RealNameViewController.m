//
//  RealNameViewController.m
// RabbitConyYok
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "RealNameViewController.h"
#import "RealNameTableCell.h"
#import "NameTableViewCell.h"
#import "AlertView.h"
#import <objc/runtime.h>
#import <AipOcrSdk/AipOcrSdk.h>
static NSString * krealNameIdentiferCell = @"realNameIdentiferCell";
static NSString * kNameTableCell = @"nameTableCell";
static NSString * kuserNoTableCell = @"kuserNoTableCell";

@interface RealNameViewController ()<RealNameDelegate,UITableViewDataSource,UITableViewDelegate,BaseNavDelegate>{
    // 默认的识别成功的回调
    void (^_successHandler)(id);
    // 默认的识别失败的回调
    void (^_failHandler)(NSError *);
}
@property (nonatomic, strong) UIAlertController *alertcontroller;
@property (nonatomic, strong) AlertView *alertView;
@property (nonatomic, strong)  UIView *coverView;


@property (nonatomic, strong) NSMutableDictionary *identiFontDic; //正面照数组源 民族、性别
@property (nonatomic, strong) NSMutableDictionary *identiBehindDic; //反面照

@property (nonatomic, strong) NSString       * isSignImg;//正反面 标识
@property (nonatomic, strong) NSString       * frontImg;/**正面*/
@property (nonatomic, strong) NSString       * behindImg;/**反面*/
@property (nonatomic, strong) RealNameTableCell * realCell;
@property (nonatomic, strong) UIImage        * submitFrontImg;
@property (nonatomic, strong) UIImage        * submitBehindImg;
@property (nonatomic, strong) NameTableViewCell * nameCell;
@property (nonatomic, strong) NameTableViewCell * userNoCell;
/** reword实名
 */
@property (nonatomic, strong) NSString * rewordimgCertFront;
@property (nonatomic, strong) NSString * rewordimgCertBack;
@property (nonatomic, strong) NSString * rewordUserName;
@property (nonatomic, strong) NSString * rewordUserCertNo;
@property (nonatomic, assign) NSNumber * identStatus;//0-读写，1-只读

@property(strong,nonatomic)UITableView *baseTableView;
@end
@implementation RealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    [[AipOcrService shardService] authWithAK:kApiKey andSK:kSecretKey];
    [self setupNav];
    //识别后返回的回调信息
    [self configCallback];
    //获取实名
    [self rewordRalNameFromNetwork];
    [self.view addSubview:self.baseTableView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.coverView removeFromSuperview];

    NSLog(@"1");
}

#pragma mark - setupNav

- (void)setupNav {
    self.BaseNavgationBar.title = @"实名认证";
    self.BaseNavgationBar.delegate = self;
    self.BaseNavgationBar.rightBtn.hidden = NO;
    self.BaseNavgationBar.Rbtntitle = @"提交";
    self.BaseNavgationBar.backgroundColor = kWhiteColor;
}
-(void)clickWithRightBtn:(UIButton *)sender{
    if ([self.identStatus intValue] == 1) {
        
    }else{
        if (self.submitFrontImg && self.submitBehindImg) {
            [self.nameCell.nameTextField resignFirstResponder];
            [self.userNoCell.nameTextField resignFirstResponder];
            NSDictionary *dic = [self.identiFontDic objectForKey:@"font"];
            NSString * userName = [self strFromDic:dic forKey:@"姓名"];
            NSString * userCerNo = [self strFromDic:dic forKey:@"公民身份号码"];
            [[AlertView sharInstance] showpopView:userName Identi:userCerNo] ;
            [AlertView confirmClick:^{
                [self submitRealNameMessage];
            }];
            [AlertView cancelClick:^{
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"editor" object:nil userInfo:nil]];
                
            }];
        }else{
            [MBProgressHUD bnt_showMessage:@"请拍摄后提交"  delay:1];
        }
    }

}

-(UIView *)coverView{
    if (!_coverView) {
        CGFloat height = iPhone5s || iPhone4s ? 70 :90;
        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight-height, kWidth, height)];
        _coverView.backgroundColor = [UIColor blackColor];
    }
    return _coverView;
}
-(UITableView *)baseTableView{
    if (!_baseTableView) {
        _baseTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWidth, kHeight-kNavBarHeight) style:UITableViewStylePlain];
        _baseTableView.delegate =self;
        _baseTableView.dataSource = self;
        _baseTableView.tableFooterView = [UIView new];
        [_baseTableView registerClass:[RealNameTableCell class] forCellReuseIdentifier:krealNameIdentiferCell];
        [_baseTableView registerClass:[NameTableViewCell class] forCellReuseIdentifier:kuserNoTableCell];
        [_baseTableView registerClass:[NameTableViewCell class] forCellReuseIdentifier:kNameTableCell];
        _baseTableView.backgroundColor = kTableViewColor;
        _baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _baseTableView;
}


-(NSMutableDictionary *)identiFontDic{
    if (!_identiFontDic) {
        _identiFontDic = [NSMutableDictionary dictionary];
    }
    return _identiFontDic;
}
-(NSMutableDictionary *)identiBehindDic{
    if (!_identiBehindDic) {
        _identiBehindDic = [NSMutableDictionary dictionary];
    }
    return _identiBehindDic;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        _realCell = [tableView dequeueReusableCellWithIdentifier:krealNameIdentiferCell forIndexPath:indexPath];
        if (_realCell == nil) {
            _realCell = [[RealNameTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:krealNameIdentiferCell];
        }
        _realCell.delegate = self;
        if (isValidStr(self.rewordimgCertFront)) {
            [_realCell.frontRealImg sd_setImageWithURL:kUrlfromStr(self.rewordimgCertFront) placeholderImage:kImageName(@"1") options:SDWebImageRetryFailed];
        }
        if (isValidStr(self.rewordimgCertBack)) {
            [_realCell.behindRealImg sd_setImageWithURL:kUrlfromStr(self.rewordimgCertBack) placeholderImage:kImageName(@"1") options:SDWebImageRetryFailed];
        }
        return _realCell;
    }else if (indexPath.section == 1 && indexPath.row == 0){
        _nameCell = [tableView dequeueReusableCellWithIdentifier:kNameTableCell forIndexPath:indexPath];
        if (_nameCell == nil) {
            _nameCell = [[NameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kNameTableCell];
        }
        _nameCell.nameLeftLbl.text = @"姓名";
        NSDictionary *dic = [[self.identiFontDic objectForKey:@"font"] objectForKey:@"姓名"]  ;
        NSString *str = [dic objectForKey:@"words"];
        if (isValidStr(str)) {
            _nameCell.nameTextField.text = str;
        }
        if (isValidStr(self.rewordUserName)) {
            _nameCell.nameTextField.text = self.rewordUserName;
        }
        return _nameCell;
    }else {
        _userNoCell = [tableView dequeueReusableCellWithIdentifier:kuserNoTableCell forIndexPath:indexPath];
        if (_userNoCell == nil) {
            _userNoCell = [[NameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kuserNoTableCell];
        }
        _userNoCell.nameLeftLbl.text = @"身份证";
        NSDictionary *dic = [[self.identiFontDic objectForKey:@"font"] objectForKey:@"公民身份号码"]  ;
        NSString *str = [dic objectForKey:@"words"];
        if (isValidStr(str)) {
            _userNoCell.nameTextField.text = str;
        }
        if (isValidStr(self.rewordUserCertNo)) {
            _userNoCell.nameTextField.text = self.rewordUserCertNo;
        }
        return _userNoCell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return BntAltitude(38);
    }else {
        return BntAltitude(0);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return BntAltitude(186);
    }else {
        return BntAltitude(60);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kWidth, BntAltitude(38))];
        UILabel * headerLabel = [UILabel configWithFont:Font(kiphoneXfont) TextColor:knineNineColor background:nil title:@"实名认证信息无法修改，请仔细确认后再提交"];
        [headerView addSubview:headerLabel];
        [self.view addSubview:headerView];
        [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(BntLength(20));
            make.top.equalTo(headerView).offset(BntAltitude(15));
            make.height.offset(BntAltitude(13));
        }];
        [headerLabel sizeToFit];
        return headerView;
    }else
        return nil;
}


#pragma mark - 返回结果的回调信息
- (void)configCallback {
    __weak typeof(self) weakSelf = self;
    // 这是默认的识别成功的回调
    _successHandler = ^(id result){
        
        if ([[result objectForKey:@"image_status"] isEqualToString:@"normal"]) {
            if ([weakSelf.isSignImg isEqualToString:@"front"]) {
                [weakSelf.identiFontDic removeAllObjects];
                [weakSelf.identiFontDic setObject: [result objectForKey:@"words_result"] forKey:@"font"];
            }else {
                [weakSelf.identiBehindDic removeAllObjects];
                [weakSelf.identiBehindDic setObject: [result objectForKey:@"words_result"] forKey:@"behind"];
            }
            [weakSelf.baseTableView reloadData];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [weakSelf.coverView removeFromSuperview];
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }];
        }else{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [weakSelf.coverView removeFromSuperview];
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
                if ([weakSelf.isSignImg isEqualToString:@"front"]) {
                    weakSelf.realCell.frontRealImg.image = kImageName(@"frontIdenty");
                    weakSelf.submitFrontImg = nil;
                }else{
                    weakSelf.realCell.behindRealImg.image = kImageName(@"identify");
                    weakSelf.submitBehindImg = nil;
                }
            }];
            [MBProgressHUD bnt_showMessage:@"识别失败" delay:1];
        }
        
    };
    _failHandler = ^(NSError *error){
        
        NSString *msg = [NSString stringWithFormat:@"%li:%@", (long)[error code], [error localizedDescription]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[[UIAlertView alloc] initWithTitle:@"识别失败" message:msg delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            if ([weakSelf.isSignImg isEqualToString:@"front"]) {
                weakSelf.realCell.frontRealImg.image = kImageName(@"frontIdenty");
                weakSelf.submitFrontImg = nil;
            }else{
                weakSelf.realCell.behindRealImg.image = kImageName(@"identify");
                weakSelf.submitBehindImg = nil;
                
            }
        }];
    };
}
#pragma mark - 身份证正面

- (void)idcardOCROnlineFront {
    kWeakSelf(self);
    UIViewController * vc =
    [AipCaptureCardVC ViewControllerWithCardType:CardTypeLocalIdCardFont
                                 andImageHandler:^(UIImage *image) {
                                     weakself.submitFrontImg = image;
                                     weakself.isSignImg = @"front";
                                     self->_realCell.frontRealImg.image = image;
                                     [[AipOcrService shardService] detectIdCardFrontFromImage:image
                                                                                  withOptions:nil
                                                                               successHandler:^(id result){
                                                                                   
                                                                                   self->_successHandler(result);
                                                                                   
                                                                               }
                                                                                  failHandler:self->_failHandler];
                                 }];
    [self presentViewController:vc animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [kWindow addSubview:weakself.coverView];
    });
}


#pragma mark - 身份证反面
- (void)idcardOCROnlineBack{
    kWeakSelf(self);
    UIViewController * vc =
    [AipCaptureCardVC ViewControllerWithCardType:CardTypeLocalIdCardBack
                                 andImageHandler:^(UIImage *image) {
                                     weakself.submitBehindImg = image;
                                     self->_realCell.behindRealImg.image = image;
                                     weakself.isSignImg = @"behind";
                                     [[AipOcrService shardService] detectIdCardBackFromImage:image
                                                                                 withOptions:nil
                                                                              successHandler:^(id result){
                                                                                  self->_successHandler(result);
                                                                                  
                                                                              }
                                                                                 failHandler:self->_failHandler];
                                 }];
    [self presentViewController:vc animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [kWindow addSubview:weakself.coverView];
    });
}

#pragma mark - 上传身份证

- (void)uploadSingleImg:(UIImage *)img signImg:(NSString *)signImg{
    kWeakSelf(self);
    [[NetworkUtils sharedInstance] uploadImgWith:[UIImage scaleImage:img toKb:100] MaxLength:100  utilsSuccess:^(id response) {
        if ([BaseTool responseWithNetworkDealResponse:response]) {
            if (isValidStr(response[@"data"][@"url"])) {
                if ([signImg isEqualToString:@"front"]) {
                    weakself.frontImg = response[@"data"][@"url"];
                }else if ([signImg isEqualToString:@"behind"]) {
                    weakself.behindImg = response[@"data"][@"url"];
                }
            }
            if (isValidStr(self.frontImg) && isValidStr(self.behindImg)) {
                [weakself submitAllRealName];
            }
        }else {
            [MBProgressHUD bnt_showMessage:response[kMessageStr] delay:kMubDelayTime];
        }
    } utilsFail:^(NSString *error) {
    }];
}


#pragma mark - 提交信息

- (void)submitRealNameMessage {
    if ([self.identStatus intValue] == 1) {
        return;
    }else{
        if (self.submitFrontImg) {
            [self uploadSingleImg:self.submitFrontImg signImg:@"front"];
        }else{
            [MBProgressHUD bnt_showMessage:@"请拍摄后提交"  delay:1];
        }
        if (self.submitBehindImg) {
            [self uploadSingleImg:self.submitBehindImg signImg:@"behind"];
        }else{
            [MBProgressHUD bnt_showMessage:@"请拍摄后提交"  delay:1];
        }
    }
}
-(NSString *)strFromDic:(NSDictionary *)dic forKey:(NSString *)key{
    NSString *newstr = [[dic objectForKey:key] objectForKey:@"words"];
    return newstr;
}
- (void)submitAllRealName {
    if (isValidStr(self.frontImg) && isValidStr(self.behindImg) && self.identiBehindDic.count > 0 && self.identiFontDic.count > 0) {
        NSDictionary *behindDic = [self.identiBehindDic objectForKey:@"behind"];
        NSString *firstdata = [self strFromDic:behindDic forKey:@"签发日期"];
        NSString *lastdata = [self strFromDic:behindDic forKey:@"失效日期"];
        NSString * indate = [NSString stringWithFormat:@"%@-%@", firstdata, lastdata];//有效日期
        NSString * ia = [self strFromDic:behindDic forKey:@"签发机关"];//签发机关
        NSDictionary *dic = [self.identiFontDic objectForKey:@"font"];
        NSString * userName = [self strFromDic:dic forKey:@"姓名"];
        NSString * userCerNo = [self strFromDic:dic forKey:@"公民身份号码"];
        NSString * address =  [self strFromDic:dic forKey:@"住址"];
        NSString * nation =  [self strFromDic:dic forKey:@"民族"];
        
        kWeakSelf(self);
        [[NetworkUtils sharedInstance] uplodRealUserNameWith:userName  userCertNo:userCerNo ia:ia indate:indate address:address nation:nation imgCertFront:self.frontImg imgCertBack:self.behindImg utilsSuccess:^(id response) {
            NSLog(@"%@",response[kStatusCode]);
            if ([BaseTool responseWithNetworkDealResponse:response]) {
                [weakself.navigationController popViewControllerAnimated:YES];
            }else {
                [MBProgressHUD bnt_showMessage:response[kMessageStr] delay:kMubDelayTime];
            }
        } utilsFail:^(NSString *error) {
            
        }];
    }else {
        [MBProgressHUD bnt_showMessage:@"请拍摄后提交!" delay:kMubDelayTime];
    }
}

#pragma mark - 获取实名

- (void)rewordRalNameFromNetwork {
    kWeakSelf(self);
    [[NetworkUtils sharedInstance] rewordRealNameutilSuccess:^(id response) {
        if ([BaseTool responseWithNetworkDealResponse:response]) {
            weakself.rewordimgCertFront = response[@"data"][@"imgCertFront"];
            weakself.rewordimgCertBack = response[@"data"][@"imgCertBack"];
            weakself.rewordUserCertNo = response[@"data"][@"userCertNo"];
            weakself.rewordUserName = response[@"data"][@"userName"];
            weakself.identStatus = response[@"data"][@"identStatus"];
            if ([self.identStatus intValue] == 1) {
                self.baseTableView.userInteractionEnabled = NO;
                self.BaseNavgationBar.rightBtn.hidden = YES;
                [weakself.baseTableView reloadData];
            }else{
                self.BaseNavgationBar.rightBtn.hidden = NO;
                weakself.rewordimgCertFront = nil;
                weakself.rewordimgCertBack = nil;
                weakself.rewordUserCertNo = nil;
                weakself.rewordUserName = nil;
                self.baseTableView.userInteractionEnabled = YES;
            }
        }
    } utilsFail:^(NSString *error) {
    }];
}

@end

