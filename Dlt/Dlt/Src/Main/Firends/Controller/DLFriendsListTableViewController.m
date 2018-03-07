//
//  DLFriendsListTableViewController.m
//  Dlt
//
//  Created by Liuquan on 17/5/27.
//  Copyright © 2017年 mr_chen. All rights reserved.
//

#import "DLFriendsListTableViewController.h"
#import "DLFriendsHeadView.h"
#import "DLFriendsCell.h"
#import "RCDataManager.h"
#import "ConversationViewController.h"
#import "DLFriendsModel.h"
#import "DltUICommon.h"
#import "RCHttpTools.h"
#import "RCDataBaseManager.h"
#import "DLMyNewFriendsTableViewController.h"
#import "DLFriendsSetTableViewController.h"
#import "DLUserInfDetailViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "NSString+PinYin.h"
#define kHeaderViewH   119

@interface DLFriendsListTableViewController ()<DLFriendsHeadViewDelegate>

@property (nonatomic, strong) DLFriendsHeadView *headView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *seachArr;
///字母分区
@property (nonatomic, strong)NSMutableDictionary *friendsList;
@property (nonatomic, strong)NSMutableArray *listArray;
@property (nonatomic, assign) BOOL isSeach;
@end

@implementation DLFriendsListTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self dl_networkForGetFriendsList];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.sectionIndexColor = [UIColor grayColor];
    self.isSeach = NO;
    DLFriendsHeadView *headView = [[DLFriendsHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kHeaderViewH)];
    self.headView = headView;
    headView.delegate = self;
    self.tableView.tableHeaderView = headView;
    // 获取好友列表
//    [self dl_networkForGetFriendsList];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dl_networkForGetFriendsList) name:kRefreshFriendsListNoticationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dl_networkForGetFriendsList) name:kHandleRequestNotificationName object:nil];
    
    //mj刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(mjDownRefresh)];
}
//下拉刷新
- (void)mjDownRefresh{
    self.isSeach = NO;
    self.headView.textField.text = nil;
    [self dl_networkForGetFriendsList];
}
#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isSeach) {
        return 1;
    }
    return self.listArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSeach) {
        return self.seachArr.count;
    }
    NSString *key = self.listArray[section];
    NSMutableArray *array = [self.friendsList objectForKey:key];
    return array.count;
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (self.isSeach) {
        return @[];
    }
    return self.listArray;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.isSeach) {
        return @"搜索到";
    }
    if (self.listArray.count > section) {
        return [self.listArray objectAtIndex:section];
    } else {
        return @"";
    }
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    NSLog(@"sectionForSectionIndexTitle: %@",title);
    return index;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLFriendsCell *friendsCell = [DLFriendsCell creatFriendsCellWithTableView:tableView];
    if (self.listArray.count > indexPath.section) {
        NSString *key = self.listArray[indexPath.section];
        NSMutableArray *array = [self.friendsList objectForKey:key];
        DLFriendsInfo *fInfo = array[indexPath.row];
//        friendsCell.frinedsInfo = self.isSeach ? self.seachArr[indexPath.row] : self.dataArr[indexPath.row];
        friendsCell.frinedsInfo = self.isSeach ? self.seachArr[indexPath.row] : fInfo;
    }
    
    @weakify(self)
    friendsCell.clickBlock = ^(DLFriendsInfo *userInfo) {
        @strongify(self)
        DLUserInfDetailViewController *vc = [DLUserInfDetailViewController new];
        vc.otherUserId = userInfo.fid;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    return friendsCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    DLFriendsInfo *userInfo = self.isSeach ? self.seachArr[indexPath.row] : self.dataArr[indexPath.row];
    if (self.listArray.count > indexPath.section  && !self.isSeach) {
        NSString *key = self.listArray[indexPath.section];
        NSMutableArray *array = [self.friendsList objectForKey:key];
        userInfo = array[indexPath.row];
    }
    ConversationViewController *conversation = [[ConversationViewController alloc] init];
    conversation.conversationType = ConversationType_PRIVATE;
    conversation.targetId = userInfo.fid;
    conversation.hidesBottomBarWhenPushed = YES;
    conversation.title = userInfo.name;
    [_mainView.navigationController pushViewController:conversation animated:YES];
}
#pragma mark - 自定义代理
- (void)seachYourSelfFriendsWithNickName:(NSString *)nickName {
    self.isSeach = ISNULLSTR(nickName) ? NO : YES;
    [self.seachArr removeAllObjects];
    for (DLFriendsInfo *info in self.dataArr) {
        if ([info.name containsString:nickName]) {
            [self.seachArr addObject:info];
        } else if ([[NSString getStringNameWithHYName:info.name] containsString:nickName] && ![self.seachArr containsObject:info]){
            [self.seachArr addObject:info];
        }
        
    }
    if (self.seachArr.count == 0) {
        self.isSeach = NO;
        [DLAlert alertWithText:@"没有搜索到好友"];
    }
    [self.tableView reloadData];
}

