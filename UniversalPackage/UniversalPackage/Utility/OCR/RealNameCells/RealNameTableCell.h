//
//  RealNameTableCell.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/6/6.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RealNameDelegate <NSObject>

- (void)idcardOCROnlineFront;

- (void)idcardOCROnlineBack;

@end

@interface RealNameTableCell : UITableViewCell

@property (nonatomic, strong) UIImageView * frontRealImg;
@property (nonatomic, strong) UIImageView * behindRealImg;
@property (nonatomic, assign)id<RealNameDelegate> delegate;
@end
