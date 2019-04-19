//
//  firstProgressView.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/20.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "firstProgressView.h"
#import "firstCell.h"
static NSString *firstCellId = @"firstCell";
@implementation firstProgressView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius =5;
        [self addSubview:self.titleLabel];
        [self addSubview:self.tableview];
        self.backgroundColor = kWhiteColor;
    }
    return self;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(36, 10, 200, 20)];
        _titleLabel.text =  @"申请进度";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = Font(18);
        _titleLabel.textColor = ksixsixColor;
    }
    return _titleLabel;
}
-(void)setEventArr:(NSArray *)eventArr{
    if (eventArr) {
        _eventArr = eventArr;
        [self.tableview reloadData];
    }
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.bounds.size.height-56) style:UITableViewStylePlain];
        [_tableview registerClass:[firstCell class] forCellReuseIdentifier:firstCellId];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate =self;
        _tableview.dataSource = self;
    }
    return _tableview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _eventArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    firstCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCellId forIndexPath:indexPath];
    cell.eventObj = _eventArr[indexPath.row];
    cell.length = _eventArr.count;
    cell.row = indexPath.row+1;
    
    return cell;
}
@end
