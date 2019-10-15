//
//  FMMenuView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMMenuView.h"

@interface FMMenuView ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *itemViews;



@end

@implementation FMMenuView

- (void)fm_bindViewModel {
    @weakify(self)

    [RACObserve(self.viewModel, menuEntitys) subscribeNext:^(NSArray<FMHomeMenuModel *> *menuEntitys) {
        @strongify(self)
        for (NSUInteger idx = 0; idx != menuEntitys.count; idx++) {
            FMHomeMenuModel *menuEntity = menuEntitys[idx];
            
            UIView *containerItemView = self->_itemViews[idx];
            
            UIImageView *imgView = containerItemView.subviews[0];
            [imgView sd_setImageWithURL:[NSURL URLWithString:menuEntity.picUrl]];
//            [imgView sd_setImageWithURL:[NSURL URLWithString:menuEntity.picUrl] placeholderImage:[UIImage imageNamed:@""]];
            
            UILabel *titleLabel = containerItemView.subviews[1]; // menuEntitys
            titleLabel.text = menuEntity.name;
        }
    }];
    
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:_itemViews.count];
    for (NSUInteger idx = 0; idx != _itemViews.count; idx++) {
        UIView *containerItemView = self->_itemViews[idx];
        UIButton *button = containerItemView.subviews[2];
        button.tag = idx;
        [buttons addObject:button];
    }
    for (UIButton *itemButton in buttons) {
        [[itemButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *itemButton) {
            @strongify(self)
            NSUInteger idx = itemButton.tag;
            NSString *code = self.viewModel.menuEntitys[idx].code;
            [self.viewModel.itemActionSubject sendNext:code];
        }];
    }
}

- (FMHomeMenuViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMHomeMenuViewModel alloc] init];
    }
    return _viewModel;
}

@end
