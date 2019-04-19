//
//  ContactViewController.h
//  BorrowMoney
//
//  Created by Single_Nobel on 2017/4/6.
//  Copyright © 2017年 Single_Nobel. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^AddressBookBlock)(NSString * nameStr, NSMutableArray * phoneStr);
typedef void(^dataBlock)(NSString * dataStr);
@interface ContactViewController : BaseViewController
@property (nonatomic, copy) AddressBookBlock bookBlock;
@property (nonatomic, copy) dataBlock AryBlock;
@property (nonatomic, copy) NSDictionary *contactPeopleDict;
@property (nonatomic, copy) NSArray *keys;
@property (nonatomic, strong) NSMutableArray * dataAry;
@property (nonatomic, strong) UITableView * baseTableView;
- (void)configDataWithContact ;
@end
