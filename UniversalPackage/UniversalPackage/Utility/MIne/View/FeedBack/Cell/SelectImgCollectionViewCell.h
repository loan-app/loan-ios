//
//  SelectImgCollectionViewCell.h
//  BorrowMoney
//
//  Created by Single_Nobel on 2017/6/13.
//  Copyright © 2017年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectImgCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) id asset;

@end
