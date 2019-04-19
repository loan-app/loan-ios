//
//  UploadPhotoCell.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/6/15.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpLoadDelegate <NSObject>

- (void)upLoadDelegateWithAry:(NSArray *)photoAry;

@end

@interface UploadPhotoCell : UITableViewCell

@property (nonatomic, assign) id<UpLoadDelegate> delegate;
@end
