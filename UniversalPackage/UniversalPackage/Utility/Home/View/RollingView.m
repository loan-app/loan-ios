//
//  RollingView.m
//  FlyingCowYok
//
//  Created by dashen on 2018/11/17.
//Copyright © 2018年 Single_Nobel. All rights reserved.
//
#define RollingBtnTag      1000

#define RollingViewHeight self.frame.size.height
#define RollingViewWidth self.frame.size.width
#define RollingMargin 10
#import "RollingView.h"


@interface RollingView ()

/** 定时器的循环时间 */
@property (nonatomic , assign) NSInteger interval;
/* 定时器 */
@property (strong , nonatomic)NSTimer *timer;
/* 图片 */
@property (strong , nonatomic)NSString *leftImage;

/* 标题 */
@property (strong , nonatomic)NSArray *rolTitles;

/* 滚动时间 */
@property (assign , nonatomic)float rollingTime;
/* 字体尺寸 */
@property (nonatomic , assign) NSInteger titleFont;
/* 字体颜色 */
@property (strong , nonatomic)UIColor *titleColor;

/* 滚动按钮数组 */
@property (strong , nonatomic)NSMutableArray *saveMiddleArray;
/** 是否显示tagLabel边框 */
@property (nonatomic,assign)BOOL isShowTagBorder;

@end

@implementation RollingView

#pragma mark - LazyLoad
- (UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeCenter;
    }
    return _leftImageView;
}


- (NSMutableArray *)saveMiddleArray
{
    if (!_saveMiddleArray) {
        _saveMiddleArray = [NSMutableArray array];
    }
    return _saveMiddleArray;
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    if (dataArr) {
        self.rolTitles = dataArr;
        [self setUpOneGroupRollingUI]; //UI
    }
}

#pragma mark - Intial
-(instancetype)initWithFrame:(CGRect)frame LeftImage:(NSString *)leftimage Interval:(NSInteger)interval RollingTime:(float)rollingTime TitleFont:(NSInteger)titleFont TitleColor:(UIColor *)titleColor{
    if (self = [super initWithFrame:frame]) {
        self.leftImage = leftimage;
        self.interval =(interval == 0 || interval > 100) ? 5.0 : interval;
        self.rollingTime=(rollingTime <= 0.1  || rollingTime > 1) ? 0.5 : rollingTime;
        self.titleFont = (titleFont == 0) ? 13 : titleFont;
        self.titleColor = (titleColor == nil) ? [UIColor blackColor] : titleColor;
        [self setUpRollingLeft];
        
    }
    return self;
}


#pragma mark - 界面搭建【CDDRollingOneGroup】
- (void)setUpOneGroupRollingUI
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setUpRollingCenter];
    [self addSubview:_leftImageView];
    [self.timer invalidate];
    [self dc_beginRolling];
}

#pragma mark - 左边图片
- (void)setUpRollingLeft
{
    if (self.leftImage == nil)return;
    
    self.leftImageView.frame = CGRectMake(10, 3, 24, 24);
    self.leftImageView.image = [UIImage imageNamed:self.leftImage];
    
}


#pragma mark - 中间滚动内容
- (void)setUpRollingCenter
{
    //    if (self.saveMiddleArray.count > 0) return;
    [self.saveMiddleArray removeAllObjects];
    
    if (_rolTitles.count > 0) {
        for (NSInteger i = 0; i < _rolTitles.count; i++) {
            CGRect middleFrame =  CGRectMake(CGRectGetMaxX(self.leftImageView.frame)+10, 0, kWidth - CGRectGetMaxX(self.leftImageView.frame), 30);
            UIButton *middleView = [self getBackMiddleViewWithFrame:middleFrame WithIndex:i];
            UILabel *contentLabel = [UILabel new];
            [middleView addSubview:contentLabel];
            contentLabel.textAlignment = NSTextAlignmentLeft;
            contentLabel.font = [UIFont systemFontOfSize:self.titleFont];
            contentLabel.textColor = self.titleColor;
            contentLabel.text = self.rolTitles[i];
            contentLabel.frame = CGRectMake(5, 0, middleView.frame.size.width - RollingMargin, middleView.frame.size.height);
            [self setUpCATransform3DWithIndex:i WithButton:middleView]; //旋转
        }
    }
}



#pragma mark - 开始滚动
- (void)dc_beginRolling{
    
    _timer = [NSTimer timerWithTimeInterval:self.interval target:self selector:@selector(titleRolling) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

#pragma mark - 结束滚动
- (void)dc_endRolling{
    [_timer invalidate];
}


#pragma mark - 标题滚动
- (void)titleRolling{
    
    if (self.saveMiddleArray.count > 1) { //所存的每组滚动
        __weak typeof(self)weakSelf = self;
        
        [UIView animateWithDuration:self.rollingTime animations:^{
            
            [self getMiddleArrayWithIndex:0 WithAngle:- M_PI_2 Height:- RollingViewHeight / 2]; //第0组
            
            [self getMiddleArrayWithIndex:1 WithAngle:0 Height:0]; //第一组
            
        } completion:^(BOOL finished) {
            
            if (finished == YES) { //旋转结束
                UIButton *newMiddleView = [weakSelf getMiddleArrayWithIndex:0 WithAngle:M_PI_2 Height: -RollingViewHeight / 2];
                [weakSelf.saveMiddleArray addObject:newMiddleView];
                
                [weakSelf.saveMiddleArray removeObjectAtIndex:0];
            }
        }];
    }
    
}

#pragma mark - CATransform3D翻转
- (UIButton *)getMiddleArrayWithIndex:(NSInteger)index WithAngle:(CGFloat)angle Height:(CGFloat)height
{
    if (index > _saveMiddleArray.count) return 0;
    UIButton *middleView = self.saveMiddleArray[index];
    
    CATransform3D trans = CATransform3DIdentity;
    trans = CATransform3DMakeRotation(angle, 1, 0, 0);
    trans = CATransform3DTranslate(trans, 0, height, height);
    middleView.layer.transform = trans;
    return middleView;
}

#pragma mark - 初始布局
- (void)setUpCATransform3DWithIndex:(NSInteger)index WithButton:(UIButton *)contentButton
{
    if (index != 0) {
        CATransform3D trans = CATransform3DIdentity;
        trans = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
        trans = CATransform3DTranslate(trans, 0, - RollingViewHeight / 2, -RollingViewHeight / 2);
        contentButton.layer.transform = trans;
    }else{
        CATransform3D trans = CATransform3DIdentity;
        trans = CATransform3DMakeRotation(0, 1, 0, 0);
        trans = CATransform3DTranslate(trans, 0, 0, - RollingViewHeight / 2);
        contentButton.layer.transform = trans;
    }
}

#pragma mark - 初始化中间View
- (UIButton *)getBackMiddleViewWithFrame:(CGRect)frame WithIndex:(NSInteger)index
{
    UIButton *middleView = [UIButton buttonWithType:UIButtonTypeCustom];
    middleView.adjustsImageWhenHighlighted = NO;
    middleView.tag = RollingBtnTag + index;
    [middleView addTarget:self action:@selector(titleButonAction:) forControlEvents:UIControlEventTouchUpInside];
    middleView.frame = frame;
    [self addSubview:middleView];
    [self.saveMiddleArray addObject:middleView];
    return middleView;
}

- (void)titleButonAction:(UIButton *)sender
{
    NSInteger tag = sender.tag - RollingBtnTag;
    if ([self.delegate respondsToSelector:@selector(dc_RollingViewSelectWithActionAtIndex:)]) {
        [self.delegate dc_RollingViewSelectWithActionAtIndex:tag];
    }
}

@end
