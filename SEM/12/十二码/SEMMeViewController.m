//
//  SEMMeViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMMeViewController.h"
#import "SEMMeViewModel.h"
#import "MeinfoVIew.h"
#import "MeTopView.h"
#import "MDABizManager.h"
#import "SEMLoginViewController.h"
@interface SEMMeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)SEMMeViewModel* viewModel;
@property (nonatomic,strong)MeTopView* topView;
@property (nonatomic,strong)UITableView* tableview;
@end

@implementation SEMMeViewController

#pragma mark- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindModel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- controllerSetup
- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubviews];
    [self makeConstraits];
}

- (void)addSubviews
{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableview];
}

- (void)makeConstraits
{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).dividedBy(2.8);
    }];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
}

- (void)bindModel
{
    self.title = self.viewModel.title;
}

#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[SEMMeViewModel alloc] initWithDictionary: routerParameters];
}

#pragma mark- uitableViewdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MeViewCell"];
    cell.imageView.image = [UIImage imageNamed:self.viewModel.images[indexPath.row]];
    [cell.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
        make.left.equalTo(cell.contentView.mas_left).offset(9);
    }];
    cell.textLabel.text = self.viewModel.items[indexPath.row];
    [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).offset(35);
        make.centerY.equalTo(cell.contentView.mas_centerY);
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark -Getter
- (MeTopView*)topView
{
    if (!_topView) {
        _topView = [[MeTopView alloc] initWithFrame:CGRectZero];
        _topView.name = @"爱足球的宝贝";
        _topView.headImage = [UIImage imageNamed:@"logo"];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            SEMLoginViewController* login = [HRTRouter objectForURL:@"login" withUserInfo:@{}];
            [self presentViewController:login animated:YES completion:nil];
        }];
        [_topView.userHeadView addGestureRecognizer:tap];
    }
    return _topView;
}

- (UITableView*)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.separatorInset = UIEdgeInsetsMake(0, 35, 0, 0);
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}
@end
