//
//  KelePersonViewController.m
//  RabbitConyYok
//
//  Created by SingleNobel on 2018/6/6.
//  Copyright © 2018年 SingleNobel. All rights reserved.
//

#import "KelePersonViewController.h"
#import "AddressTextFieldTableCell.h"
#import "PersonMessageTableCell.h"
#import "UrgencyTableViewCell.h"
#import "UrgenContactTableCell.h"
#import "WorkTableViewCell.h"
#import "BWAreaPickerView.h"
#import "ContactViewController.h"//通讯录
#import "PPGetAddressBook.h"
#import "FooterBankView.h"
static NSString * kPersonMessageTableCell = @"kPersonMessageTableCell";
static NSString * kPersonAreaTableCell = @"kPersonMessageTableCell";
static NSString * kPersonAreaTimeTableCell = @"kPersonMessageTableCell";
static NSString * kPersonMarrayStatusTableCell = @"kPersonMessageTableCell";
static NSString * kPersonJobTableCell = @"kPersonJobTableCell";
static NSString * kAddressTableCell = @"kAddressTableCell";
static NSString * kworkTableCell = @"kworkTableCell";
static NSString * kcompanyTableCell = @"kcompanyTableCell";

static NSString * kurgencyContactZhixiCell = @"kurgencyContactZhixiCell";
static NSString * kUrgencyZhixiTaCell = @"kUrgencyQiTaCell";

static NSString * kurgencyContactQitaCell = @"kurgencyContactTableCell";
static NSString * kUrgencyQitaCell = @"kUrgencyTableCell";

@interface KelePersonViewController ()<BLPickerViewDelegate,UITableViewDelegate,UITableViewDataSource,BaseNavDelegate>
@property (nonatomic, strong) FooterBankView * footBankView;
/** 选择piker数据源
 */
@property (nonatomic, strong) NSArray * educationAry;
@property (nonatomic, strong) NSArray * marryStatusAry;
@property (nonatomic, strong) NSArray * liveTimeAry;
@property (nonatomic, strong) NSArray * workAry;
//标识
@property (nonatomic, assign) BOOL isTheEducation;//学历
@property (nonatomic, assign) BOOL isTheAdress;//居住地
@property (nonatomic, assign) BOOL isTheMarray;//婚姻
@property (nonatomic, assign) BOOL isTheJob;//职业
@property (nonatomic, assign) BOOL isTheTime;//居住时间
@property (nonatomic, assign) BOOL isTheBrother;//居住时间
@property (nonatomic, assign) BOOL isTheOther;//居住时间
//提交按钮参数
@property (nonatomic, strong) NSString * educationStr;

@property (nonatomic, strong) NSString * liveProvince;
@property (nonatomic, strong) NSString * liveCity;
@property (nonatomic, strong) NSString * liveDistrict;

@property (nonatomic, strong) NSString * marryStatus;
@property (nonatomic, strong) NSString * liveTime;
@property (nonatomic, strong) NSString * work;//职业

@property (nonatomic, strong) NSString * zhixi;//关系
@property (nonatomic, strong) NSNumber * zhixiPhone;
@property (nonatomic, strong) NSString * zhixiName;//名字
@property (nonatomic, strong) NSString * others;
@property (nonatomic, strong) NSString * othersName;
@property (nonatomic, strong) NSNumber * otherPhone;
/** cell上的值
 */
@property (nonatomic, strong) PersonMessageTableCell * studyCell;
@property (nonatomic, strong) PersonMessageTableCell * areaCell;
@property (nonatomic, strong) AddressTextFieldTableCell * addressCell;
@property (nonatomic, strong) PersonMessageTableCell * timeCell;
@property (nonatomic, strong) PersonMessageTableCell * marryCell;
@property (nonatomic, strong) PersonMessageTableCell * jobCell;
@property (nonatomic, strong) WorkTableViewCell * workCell;
@property (nonatomic, strong) WorkTableViewCell * companyCell;
@property (nonatomic, strong) UrgenContactTableCell * urgencyContactZhiXiCell;
@property (nonatomic, strong) UrgencyTableViewCell * urgencyZhixiCell;
@property (nonatomic, strong) UrgenContactTableCell * urgencyContactQiTaCell;
@property (nonatomic, strong) UrgencyTableViewCell * urgencyQitaCell;

