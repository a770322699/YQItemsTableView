//
//  ViewController.m
//  Demo
//
//  Created by maygolf on 16/11/22.
//  Copyright © 2016年 yiquan. All rights reserved.
//

#import "ViewController.h"

#import "YQItemsTableView.h"

@interface ViewController ()<YQItemsTableViewDelegate>

@property (nonatomic, strong) NSArray *groups;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *groups = [NSMutableArray array];
    
    NSMutableDictionary *group = [NSMutableDictionary dictionary];
    [group setObject:@"热门搜索" forKey:@"title"];
    NSArray *items = @[@"你好", @"法兰克世纪东方", @"房间大赛里发生的放假啦开始的", @"减肥的卢卡斯", @"ui大姐夫", @"放假哈德说离开", @"就发点来上课", @"复活甲", @"发货地双方就卡的发货起哦按是的看法和规范KDJ撒发生地理发的撒娇了看法", @"发的哈萨克家乐福及卡死了都", @"能发电房", @"都放假哎看来解放了", @"你好", @"法兰克世纪东方", @"房间大赛里发生的放假啦开始的", @"减肥的卢卡斯", @"ui大姐夫", @"放假哈德说离开", @"就发点来上课", @"复活甲", @"发货地双方就卡的发货起哦按是的看法和规范KDJ撒发生地理发的撒娇了看法", @"发的哈萨克家乐福及卡死了都", @"能发电房", @"都放假哎看来解放了"];
    [group setObject:items forKey:@"items"];
    [groups addObject:group];
    
    group = [NSMutableDictionary dictionary];
    [group setObject:@"搜索历史" forKey:@"title"];
    items = @[@"你好", @"法兰克世纪东方", @"房间大赛里发生的放假啦开始的", @"减肥的卢卡斯", @"ui大姐夫", @"放假哈德说离开", @"就发点来上课", @"复活甲", @"发货地双方就卡的发货起哦按是的看法和规范KDJ撒发生地理发的撒娇了看法", @"发的哈萨克家乐福及卡死了都", @"能发电房", @"都放假哎看来解放了"];
    [group setObject:items forKey:@"items"];
    [groups addObject:group];
    
    self.groups = groups;
    
    
    YQItemsTableView *tableView = [[YQItemsTableView alloc] initWithFrame:self.view.bounds];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.yq_delegate = self;
    tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - YQItemsTableViewDelegate
- (NSInteger)itemsTableView:(YQItemsTableView *)tableView numberOfItemsInSection:(NSInteger)section{
    return [self.groups[section][@"items"] count];
}
- (NSInteger)numberOfSectionsInItemsTableView:(YQItemsTableView *)tableView{
    return self.groups.count;
}

- (NSInteger)itemsTableView:(YQItemsTableView *)tableView limiteLineInsection:(NSInteger)section{
    return section ? 0 : 2;
}
- (CGFloat)itemsTableView:(YQItemsTableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0;
}
- (CGFloat)itemsTableView:(YQItemsTableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30.0;
}
- (UIEdgeInsets)itemsTableView:(YQItemsTableView *)tableView insetsInSection:(NSInteger)section{
    return UIEdgeInsetsMake(10, 12, 10, 12);
}
- (CGFloat)itemsTableView:(YQItemsTableView *)tableView minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)itemsTableView:(YQItemsTableView *)tableView minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}

- (nullable NSString *)itemsTableView:(YQItemsTableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.groups[section][@"title"];
}
- (nullable NSString *)itemsTableView:(YQItemsTableView *)tableView titleForFooterInSection:(NSInteger)section{
    return nil;
}
//- (nullable UICollectionReusableView *)itemsTableView:(YQItemsTableView *)tableView viewForHeaderInSection:(NSInteger)section;
//- (nullable UICollectionReusableView *)itemsTableView:(YQItemsTableView *)tableView viewForFooterInSection:(NSInteger)section;

- (NSString *)itemsTableView:(YQItemsTableView *)tableView titleForIndexPath:(NSIndexPath *)indexPath{
    return  self.groups[indexPath.section][@"items"][indexPath.item];
}
- (void)itemsTableView:(YQItemsTableView *)tableView configCell:(YQItemsTableViewItemCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    cell.textColor = [UIColor redColor];
}
- (void)itemsTableView:(YQItemsTableView *)tableView configTitleHeader:(YQItemsTableHeaderFooterTextView *)header atSection:(NSInteger)section{
    header.textColor = [UIColor greenColor];
}
//- (void)itemsTableView:(YQItemsTableView *)tableView configTitleFooter:(YQItemsTableHeaderFooterTextView *)footer atSection:(NSInteger)section;

- (void)itemsTableView:(YQItemsTableView *)tableView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"xxxxx");
}

@end
