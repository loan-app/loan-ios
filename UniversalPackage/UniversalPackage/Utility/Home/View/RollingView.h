//
//  RollingView.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/1/17.
//Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CDDRollingDelegate<NSObject>

- (void)dc_RollingViewSelectWithActionAtIndex:(NSInteger)index;

@end


@interface RollingView : UIView


/** 点击代理 */
@property (nonatomic , assign) id<CDDRollingDelegate>delegate;
/** 更多点击回调 */
@property (nonatomic, copy) dispatch_block_t moreClickBlock;

/* 图片 */
@property (strong , nonatomic)UIImageView *leftImageView;
/* 按钮 */
@property (strong , nonatomic)UIButton *rightButton;
@property (strong ,nonatomic)NSMutableArray *dataArr;

-(instancetype)initWithFrame:(CGRect)frame LeftImage:(NSString *)leftimage Interval:(NSInteger)interval RollingTime:(float)rollingTime TitleFont:(NSInteger)titleFont TitleColor:(UIColor *)titleColor;


/**
 开始滚动
 */
- (void)dc_beginRolling;

/**
 结束滚动
 */
- (void)dc_endRolling;

@end