@property(strong,nonatomic)UITableView *baseTableView;
@end

@implementation KelePersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self addAllSubViews];
    //获取个人信息
    [self searchIdThroughPersonInfo];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
#pragma mark - setupNav
- (void)setupNav {
    self.BaseNavgationBar.title = @"个人信息";
    self.BaseNavgationBar.Rbtntitle = @"提交";
    self.BaseNavgationBar.rightBtn.hidden = NO;
    self.BaseNavgationBar.delegate = self;
    [self.view addSubview:self.baseTableView];
}
-(void)clickWithRightBtn:(UIButton *)sender{
    [self submitWithPersonMessage];
}
-(UITableView *)baseTableView{
    if (!_baseTableView) {
        _baseTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWidth, kHeight-kNavBarHeight) style:UITableViewStyleGrouped];
        _baseTableView.delegate =self;
        _baseTableView.dataSource = self;
        _baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _baseTableView;
}

#pragma mark - addSubviews

- (void)addAllSubViews {
    [self.baseTableView registerClass:[PersonMessageTableCell class] forCellReuseIdentifier:kPersonMessageTableCell];
    [self.baseTableView registerClass:[PersonMessageTableCell class] forCellReuseIdentifier:kPersonAreaTableCell];
    [self.baseTableView registerClass:[AddressTextFieldTableCell class] forCellReuseIdentifier:kAddressTableCell];
    [self.baseTableView registerClass:[PersonMessageTableCell class] forCellReuseIdentifier:kPersonAreaTimeTableCell];
    [self.baseTableView registerClass:[PersonMessageTableCell class] forCellReuseIdentifier:kPersonMarrayStatusTableCell];
    [self.baseTableView registerClass:[PersonMessageTableCell class] forCellReuseIdentifier:kPersonJobTableCell];
    [self.baseTableView registerClass:[WorkTableViewCell class] forCellReuseIdentifier:kworkTableCell];
    [self.baseTableView registerClass:[WorkTableViewCell class] forCellReuseIdentifier:kcompanyTableCell];
    [self.baseTableView registerClass:[UrgencyTableViewCell class] forCellReuseIdentifier:kUrgencyZhixiTaCell];
    [self.baseTableView registerClass:[UrgenContactTableCell class] forCellReuseIdentifier:kurgencyContactZhixiCell];
    [self.baseTableView registerClass:[UrgencyTableViewCell class] forCellReuseIdentifier:kUrgencyQitaCell];
    [self.baseTableView registerClass:[UrgenContactTableCell class] forCellReuseIdentifier:kurgencyContactQitaCell];
    self.baseTableView.backgroundColor = kTableViewColor;
    self.baseTableView.tableFooterView = self.footBankView;
}

- (FooterBankView *)footBankView {
    if (!_footBankView) {
        _footBankView = [[FooterBankView alloc] initWithFrame:CGRectMake(0, 0, kWidth, BntAltitude(101))];
    }
    return _footBankView;
}

- (NSArray *)educationAry {
    if (!_educationAry) {
        _educationAry = @[@"博士", @"硕士", @"本科", @"大专", @"中专", @"高中", @"初中", @"初中以下"];
    }
    return _educationAry;
}

- (NSArray *)liveTimeAry {
    if (!_liveTimeAry) {
        _liveTimeAry = @[@"半年以内", @"半年到一年", @"一年以上"];
    }
    return _liveTimeAry;
}

- (NSArray *)marryStatusAry {
    if (!_marryStatusAry) {
        _marryStatusAry = @[@"未婚", @"已婚未育", @"已婚已育", @"离异"];
    }
    return _marryStatusAry;
}

