//
//  OpinionTypeTableCell.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/5/31.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol OpinionTypeDelegate <NSObject>

- (void)opinionTypeWithTag:(NSInteger)index;

@end

@interface OpinionTypeTableCell : UITableViewCell
@property (nonatomic, assign) id<OpinionTypeDelegate>delegate;
@end