- (void)checkYourSelfNewFriends {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DLMyNewFriendsTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"DLMyNewFriendsTableViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)cancleSearchFriends {
    self.isSeach = NO;
    [self.tableView reloadData];
}
#pragma mark - 网络请求
- (void)dl_networkForGetFriendsList {
    DLTUserProfile * user = [DLTUserCenter userCenter].curUser;
    NSString *url = [NSString stringWithFormat:@"%@UserCenter/myFriends",BASE_URL];
    NSDictionary *params = @{
                             @"token" : [DLTUserCenter userCenter].token,
                             @"uid" : user.uid
                             };
    @weakify(self)
    [BANetManager ba_request_POSTWithUrlString:url parameters:params successBlock:^(id response) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        DLFriendsModel *friendsModel = [DLFriendsModel modelWithJSON:response];
        if ([friendsModel.code integerValue] == 1) {
            [self.dataArr removeAllObjects];
            //处理返回值首字母
            for (DLFriendsInfo *info in friendsModel.data) {
                info.firstLetter = [NSString getFirstNameWithText:info.name];
            }
            [self.dataArr addObjectsFromArray:friendsModel.data];
            [self backFirstLetterWithArray:self.dataArr];
            NSMutableArray *temp = [NSMutableArray array];
            for (DLFriendsInfo *model in friendsModel.data) {
                RCUserInfo *info = [[RCUserInfo alloc] initWithUserId:model.fid name:model.name portrait:[NSString stringWithFormat:@"%@%@",BASE_IMGURL,model.headImg]];
                [[RCIM sharedRCIM] refreshUserInfoCache:info withUserId:model.fid];

                [temp addObject:info];
            }
            [[RCDataBaseManager shareInstance] insertUserListToDB:temp];
        }
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
    } progress:nil];
}
//处理获取的好友列表
- (void)backFirstLetterWithArray:(NSArray *)friendArray {
    [self.friendsList removeAllObjects];
    [self.listArray removeAllObjects];
    for (DLFriendsInfo *friendInfo in self.dataArr) {
        if ([self.friendsList.allKeys containsObject:friendInfo.firstLetter]) {//包含  添加到mArray;
            NSMutableArray *gFriendArray = [self.friendsList objectForKey:friendInfo.firstLetter];
            [gFriendArray addObject:friendInfo];
        } else {
            NSMutableArray *mArray = [NSMutableArray new];
            [mArray addObject:friendInfo];
            [self.friendsList setObject:mArray forKey:friendInfo.firstLetter];
        }
    }
    self.listArray = [[[self.friendsList allKeys] sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    /*
     
     NSMutableArray *temp = [NSMutableArray array];
     for (DLFriendsInfo *model in friendsModel.data) {
     RCUserInfo *info = [[RCUserInfo alloc] initWithUserId:model.fid name:model.name portrait:[NSString stringWithFormat:@"%@%@",BASE_IMGURL,model.headImg]];
     [[RCIM sharedRCIM] refreshUserInfoCache:info withUserId:model.fid];
     
     [temp addObject:info];
     }
     [[RCDataBaseManager shareInstance] insertUserListToDB:temp];
     */
    
  
    
}
#pragma mark - 懒加载
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)seachArr {
    if (!_seachArr) {
        _seachArr = [NSMutableArray array];
    }
    return _seachArr;
}
- (NSMutableDictionary *)friendsList {
    if (!_friendsList) {
        _friendsList = [NSMutableDictionary dictionary];
    }
    return _friendsList;
}
- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kRefreshFriendsListNoticationName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHandleRequestNotificationName object:nil];
}

@end
