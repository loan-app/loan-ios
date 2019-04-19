//
//  ContactViewController.m
//  BorrowMoney
//
//  Created by Single_Nobel on 2017/4/6.
//  Copyright © 2017年 Single_Nobel. All rights reserved.
//

#import "ContactViewController.h"
#import "PPGetAddressBook.h"
#import "ZYPinYinSearch.h"
#import "PinYinForObjc.h"
#import "contactCell.h"
#import "numModel.h"
#define START NSDate *startTime = [NSDate date]
#define END NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])
@interface ContactViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) NSMutableArray * jsonAry;
@property (nonatomic, assign) BOOL isSearch;
@property (nonatomic, strong) NSMutableArray *searchDataSource;/**<搜索结果数据源*/
@property (nonatomic, strong) NSString *firstLetterString;
@property (nonatomic, strong) NSMutableArray * phoneAry;
@property (nonatomic, strong) NSMutableArray *searchPhoneDataSource;
@property (nonatomic, strong) NSMutableArray * allAry;
@end
static NSString *cellId = @"contactCell";

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupUI];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self configDataWithContact];
}
#pragma mark -

- (void)configDataWithContact {
    [PPGetAddressBook getOrderAddressBook:^(NSDictionary<NSString *,NSArray *> *addressBookDict, NSArray *nameKeys) {
        [self->_indicator stopAnimating];
        //装着所有联系人的字典
        self.contactPeopleDict = addressBookDict;
        //联系人分组按拼音分组的Key值
         self.keys = nameKeys;
        [self dataWithContactDic:addressBookDict keys:self.keys];
        [self.baseTableView reloadData];

    } authorizationFailure:^{

    }];
}


- (void)dataWithContactDic:(NSDictionary *)dic keys:(NSArray *)key {
    for (int i = 0; i < key.count; i++) {
        NSString * keyStr = key[i];
        NSArray * ary = _contactPeopleDict[keyStr];
        for (int j = 0; j < ary.count; j++) {
            PPPersonModel *people = [ary objectAtIndex:j];
            [self.dataAry addObject:people.name];
            if (people.mobileArray.count <= 1) {
                [self.phoneAry addObject:people];
            }
            [self.jsonAry addObject:people.mobileArray];
        }
    }
   NSMutableDictionary * nameDic = [NSMutableDictionary dictionary];
    _allAry = [@[] mutableCopy];
    // 需要判定有联系人没有手机号的情况;
    for (int m = 0; m < self.dataAry.count; m++) {
        [nameDic setObject:self.dataAry[m] forKey:@"n"];
        
        if ([BaseTool isBlankArr:self.jsonAry[m]]) {
            [nameDic setObject:@"p" forKey:@"p"];
        }else{
            [nameDic setObject:[self.jsonAry[m] objectAtIndex:0] forKey:@"p"];
        }
       NSString *jsonStr = [BaseTool convertToJsonData:nameDic];
        [_allAry addObject:jsonStr];
    }
    if (_AryBlock) {
        _AryBlock([BaseTool objArrayToJSON:_allAry]);
    }
}



#pragma mark - setupNav

- (void)setupNav {
    self.BaseNavgationBar.title = @"通讯录";
}

#pragma mark - setupUI
- (void)setupUI {
    [self.view addSubview:self.baseTableView];

    [self.view addSubview:self.indicator];
    _searchDataSource = [NSMutableArray new];
}

#pragma mark - 懒加载

- (UITableView *)baseTableView {
    if (!_baseTableView) {
        _baseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kWidth, kHeight - kNavBarHeight) style:UITableViewStylePlain];
        [_baseTableView registerClass:[contactCell class] forCellReuseIdentifier:cellId];
        _baseTableView.delegate = self;
        _baseTableView.dataSource = self;
        _baseTableView.backgroundColor = kWhiteColor;
        _baseTableView.tableHeaderView = self.searchBar;
        _baseTableView.tableFooterView = [[UIView alloc] init];
        //设置分割线样式顶左
        if ([self.baseTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.baseTableView setSeparatorInset:UIEdgeInsetsZero];
            
        }
        if ([self.baseTableView respondsToSelector:@selector(setLayoutMargins:)])  {
            [self.baseTableView setLayoutMargins:UIEdgeInsetsZero];
        }
        _baseTableView.showsVerticalScrollIndicator = NO;
    }
    return _baseTableView;
}

- (NSMutableArray *)dataAry {
    if (!_dataAry) {
        _dataAry = [@[] mutableCopy];
    }
    return _dataAry;
}

- (NSMutableArray *)searchPhoneDataSource {
    if (!_searchPhoneDataSource) {
        _searchPhoneDataSource = [@[] mutableCopy];
    }
    return _searchPhoneDataSource;
}

- (NSMutableArray *)jsonAry {
    if (!_jsonAry) {
        _jsonAry = [@[] mutableCopy];
    }
    return _jsonAry;
}

- (NSMutableArray *)allAry {
    if (!_allAry) {
        _allAry = [@[] mutableCopy];
    }
    return _allAry;
}

- (NSMutableArray *)phoneAry {
    if (!_phoneAry) {
        _phoneAry = [@[] mutableCopy];
    }
    return _phoneAry;
}


- (UISearchBar *)searchBar {
    if (!_searchBar) {
        
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, kNavBarHeight , kWidth, 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        _searchBar.showsCancelButton = NO;
    }
    return _searchBar;
}


