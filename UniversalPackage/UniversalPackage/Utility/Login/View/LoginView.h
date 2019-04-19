//
//  LoginView.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/7/7.
//  Copyright © 2018 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginViewDelagate <NSObject>
- (void)clickLoginWithBtn:(UIButton *)sender;
-(void)clickForgetWithBtn:(UIButton *)sender;
@end
@interface LoginView : UIView
@property(strong,nonatomic)UIImageView *logoImageView;
@property(strong,nonatomic)UILabel *phonelabel;
@property(strong,nonatomic)UILabel *pwdLabel;
@property(strong,nonatomic)UITextField *phoneTextfiled;
@property(strong,nonatomic)UIView *lineView;
@property(strong,nonatomic)UIButton *loginBtn;
@property(strong,nonatomic)UIButton *forgetPwdBtn;
@property (nonatomic, assign) id<LoginViewDelagate> delegate;
@end
