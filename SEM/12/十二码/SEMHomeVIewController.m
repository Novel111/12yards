//
//  SEMHomeVIewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMHomeVIewController.h"
#import "SEMHomeVIewModel.h"
#import "SEMNetworkingManager.h"
#import "SDCycleScrollView.h"
#import "HomeCell.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "ReCommendNews.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YYCategories.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "HomeHeadView.h"
#import "MJRefresh.h"
#import <ReactiveViewModel/ReactiveViewModel.h>
#import "HRTRouter.h"
#import "SEMSearchViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
@interface SEMHomeVIewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,SEMSearchViewControllerDelegate>
@property (nonatomic,strong) SEMHomeVIewModel * viewModel;
@property (nonatomic,strong) HomeHeadView     * headView;
@property (nonatomic,strong) UITableView      * tableView;
@property (nonatomic,strong) UIBarButtonItem  * searchItem;
@property (nonatomic,strong) UIBarButtonItem  * userItem;
@end

@implementation SEMHomeVIewController


#pragma mark- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- controllerSetup
- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubviews];
    [self makeConstraits];
    
}

- (void)setTab
{
    UIImage* image = [[UIImage imageNamed:@"首页icon-灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* selectedImage = [[UIImage imageNamed:@"首页icon-绿"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:image selectedImage:selectedImage];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:37/255.0 green:153/255.0 blue:31/255.0 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}
- (void)addSubviews
{
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = self.searchItem;
    self.navigationItem.leftBarButtonItem = self.userItem;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        
        [[self.viewModel.loadNewCommand execute: nil] subscribeNext:^(id x) {
            NSLog(@"%@",x);
            
            if ([x  isEqual: @1]) {
                //更新tableview
                [self.tableView reloadData];
            }
            else
            {
                //设置轮播图
                NSMutableArray* titles = [[NSMutableArray alloc] init];
                NSMutableArray* url = [[NSMutableArray alloc]init];
                [self.viewModel.topics enumerateObjectsUsingBlock:^(Topic * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [titles addObject:obj.title];
                    [url addObject:obj.media.url];
                }];
                self.headView.scrollView.titlesGroup = titles;
                self.headView.scrollView.imageURLStringsGroup = url;
            }


            NSLog(@"已经更新完了");
            [self endRefresh];
        }];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [[self.viewModel.loadMoreCommand execute: nil] subscribeNext:^(id x) {
            NSLog(@"已经加载了更多了");
            NSLog(@"%@",x);
            [self.tableView reloadData];
            [self endRefresh];
        }];
        
    }];
}
- (void)endRefresh
{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}
- (void)makeConstraits
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.left.bottom.equalTo(self.view);
    }];
}

- (void)bindModel
{
    [RACObserve(self.viewModel, title) subscribeNext:^(NSString* x) {
        self.navigationItem.title = x;
    }];
    self.searchItem.rac_command = self.viewModel.searchCommand;
    [self.searchItem.rac_command.executionSignals subscribeNext:^(id x) {
        NSLog(@"x");//为什么先执行这句？   
        SEMSearchViewController* searchControlle = [HRTRouter objectForURL:@"search" withUserInfo:@{}];
        searchControlle.delegate = self;
        [self.navigationController pushViewController:searchControlle animated:true];
        
    }];
}

#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[SEMHomeVIewModel alloc] initWithDictionary: routerParameters];
}
#pragma mark -initialization
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setTab];
    }
    return self;
}

#pragma mark -searchcontrollerDelegate
- (void)didSelectedItem:(NSString *)name diplayname:(NSString *)dispalyname
{
    self.viewModel.code = name;
    self.viewModel.title = dispalyname;
    NSUserDefaults *database = [NSUserDefaults standardUserDefaults];
    [database setObject:name forKey:@"name"];
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark -tableviewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    News* news = self.viewModel.datasource[indexPath.row];
    HomeCell* cell = (HomeCell*)[self.tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = news.title;

    cell.bottomview.commentLabel.text = [@(news.commentCount) stringValue];;
    cell.bottomview.inifoLabel.text = [news getInfo];
    if (news.thumbnail.url)
    {
        NSURL* url = [[NSURL alloc] initWithString:news.thumbnail.url];
        [cell.newsImage sd_setImageWithURL:url
                          placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"]
                                   options:SDWebImageRefreshCached];
    }
    else
    {
        cell.newsImage.image = [UIImage imageNamed:@"zhanwei.jpg"];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    News *news = self.viewModel.datasource[indexPath.row];
//    return [tableView fd_heightForCellWithIdentifier: NSStringFromClass([HomeCell class]) cacheByIndexPath: indexPath configuration:^(HomeCell* cell) {
//        cell.titleLabel.text = news.title;
//        cell.inifoLabel.text = [news getInfo];
//        cell.commentLabel.text = [@(news.commentCount) stringValue];;
//        if (news.thumbnail.url)
//        {
//            NSURL* url = [[NSURL alloc] initWithString:news.thumbnail.url];
//            [cell.newsImage sd_setImageWithURL:url
//                              placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"]
//                                       options:SDWebImageRefreshCached];
//        }
//        else
//        {
//            cell.newsImage.image = [UIImage imageNamed:@"zhanwei.jpg"];
//        }
//    }];
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];
    return 100*scale;
    
}

#pragma mark -Getter
- (HomeHeadView*)headView
{
    if(!_headView)
    {
        _headView = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height / 2)];
        _headView.scrollView.delegate = self;
        if (self.viewModel.topics) {
            NSMutableArray* titles = [[NSMutableArray alloc] init];
            NSMutableArray* url = [[NSMutableArray alloc]init];
            [self.viewModel.topics enumerateObjectsUsingBlock:^(Topic * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [titles addObject:obj.title];
                [url addObject:obj.media.url];
            }];
            self.headView.scrollView.titlesGroup = titles;
            self.headView.scrollView.imageURLStringsGroup = url;
        }
        
    }
    return _headView;
}
- (UITableView*)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HomeCell class] forCellReuseIdentifier:@"HomeCell"];
        
        _tableView.tableHeaderView = self.headView;
    }
    return _tableView;
}
- (UIBarButtonItem*)searchItem
{
    if(!_searchItem)
    {
        _searchItem = [[UIBarButtonItem alloc] initWithTitle:@"切换学校" style:UIBarButtonItemStylePlain target:nil action:nil];
        [_searchItem setTintColor:[UIColor whiteColor]];
    }
    return _searchItem;
}
- (UIBarButtonItem*)userItem
{
    if (!_userItem) {
        UIImage* image = [UIImage imageNamed:@"logo"];
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 30, 30);
        [button setImage:image forState:UIControlStateNormal];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 15;
        _userItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.navigationController.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
                
            }];
        }];
    }
    return _userItem;
}

@end
