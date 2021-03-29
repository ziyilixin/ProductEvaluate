//
//  ViewController.m
//  ProductEvaluate
//
//  Created by Mac on 2021/3/29.
//

#import "ViewController.h"
#import "Evaluate.h"
#import "ProductEvaluateCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

static NSString * const cellId = @"ProductEvaluateCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
    
    [self loadData];
}

- (void)setUpUI {
    self.navigationController.title = @"商品评价";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, kNavigationBarHeight + kTabBarHeight, 0);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self.tableView registerClass:[ProductEvaluateCell class] forCellReuseIdentifier:cellId];
}

- (void)loadData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Evaluate" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    id info = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.dataArray = [Evaluate mj_objectArrayWithKeyValuesArray:info];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.evaluate = self.dataArray[indexPath.row];
    cell.evaluateBlock = ^(NSArray * _Nonnull pictures, NSInteger index) {
        [self showPictures:pictures index:index];
    };
    return cell;
}

- (void)showPictures:(NSArray *)pictures index:(NSInteger)index {
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    [pictures enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GKPhoto *photo = [[GKPhoto alloc] init];
        photo.url = [NSURL URLWithString:obj];
        [photos addObject:photo];
    }];
    
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:index];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    browser.loadStyle = GKPhotoBrowserLoadStyleDeterminate;
    [browser showFromVC:self];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
