//
//  FMServerConsumeCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMServerConsumeCell.h"
#import "FMMenuBarView.h"

const CGFloat FMServerConsumeCellHeight = 100.f;

@interface FMServerConsumeCell ()

@property (weak, nonatomic) IBOutlet UIView *scrollerContentView;
@property (strong, nonatomic) FMMenuBarView *menuBarView;

@end

@implementation FMServerConsumeCell

- (void)fm_setupSubviews {
    self.ctc_selectionStyle(UITableViewCellSelectionStyleNone);
    
    /// 小说滚动菜单
    NSMutableArray *infos = [[NSMutableArray alloc] initWithCapacity:10];
    for (NSUInteger idx = 0; idx != 8; idx++) {
//        NSMutableDictionary *mInfo = [[model mj_keyValues] mutableCopy]; // model -> dict
        NSMutableDictionary *mInfo = [[NSMutableDictionary alloc] initWithCapacity:2];
        mInfo[@"isSelected"] = @(NO);
        mInfo[@"index"] = @(idx);
        mInfo[@"name"] = @"游泳服务";
        [infos addObject:mInfo];
    }
    __weak typeof(self) weakSelf = self;
    FMMenuBarView *menuBarView = [[FMMenuBarView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 30.f) dataSources:[infos copy] didSelectItemHandler:^(NSDictionary *info) {
        NSLog(@"类目被选中：SelectItem info == %@", info);
    }];
    _menuBarView = menuBarView;
    [_scrollerContentView addSubview:menuBarView];
}


@end
