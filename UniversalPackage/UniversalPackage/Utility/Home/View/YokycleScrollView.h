//
//  YokycleScrollView.h
//  Demo
//
//  Created by Single_Nobel on 2018/7/4.
//  Copyright © 2018 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YokycleScrollView;
@protocol YokycleScrollViewDelegate <NSObject>
/** 点击图片回调 */
- (void)cycleScrollView:(YokycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
@end

@interface YokycleScrollView : UIView

//*代理方法
@property (nonatomic ,weak) id<YokycleScrollViewDelegate> delegate;

@property(strong,nonatomic)NSArray *dataArr;


- (void)startTimer;

- (void)stopTimer;

@end
