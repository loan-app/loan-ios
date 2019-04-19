//
//  BWAreaPickerView.m
//  BorrowMoney
//
//  Created by Single_Nobel on 2017/3/17.
//  Copyright © 2017年 Single_Nobel. All rights reserved.
//

#import "BWAreaPickerView.h"

@interface BWAreaPickerView()<UIPickerViewDelegate, UIPickerViewDataSource>
/** 地址数据 */
@property (nonatomic, strong) NSArray *areaArray;
/** pickView */
@property (nonatomic, strong) UIPickerView *pickView;
/** 顶部视图 */
@property (nonatomic, strong) UIView *topView;
/** 取消按钮 */
@property (nonatomic, strong) UIButton *cancelButton;
/** 确定按钮 */
@property (nonatomic, strong) UIButton *sureButton;
@end

static const CGFloat topViewHeight = 41;
static const CGFloat buttonWidth = 60;
static const CGFloat animationDuration = 0.3;

typedef enum : NSUInteger {
    BLComponentTypeProvince = 0, // 省
    BLComponentTypeCity,         // 市
    BLComponentTypeArea,         // 区
} BLComponentType;

@implementation BWAreaPickerView
{
    NSInteger _provinceSelectedRow;
    NSInteger _citySelectedRow;
    NSInteger _areaSelectedRow;
    
    NSString *_selectedProvinceTitle;
    NSString *_selectedCityTitle;
    NSString *_selectedAreaTitle;
    
    CGRect _pickViewFrame;
}

#pragma mark - - load
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self bl_initData:frame];
        [self bl_initSubviews];
        [self _addTapGestureRecognizerToMySelf];
    }
    return self;
}

/** 初始化子视图 */
- (void)bl_initSubviews{
    [self addSubview:self.topView];
    [self addSubview:self.pickView];
    [self.topView addSubview:self.cancelButton];
    [self.topView addSubview:self.sureButton];
}

/** 初始化数据 */
- (void)bl_initData:(CGRect)frame{
    _pickViewFrame = frame;
    
    self.frame = CGRectMake(0, 0, kWidth, kHeight);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    _provinceSelectedRow = 0;
    _citySelectedRow = 0;
    _areaSelectedRow = 0;
    
    if (_bankArray.count > 0) {
        _areaArray = [NSArray arrayWithArray:_bankArray];
    }else{
        NSString *plistStr = [[NSBundle mainBundle] pathForResource:@"areaArray" ofType:@"plist"];
        _areaArray = [[NSArray alloc] initWithContentsOfFile:plistStr];
    }
    
}

#pragma mark - - get
- (UIPickerView *)pickView{
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), kWidth, _pickViewFrame.size.height)];
        _pickView.dataSource = self;
        _pickView.delegate = self;
        _pickView.backgroundColor = [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1];
        UITapGestureRecognizer *tapNavigationViews = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
        [_pickView addGestureRecognizer:tapNavigationViews];
    }
    return _pickView;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight, kWidth, topViewHeight)];
        _topView.backgroundColor = kyellowColor;
        UITapGestureRecognizer *tapNavigationView = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
        [_topView addGestureRecognizer:tapNavigationView];
    }
    return _topView;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(0, 0, buttonWidth, topViewHeight);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:Font(kFont)];
        [_cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.frame = CGRectMake(self.frame.size.width - buttonWidth, 0, buttonWidth, topViewHeight);
        [_sureButton setTitle:@"完成" forState:UIControlStateNormal];
        [_sureButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_sureButton.titleLabel setFont:Font(kFont)];
        [_sureButton addTarget:self action:@selector(sureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (void)_addTapGestureRecognizerToMySelf {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bl_dismiss)];
    [self addGestureRecognizer:tap];
}


#pragma mark - - set
- (void)setPickViewBackgroundColor:(UIColor *)pickViewBackgroundColor{
    self.pickView.backgroundColor = pickViewBackgroundColor;
}

- (void)setTopViewBackgroundColor:(UIColor *)topViewBackgroundColor{
    self.topView.backgroundColor = topViewBackgroundColor;
}

- (void)setCancelButtonColor:(UIColor *)cancelButtonColor{
    [self.cancelButton setTitleColor:cancelButtonColor forState:UIControlStateNormal];
}

- (void)setSureButtonColor:(UIColor *)sureButtonColor{
    [self.sureButton setTitleColor:sureButtonColor forState:UIControlStateNormal];
}

#pragma mark - show,dismiss

- (void)bl_show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:animationDuration animations:^{
        CGRect tempRect = self->_topView.frame;
        tempRect.origin.y = kHeight - topViewHeight - self->_pickViewFrame.size.height;
        self->_topView.frame = tempRect;
        tempRect = self->_pickViewFrame;
        tempRect.origin.y = CGRectGetMaxY(self->_topView.frame);
        self->_pickView.frame = tempRect;
    }];
}

