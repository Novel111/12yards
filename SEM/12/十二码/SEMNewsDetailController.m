//
//  SEMNewsDetailController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMNewsDetailController.h"
#import "MDABizManager.h"
#import "NewsDetailViewModel.h"
#import "NewsDetailResponseModel.h"
@interface SEMNewsDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NewsDetailViewModel* viewModel;
@property (nonatomic,strong)UIWebView* webView;
@property (nonatomic,strong)UILabel* titleLabel;
@property (nonatomic,strong)UILabel* infoLabbel;
@property (nonatomic,strong)UITableView* tableview;
@end
@implementation SEMNewsDetailController
#pragma mark- lifeCycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
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

#pragma mark- setupview
- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self addsubviews];
    [self makeConstraits];
}
- (void)addsubviews
{
    [self.view addSubview:self.titleLabel];
//    [self.view addSubview:self.webView];
    [self.view addSubview:self.infoLabbel];
    [self.view addSubview:self.tableview];
}
- (void)makeConstraits
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(31 * scale);
        make.left.equalTo(self.view.mas_left).offset(10 * scale);
        make.right.equalTo(self.view.mas_right);
    }];
    [self.infoLabbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(27 * scale);
        make.left.and.right.equalTo(self.titleLabel);
    }];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoLabbel.mas_bottom).offset(29 * scale);
        make.right.equalTo(self.view.mas_right).offset(-5 * scale);
        make.left.equalTo(self.view.mas_left).offset(5 * scale);
        make.height.equalTo(self.view.mas_height);
    }];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.webView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(self.view.mas_height);
    }];
    
}
- (void)bindModel
{

    [RACObserve(self.viewModel, isLoaded) subscribeNext:^(id x) {
        if ([x  isEqual: @(YES)]) {
            NSString* text;
            if (self.viewModel.newdetail.text) {
                text = self.viewModel.newdetail.text;
            }
            else
            {
                text = self.viewModel.newdetail.detail;
            }
            [self.webView loadHTMLString:text baseURL:nil];
            self.infoLabbel.text = [self.viewModel.newdetail getInfo];
            self.titleLabel.text = self.viewModel.newdetail.title;
            self.navigationItem.title = self.titleLabel.text;
        }
    }];
}
#pragma mark- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[NewsDetailViewModel alloc] initWithDictionary: routerParameters];
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:22];
    }
    return  _titleLabel;
}
- (UILabel*)infoLabbel
{
    if (!_infoLabbel) {
        _infoLabbel = [[UILabel alloc] init];
        _infoLabbel.font = [UIFont systemFontOfSize:13];
        _infoLabbel.textColor = [UIColor colorWithHexString:@"C8C8C8"];
    }
    return _infoLabbel;
}
- (UIWebView*)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}
- (UITableView*)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}
@end
