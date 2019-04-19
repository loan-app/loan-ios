//
//  MineHeadView.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/20.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HeadViewDelegate<NSObject>
-(void)clickWithHeadView:(UIGestureRecognizer *)sender;
@end
@interface MineHeadView : UIView
@property(strong,nonatomic)UIImageView *headImgView;
@property(strong,nonatomic)UILabel *phoneLab;
@property(assign,nonatomic) id<HeadViewDelegate>hdelegate;
@end
