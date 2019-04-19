//
//  StartoverView.h
//  KeleGuan
//
//  Created by Single_Nobel on 2018/7/19.
//  Copyright © 2018 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartoverView : NSObject
+(StartoverView *)sharInstance;
@property(copy,nonatomic)NSString *JumpurlStr;
@property(strong,nonatomic)UIView *backView;
@property(strong,nonatomic)UIImageView *closeImageView;
@property(strong,nonatomic)UIImageView *contentImageView;



@end