- (UIActivityIndicatorView *)indicator {
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicator.frame = CGRectMake(0, 0, 80, 80);
        _indicator.center = CGPointMake(kWidth*0.5, kWidth*0.5 - 80);
        _indicator.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
        _indicator.clipsToBounds = YES;
        _indicator.layer.cornerRadius = 6;
        [_indicator startAnimating];
    }
    return _indicator;
}



#pragma mark - TableViewDatasouce/TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!_isSearch) {
        return _keys.count;
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        if (!_isSearch) {
            if (_keys >0) {
                NSString *key = _keys[section];
                return [_contactPeopleDict[key] count];
            }else{
                return _searchDataSource.count;

            }

        }else {
            return _searchDataSource.count;
        }
 

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] init];
    if (!_isSearch) {
        UILabel * label = [UILabel configWithFont:Font(kFont) TextColor:kfour8Color background:nil title:_keys[section]];
        label.frame = CGRectMake(16, 2, kWidth - 52, 17);
        view.backgroundColor = kTableViewColor;
        [view addSubview:label];
        return view;
    }else {
        UILabel * label = [UILabel configWithFont:Font(kFont) TextColor:kfour8Color background:nil title:_firstLetterString];
        label.frame = CGRectMake(16, 2, kWidth - 52, 17);
        view.backgroundColor = kTableViewColor;
        [view addSubview:label];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 23;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

//右侧的索引
- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (!_isSearch) {
        return _keys;
    }else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cell";
    
    contactCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[contactCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    NSString *key = _keys[indexPath.section];
    if (!_isSearch) {
        PPPersonModel *people = [_contactPeopleDict[key] objectAtIndex:indexPath.row];
        cell.titleLab.text = people.name;
    }else{
        
        cell.numObj = _searchDataSource[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isSearch) {
        NSString *key = _keys[indexPath.section];
        PPPersonModel *people = [_contactPeopleDict[key] objectAtIndex:indexPath.row];
        if (_bookBlock) {
            _bookBlock(people.name, people.mobileArray);
        }
    }else{

        numModel *numObj =  _searchDataSource[indexPath.row];
        NSString *phonestr = [NSString stringWithFormat:@"%@",numObj.p];
        if (![phonestr isEqualToString:@"p"]) {
            if (_bookBlock) {
                NSMutableArray *muArr = [NSMutableArray arrayWithObject:numObj.p];
                    _bookBlock(numObj.n,muArr);
            }
        }else{
            [MBProgressHUD bnt_showMessage:@"该联系人暂无存储手机号" delay:kMubDelayTime];
        }
    }
   
    [self.navigationController popViewControllerAnimated:YES];
}

//头部索引标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!_isSearch) {
        return _keys[section];
    }else {
        return _firstLetterString;
    }
}

//索引点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
}
- (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}
-(NSMutableArray *)arrFromJsonStr{
    NSMutableArray *marr = [NSMutableArray array];
    for (NSString *jsonStr in _allAry) {
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        numModel *numObj = [numModel yy_modelWithJSON:dic];
        [marr addObject:numObj];
    }
    return marr;
}
-(NSMutableArray *)arrFromJsonDic:(NSArray *)arr{
    NSMutableArray *marr =[NSMutableArray array];
    for (NSString *jsonStr in arr) {
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        numModel *numObj = [numModel yy_modelWithJSON:dic];
        [marr addObject:numObj];
    }
    
    return marr;
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [_searchDataSource removeAllObjects];
    if ([self isNum:searchText]) {
        _firstLetterString = [PPGetAddressBook getFirstLetterFromString:searchText];
        NSMutableArray *marr = [NSMutableArray array];
        for (numModel *numObj in [self arrFromJsonStr]) {
            if ([numObj.p containsString:searchText]) {
                [marr addObject:numObj];
            }
        }
        
        if (searchText.length == 0) {
            _isSearch = NO;
            [_searchDataSource addObjectsFromArray:self.dataAry];
        }else {
            _isSearch = YES;
            [_searchDataSource addObjectsFromArray:marr];
        }
        [self.baseTableView reloadData];
       
    }else{
        _firstLetterString = [PPGetAddressBook getFirstLetterFromString:searchText];
  
    NSArray *aryName = [NSArray new];
    aryName = [ZYPinYinSearch searchWithOriginalArray:self.dataAry andSearchText:searchText andSearchByPropertyName:@"n"];
        
    _searchPhoneDataSource = [[ZYPinYinSearch searchWithOriginalArray:_allAry andSearchText:searchText andSearchByPropertyName:@"p"] mutableCopy];
        NSMutableArray *arr = [self arrFromJsonDic:_searchPhoneDataSource];
    
    if (searchText.length == 0) {
        _isSearch = NO;
        [_searchDataSource addObjectsFromArray:self.dataAry];
    }else {
        _isSearch = YES;
        [_searchDataSource addObjectsFromArray:arr];
    }
    [self.baseTableView reloadData];
      }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [UIView animateWithDuration:0.3 animations:^{
        self->_searchBar.showsCancelButton = YES;
    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _searchBar.frame = CGRectMake(0, 0, kWidth, 44);
    _searchBar.showsCancelButton = NO;
    [_searchBar resignFirstResponder];
    _searchBar.text = @"";
    _isSearch = NO;
    [_baseTableView reloadData];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
