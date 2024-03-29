//
//  BWAreaPickerView.h
//  BorrowMoney
//
//  Created by Single_Nobel on 2017/3/17.
//  Copyright © 2017年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BWAreaPickerView;
@protocol BLPickerViewDelegate <NSObject>

@optional
// 确定按钮点击回调
- (void)bl_selectedAreaResultWithProvince:(NSString *)provinceTitle
                                     city:(NSString *)cityTitle
                                     area:(NSString *)areaTitle;
// 取消按钮点击回调
- (void)bl_cancelButtonClicked;
@end

@interface BWAreaPickerView : UIView
/** 标题大小 */
@property (nonatomic, strong)UIFont  *titleFont;
/** 选择器背景颜色 */
@property (nonatomic, strong)UIColor *pickViewBackgroundColor;
/** 选择器头部视图颜色 */
@property (nonatomic, strong)UIColor *topViewBackgroundColor;
/** 取消按钮颜色 */
@property (nonatomic, strong)UIColor *cancelButtonColor;
/** 确定按钮颜色 */
@property (nonatomic, strong)UIColor *sureButtonColor;

/** 选择器代理 */
@property (nonatomic, weak) id<BLPickerViewDelegate> pickViewDelegate;

@property (nonatomic, copy) NSArray * bankArray;

@property (nonatomic, assign) NSInteger bwIndex;

/** 显示选择器 */
- (void)bl_show;

- (void)bl_dismiss;

@end
