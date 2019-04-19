//
//  ImgCodeAlert.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/6/4.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YzmChangeBtnDelegate <NSObject>

- (void)changeYanZhengMaWithButton:(UIButton *)sender;

@end

typedef void (^btnClickBlock)(NSString *str);

@interface ImgCodeAlert : UIView

@property (nonatomic, assign) id<YzmChangeBtnDelegate> delegate;
@property (nonatomic, strong) UIButton    * yzmImg;
@property (nonatomic, strong) UITextField * yzmTextField;

- (id)initWithTitle:(NSString *)titleStr sureBtn:(NSString *)sureBtn btnClickBlock:(btnClickBlock)btnClickIndex;
- (void)show;
- (void)setImgButton:(UIImage *)img;
- (void)hiddenKeyboard;
- (void)cancelBtnPressed;
@end