- (void)bl_dismiss{
    [UIView animateWithDuration:animationDuration animations:^{
        CGRect tempRect = self->_topView.frame;
        tempRect.origin.y = kHeight;
        self->_topView.frame = tempRect;
        tempRect = self->_pickViewFrame;
        tempRect.origin.y = CGRectGetMaxY(self->_topView.frame);
        self->_pickView.frame = tempRect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

#pragma mark - - Button Action
- (void)cancelButtonClicked:(UIButton *)sender{
    
    if (self.pickViewDelegate &&
        [self.pickViewDelegate respondsToSelector:@selector(bl_cancelButtonClicked)]) {
        [self.pickViewDelegate bl_cancelButtonClicked];
    }
    [self bl_dismiss];
}

- (void)sureButtonClicked:(UIButton *)sender{
    
    _selectedProvinceTitle = [self pickerView:_pickView titleForRow:_provinceSelectedRow forComponent:0];
    _selectedCityTitle = [self pickerView:_pickView titleForRow:_citySelectedRow forComponent:1];
    _selectedAreaTitle = [self pickerView:_pickView titleForRow:_areaSelectedRow forComponent:2];
    
    if (self.pickViewDelegate &&
        [self.pickViewDelegate respondsToSelector:@selector(bl_selectedAreaResultWithProvince:city:area:)]) {
        [self.pickViewDelegate bl_selectedAreaResultWithProvince:_selectedProvinceTitle
                                                            city:_selectedCityTitle
                                                            area:_selectedAreaTitle];
    }

    [self bl_dismiss];
}

#pragma mark - - UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case BLComponentTypeProvince:
            if (_bankArray.count > 0) {
                return 0;
            }
            return _areaArray.count;
            break;
        case BLComponentTypeCity:
            if (_bankArray.count > 0) {
                return _bankArray.count;
            }
            return [[[_areaArray objectAtIndex:_provinceSelectedRow] objectForKey:@"citylist" ] count];
            return 0;
            break;
        case BLComponentTypeArea:
            if (_bankArray.count > 0) {
                return 0;
            }
            return [[[[[_areaArray objectAtIndex:_provinceSelectedRow] objectForKey:@"citylist" ] objectAtIndex:_citySelectedRow] objectForKey:@"arealist" ] count];
            break;
        default:
            if (_bankArray.count > 0) {
                return 0;
            }
            return _areaArray.count;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSDictionary *provinceDic = [_areaArray objectAtIndex:_provinceSelectedRow];
    NSArray *cityArr = [provinceDic objectForKey:@"citylist"];
    
    switch (component) {
        case BLComponentTypeProvince:
            if (_bankArray.count > 0) {
                return nil;
            }
            return [_areaArray[row] objectForKey:@"provinceName"];
            break;
        case BLComponentTypeCity:{
            if (_bankArray.count > 0) {
                return _bankArray[row];
            }
            NSDictionary *cityDic = [cityArr objectAtIndex:row];
            return [cityDic objectForKey:@"cityName"];
            break;
        }
        case BLComponentTypeArea:{
            if (_bankArray.count > 0) {
                return nil;
            }
            NSDictionary *areaDic = [cityArr objectAtIndex:_citySelectedRow];
            NSArray *areaArr = [areaDic objectForKey:@"arealist"];
            if (areaArr.count > 0) {
                 return [areaArr[row] objectForKey:@"areaName"];
            }else {
                return nil;
            }
            break;
        }
        default:
            if (_bankArray.count > 0) {
                return  nil;
            }
            return [_areaArray[row] objectForKey:@"provinceName"];
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case BLComponentTypeProvince:{
            _provinceSelectedRow = row;
            _citySelectedRow = 0;
            _areaSelectedRow = 0;
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            break;
        }
        case BLComponentTypeCity:{
            _citySelectedRow = row;
            _areaSelectedRow = 0;
            [pickerView selectRow:0 inComponent:2 animated:NO];
            break;
        }
        case BLComponentTypeArea:
            _areaSelectedRow = row;
            break;
        default:
            _provinceSelectedRow = row;
            break;
    }
    [pickerView reloadAllComponents];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return self.frame.size.width / 3;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    [self changeSpearatorLineColor];
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:kclearColor];
        [pickerLabel setFont:_titleFont ? _titleFont : Font(kFont)];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - 改变分割线的颜色
- (void)changeSpearatorLineColor
{
    for(UIView *speartorView in _pickView.subviews)
    {
        if (speartorView.frame.size.height < 1)//取出分割线view
        {
            speartorView.backgroundColor = [UIColor lightGrayColor];//隐藏分割线
        }
    }
}



@end
