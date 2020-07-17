//
//  ViewController.m
//  wechatDemo
//
//  Created by Bytedance on 2020/7/16.
//  Copyright © 2020 Bytedance. All rights reserved.
//

#import "ViewController.h"
#import "chatCellDataModel.h"
#import "ChatTableViewCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataModel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *dict = [self JSONToDict];
    self.dataModel = [NSMutableArray arrayWithCapacity:20];
    for (NSDictionary *item in dict) {
        [self.dataModel addObject:[[chatCellDataModel alloc] initWithDictionary: item]];
    }
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    chatCellDataModel *cellDataModel = [self.dataModel objectAtIndex:indexPath.row];
    
    [cell bindModel:cellDataModel];
    
    return cell;
}

- (NSDictionary *)JSONToDict {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sessions" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

#pragma mark -- Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[ChatTableViewCell class] forCellReuseIdentifier:@"cellID"];
    }
    return _tableView;
}
@end