- (NSArray *)workAry {
    if (!_workAry) {
        _workAry = @[@"上班族", @"自由职业", @"学生"];
    }
    return _workAry;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 8; //填写信息
    }else {
        return 2; //紧急联系人
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.section == 0 && indexPath.row == 0) {
            _studyCell = [tableView dequeueReusableCellWithIdentifier:kPersonMessageTableCell forIndexPath:indexPath];
            if (_studyCell == nil) {
                _studyCell = [[PersonMessageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kPersonMessageTableCell];
            }
            if (isValidStr(self.educationStr)) {
                _studyCell.resultLabel.text = self.educationStr;
            }
            _studyCell.leftPersonLabel.text = @"学历";
            return _studyCell;
        }else
        if (indexPath.section == 0 && indexPath.row == 1) {
            _areaCell = [tableView dequeueReusableCellWithIdentifier:kPersonAreaTableCell forIndexPath:indexPath];
            if (_areaCell == nil) {
                _areaCell = [[PersonMessageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kPersonAreaTableCell];
            }
            if (isValidStr(self.liveProvince)) {
                _areaCell.resultLabel.text = [NSString stringWithFormat:@"%@ %@ %@", self.liveProvince, self.liveCity, self.liveDistrict];
            }
            _areaCell.leftPersonLabel.text = @"现居地址";
            return _areaCell;
        }else
        if (indexPath.section == 0 && indexPath.row == 2){
            _addressCell = [tableView dequeueReusableCellWithIdentifier:kAddressTableCell forIndexPath:indexPath];
            if (_addressCell == nil) {
                _addressCell = [[AddressTextFieldTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kAddressTableCell];
            }
            return _addressCell;
        }else
        if (indexPath.section == 0 && indexPath.row == 3){
            _timeCell = [tableView dequeueReusableCellWithIdentifier:kPersonAreaTimeTableCell forIndexPath:indexPath];
            if (_timeCell == nil) {
                _timeCell = [[PersonMessageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kPersonAreaTimeTableCell];
            }
            if (isValidStr(self.liveTime)) {
                _timeCell.resultLabel.text = self.liveTime;
            }
            _timeCell.leftPersonLabel.text = @"居住时长";
            return _timeCell;
        }else
        if (indexPath.section == 0 && indexPath.row == 4){
            _marryCell = [tableView dequeueReusableCellWithIdentifier:kPersonMarrayStatusTableCell forIndexPath:indexPath];
            if (_marryCell == nil) {
                _marryCell = [[PersonMessageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kPersonMarrayStatusTableCell];
            }
            if (isValidStr(self.marryStatus)) {
                _marryCell.resultLabel.text = self.marryStatus;
            }
            _marryCell.leftPersonLabel.text = @"婚姻状态";
            return _marryCell;
        }else
        if (indexPath.section == 0 && indexPath.row == 5){
            _jobCell = [tableView dequeueReusableCellWithIdentifier:kPersonJobTableCell forIndexPath:indexPath];
            if (_jobCell == nil) {
                _jobCell = [[PersonMessageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kPersonJobTableCell];
            }
            if (isValidStr(self.work)) {
                _jobCell.resultLabel.text = self.work;
            }
            _jobCell.leftPersonLabel.text = @"职业";
            return _jobCell;
        }else
        if (indexPath.section == 0 && indexPath.row == 6) {
            _companyCell  = [tableView dequeueReusableCellWithIdentifier:kcompanyTableCell forIndexPath:indexPath];
            if (_companyCell == nil) {
                _companyCell = [[WorkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcompanyTableCell];
            }
            _companyCell.leftWorkabel.text = @"工作单位";
            _companyCell.rightWorkFiled.placeholder = @"请输入工作单位";
            return _companyCell;
        }else if (indexPath.section == 0 && indexPath.row == 7) {
            _workCell  = [tableView dequeueReusableCellWithIdentifier:kworkTableCell forIndexPath:indexPath];
            if (_workCell == nil) {
                _workCell = [[WorkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kworkTableCell];
            }
            _workCell.leftWorkabel.text = @"公司地址";
            _workCell.rightWorkFiled.placeholder = @"请输入公司地址";
            return _workCell;
            }else if (indexPath.section == 1 && indexPath.row == 0) {
        _urgencyZhixiCell = [tableView dequeueReusableCellWithIdentifier:kUrgencyZhixiTaCell forIndexPath:indexPath];
        if (_urgencyZhixiCell == nil) {
            _urgencyZhixiCell = [[UrgencyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kUrgencyZhixiTaCell];
        }
        if (self.zhixi) {
          _urgencyZhixiCell.selectLabel.hidden = YES;
           _urgencyZhixiCell.resultLabel.text = self.zhixi;
          }
        return _urgencyZhixiCell;
    }else if (indexPath.section == 1 && indexPath.row == 1){
        _urgencyContactZhiXiCell = [tableView dequeueReusableCellWithIdentifier:kurgencyContactZhixiCell forIndexPath:indexPath];
        if (_urgencyContactZhiXiCell == nil) {
            _urgencyContactZhiXiCell = [[UrgenContactTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kurgencyContactZhixiCell];
        }
        if (self.zhixiName) {
            _urgencyContactZhiXiCell.personLabel.text = self.zhixiName;
        }
        return _urgencyContactZhiXiCell;
        
    }else if (indexPath.section == 2 && indexPath.row == 0){
        _urgencyQitaCell = [tableView dequeueReusableCellWithIdentifier:kUrgencyQitaCell forIndexPath:indexPath];
        if (_urgencyQitaCell == nil) {
            _urgencyQitaCell = [[UrgencyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kUrgencyQitaCell];
        }
        if (self.others) {
            _urgencyQitaCell.selectLabel.hidden = YES;
            _urgencyQitaCell.resultLabel.text = self.others;
        }
        return _urgencyQitaCell;
    }else {
        _urgencyContactQiTaCell = [tableView dequeueReusableCellWithIdentifier:kurgencyContactQitaCell forIndexPath:indexPath];
        if (_urgencyContactQiTaCell == nil) {
            _urgencyContactQiTaCell = [[UrgenContactTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kurgencyContactQitaCell];
        }
        if (self.othersName) {
            _urgencyContactQiTaCell.personLabel.text = self.othersName;
        }
        return _urgencyContactQiTaCell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BntAltitude(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 38)];
    UILabel * lable = [UILabel configWithFont:Font(12) TextColor:knineNineColor background:kTableViewColor title:@""];
    [view addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).mas_offset(BntLength(16));
        make.top.mas_equalTo(0);
        make.height.mas_offset(BntAltitude(20));
    }];
    [lable sizeToFit];
    if (section == 0) {
        lable.text = @"* 如实填写有助借款通过";
        return view;
    }else if (section == 1) {
        lable.text = @"* 直系亲属联系人";
        return view;
    }else{
        lable.text = @"* 其他联系人";
        return view;
    }
}


//区头跟随移动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        BWAreaPickerView * bwAreaView = [[BWAreaPickerView alloc] initWithFrame:CGRectMake(0, kHeight - BntAltitude(240), kWidth, BntAltitude(240))];
        bwAreaView.pickViewDelegate = self;
        if (indexPath.row == 0) {
            bwAreaView.bankArray = self.educationAry;
            _isTheEducation = YES;
            _isTheAdress = NO;
            _isTheMarray = NO;
            _isTheJob = NO;
            _isTheTime = NO;
            _isTheBrother = NO;
            _isTheOther = NO;
            [bwAreaView bl_show];
        }
        if (indexPath.row == 1) {
            _isTheAdress = YES;
            _isTheEducation = NO;
            _isTheMarray = NO;
            _isTheJob = NO;
            _isTheTime = NO;
            _isTheBrother = NO;
            _isTheOther = NO;
            [bwAreaView bl_show];
        }
        if (indexPath.row == 3) {
            bwAreaView.bankArray = self.liveTimeAry;
            _isTheTime = YES;
            _isTheAdress = NO;
            _isTheMarray = NO;
            _isTheJob = NO;
            _isTheEducation = NO;
            _isTheBrother = NO;
            _isTheOther = NO;
            [bwAreaView bl_show];
        }
        if (indexPath.row == 4) {
            bwAreaView.bankArray = self.marryStatusAry;
            _isTheMarray = YES;
            _isTheAdress = NO;
            _isTheTime = NO;
            _isTheJob = NO;
            _isTheEducation = NO;
            _isTheBrother = NO;
            _isTheOther = NO;
            [bwAreaView bl_show];
        }
        if (indexPath.row == 5) {
            bwAreaView.bankArray = self.workAry;
            _isTheJob = YES;
            _isTheAdress = NO;
            _isTheTime = NO;
            _isTheMarray = NO;
            _isTheEducation = NO;
            _isTheBrother = NO;
            _isTheOther = NO;
            [bwAreaView bl_show];
        }
    }
    BWAreaPickerView * bwView = [[BWAreaPickerView alloc] initWithFrame:CGRectMake(0, kHeight - BntAltitude(200), kWidth, BntAltitude(200))];
    bwView.pickViewDelegate = self;
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            bwView.bankArray = @[@"父亲", @"母亲", @"兄弟", @"姐妹", @"儿子", @"女儿", @"配偶"];
            _isTheEducation = NO;
            _isTheAdress = NO;
            _isTheMarray = NO;
            _isTheJob = NO;
            _isTheTime = NO;
            _isTheBrother = YES;
            _isTheOther = NO;
            [bwView bl_show];
        }else {
            [self contactSelectWith:1];
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            bwView.bankArray = @[@"同学", @"同事", @"亲戚", @"朋友", @"其他"];
            _isTheEducation = NO;
            _isTheAdress = NO;
            _isTheMarray = NO;
            _isTheJob = NO;
            _isTheTime = NO;
            _isTheBrother = NO;
            _isTheOther = YES;
            [bwView bl_show];
        }else {
             [self contactSelectWith:2];
        }
    }
}


#pragma mark - 现居地址

- (void)bl_selectedAreaResultWithProvince:(NSString *)provinceTitle city:(NSString *)cityTitle area:(NSString *)areaTitle {
    if (_isTheEducation) {
        //学历
       _studyCell.resultLabel.text = cityTitle;
        self.educationStr = cityTitle;
    }
    if (_isTheAdress) { //居住地
        if (isValidStr(areaTitle)) {
            _areaCell.resultLabel.text = [NSString stringWithFormat:@"%@ %@ %@", provinceTitle, cityTitle, areaTitle];
            self.liveDistrict = areaTitle;
        }else {
            _areaCell.resultLabel.text = [NSString stringWithFormat:@"%@ %@", provinceTitle, cityTitle];
            self.liveDistrict = @"";
        }
        self.liveProvince = provinceTitle;
        self.liveCity = cityTitle;
    }
    if (_isTheTime) { //居住时长
        _timeCell.resultLabel.text = [NSString stringWithFormat:@"%@", cityTitle];
        self.liveTime = cityTitle;
    }
    if (_isTheMarray) { //婚姻状况
        _marryCell.resultLabel.text = [NSString stringWithFormat:@"%@", cityTitle];
        self.marryStatus = cityTitle;
    }
    if (_isTheJob) { //职业
        _jobCell.resultLabel.text = [NSString stringWithFormat:@"%@", cityTitle];
        self.work = cityTitle;
    }
    if (_isTheBrother) { //紧急联系人
        _urgencyZhixiCell.selectLabel.hidden = YES;
        _urgencyZhixiCell.resultLabel.text = [NSString stringWithFormat:@"%@", cityTitle];
        self.zhixi = cityTitle;
    }
    if (_isTheOther) { // 其他联系人
        _urgencyQitaCell.selectLabel.hidden = YES;
        _urgencyQitaCell.resultLabel.text = [NSString stringWithFormat:@"%@", cityTitle];
        self.others = cityTitle;
    }
}

#pragma mark - 通讯录选择

- (void)contactSelectWith:(NSInteger)index {
    //请求用户获取通讯录权限
    [PPGetAddressBook requestAddressBookAuthorization];

    ContactViewController * addressBookVC = [[ContactViewController alloc] init];
    [self addressBookAction:addressBookVC section:index];
    kWeakSelf(self);
    addressBookVC.AryBlock = ^(NSString * dataStr) {
        if (isValidStr(dataStr)) {
            //上传所有联系人
            [weakself upDataAllContactWithContactAry:dataStr];
        }
    };
    [weakself.navigationController pushViewController:addressBookVC animated:YES];
    [[PPAddressBookHandle sharedAddressBookHandle] requestAuthorizationWithSuccessBlock:^{
        [addressBookVC configDataWithContact];
    } fail:^{
        [weakself tiShiAlert];
    }];
    
}

#pragma mark - 上传通讯录

- (void)upDataAllContactWithContactAry:(NSString *)str {
    [[NetworkUtils sharedInstance] updataTheAllContact:str utilsSuccess:^(id response) {
        if ([BaseTool responseWithNetworkDealResponse:response]) {
        }
    } utilsFail:^(NSString *error) {
        
    }];
}


#pragma mark - 处理通讯录信息

- (void)addressBookAction:(ContactViewController *)addressVC section:(NSInteger)index {
    addressVC.bookBlock = ^(NSString * nameStr, NSMutableArray * phoneStr){
        if (index == 1) {
            self->_urgencyContactZhiXiCell.personLabel.text = nameStr;
            self.zhixiName = nameStr;
            if (phoneStr.count != 0) {
                self->_zhixiPhone = [phoneStr objectAtIndex:0];
            }else {
                self->_zhixiPhone = nil;
            }
        }else {
            self->_urgencyContactQiTaCell.personLabel.text = nameStr;
            self.othersName = nameStr;
            if (phoneStr.count != 0) {
                self->_otherPhone = [phoneStr objectAtIndex:0];
            }else {
                self->_otherPhone = nil;
            }
        }
    };
    
}
- (void)tiShiAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在iPhone的“设置-隐私-通讯录”选项中，允许访问您的通讯录" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 提交个人信息

- (void)submitWithPersonMessage {
    if (isValidStr(self.educationStr) && isValidStr(self.liveProvince) && isValidStr(self.liveCity) && isValidStr(self.addressCell.addressTestField.text) && isValidStr(self.marryStatus) && isValidStr(self.liveTime) && isValidStr(self.work) && isValidStr(_workCell.rightWorkFiled.text) && isValidStr(_companyCell.rightWorkFiled.text) && isValidStr(self.zhixi) && isValidStr(_zhixiName) && isValidStr(self.others) && isValidStr(_othersName)) {
        if (_otherPhone == nil || _zhixiPhone == nil) {
            [MBProgressHUD bnt_showMessage:@"直系联系人或其他联系人号码不能为空!" delay:kMubDelayTime];
        }else{
            [self thePersonWithNetWorkHelper:self.educationStr marray:self.marryStatus liveTime:self.liveTime job:self.work];
        }
    }else {
        [MBProgressHUD bnt_showMessage:@"请先完善您的信息!" delay:kMubDelayTime];
    }
}
- (void)thePersonWithNetWorkHelper:(NSString *)education
                            marray:(NSString *)marry
                          liveTime:(NSString *)liveTime
                              job:(NSString *)job{
    kWeakSelf(self);
    [MBProgressHUD bnt_indeterminateWithMessage:@"" toView:self.view];
    [[NetworkUtils sharedInstance] thePersonWithUrgencyEducation:education liveProvince:self.liveProvince liveCity:self.liveCity liveDistrict:self.liveDistrict liveAddress:self.addressCell.addressTestField.text marryStatus:marry liveTime:liveTime job:job workAddress:self.workCell.rightWorkFiled.text company:self.companyCell.rightWorkFiled.text zhixi:self.zhixi zhixiName:self.zhixiName zhixiTel:self.zhixiPhone others:self.others othersName:self.othersName othersTel:self.otherPhone utilsSuccess:^(id response) {
        [MBProgressHUD hideHUDView:weakself.view];
        if ([BaseTool responseWithNetworkDealResponse:response]) {
            [MBProgressHUD bnt_showMessage:@"提交成功" delay:kMubDelayTime];
            [weakself.navigationController popViewControllerAnimated:YES];
        }else {
            [MBProgressHUD bnt_showMessage:response[kMessageStr] delay:kMubDelayTime];
        }
    } utilsFail:^(NSString *error) {
        
    }];
}

#pragma mark - 根据id检索个人信息

- (void)searchIdThroughPersonInfo {
    kWeakSelf(self);
    [[NetworkUtils sharedInstance] getPersonalRealInfoWithUtilsSuccess:^(id response) {
        if ([BaseTool responseWithNetworkDealResponse:response]) {
            [weakself assignmentWithIDResponse:response];
        }else {
            [MBProgressHUD bnt_showMessage:response[kMessageStr] delay:kMubDelayTime];
        }
    } utilsFail:^(NSString *error) {
        
    }];
}
   
- (void)assignmentWithIDResponse:(id)response {
    if (isValidStr(response[@"data"][@"education"])) {
        self.educationStr = response[@"data"][@"education"];
    }
    if (isValidStr(response[@"data"][@"liveProvince"])) {
        self.liveProvince = response[@"data"][@"liveProvince"];
    }
    if (isValidStr(response[@"data"][@"liveDistrict"])) {
        self.liveDistrict = response[@"data"][@"liveDistrict"];
    }
    if (isValidStr(response[@"data"][@"liveCity"])) {
        self.liveCity = response[@"data"][@"liveCity"];
    }
    _addressCell.addressTestField.text = response[@"data"][@"liveAddress"];
    if (isValidStr(response[@"data"][@"liveTime"])) {
        self.liveTime = response[@"data"][@"liveTime"];
    }
    if (isValidStr(response[@"data"][@"liveMarry"])) {
        self.marryStatus = response[@"data"][@"liveMarry"];
    }
    if (isValidStr(response[@"data"][@"workType"])) {
        self.work = response[@"data"][@"workType"];//职业
    }
    if (isValidStr(response[@"data"][@"workAddress"])) {
        _workCell.rightWorkFiled.text = response[@"data"][@"workAddress"];//工作单位
    }
    if (isValidStr(response[@"data"][@"workCompany"])) {
        _companyCell.rightWorkFiled.text = response[@"data"][@"workCompany"];//公司名称
    }
    if (isValidStr(response[@"data"][@"directContact"])) {
        self.zhixi = response[@"data"][@"directContact"];
    }
    if (isValidStr(response[@"data"][@"directContactName"])) {
        self.zhixiName = response[@"data"][@"directContactName"];
    }
    if (isValidStr(response[@"data"][@"directContactPhone"])) {
        self.zhixiPhone = response[@"data"][@"directContactPhone"];
    }
    if (isValidStr(response[@"data"][@"othersContact"])) {
        self.others = response[@"data"][@"othersContact"];
    }
    if (isValidStr(response[@"data"][@"othersContactName"])) {
        self.othersName = response[@"data"][@"othersContactName"];
    }
    if (isValidStr(response[@"data"][@"othersContactPhone"])) {
        self.otherPhone = response[@"data"][@"othersContactPhone"];
    }
    [self.baseTableView reloadData];
}




@end
