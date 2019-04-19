//
//  LimitTextView.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/5/31.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LimitTextView : UITextView
@property (nonatomic,copy)NSString *placeholder;
@property (nonatomic,strong) UIColor * placeholderColor;
@property (nonatomic, retain) UILabel *placeHolderLabel;
-(void)textChanged:(NSNotification*)notification;
@end
