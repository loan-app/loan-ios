//
//  RegisterView.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/7/7.
//  Copyright © 2018 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RegisterViewDelagate<NSObject>
- (void)clickRegisterWithBtn:(UIButton *)sender;
- (void)clickVerifytWithBtn:(UIButton *)sender;
@end
@interface RegisterView : UIView
@property(strong,nonatomic)UITextField *verifyTextfiled;
@property(strong,nonatomic)UIButton *verifyBtn;
@property(strong,nonatomic)UIView *firstLine;
@property(strong,nonatomic)UITextField *pwdTextfiled;
@property(strong,nonatomic)UIView *secndLine;
@property(strong,nonatomic)UIButton *nextBtn;
@property (nonatomic, assign) id<RegisterViewDelagate> delegate;

@end
