//
//  FMStoreCheckCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/9.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMStoreCheckCell.h"
#import "PagingView.h"

#define     kIcon_store_check_selected       @"icon_store_check_selected"
#define     kIcon_store_check_normal         @"icon_store_check_normal"

@interface FMStoreCheckCell ()

@property (weak, nonatomic) IBOutlet UIImageView *haedImgView;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkIconButton;

@property (weak, nonatomic) IBOutlet UIButton *storeItemButton;

@property (weak, nonatomic) IBOutlet UIButton *telephoneButton;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;

@end

@implementation FMStoreCheckCell

- (void)selectCurrentCell {
     PagingView *pagingView = (PagingView *)self.tableView.superview;
     for (FMStoreCheckModel *entity in pagingView.entitys) {
         entity.isCheck = NO;
     }
     self.viewModel.storeEntity.isCheck = YES;
     [self.tableView reloadData];
     [self.tableView scrollToRowAtIndexPath:self.viewModel.storeEntity.indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (void)fm_setupSubviews {
    self.ctc_selectionStyle(UITableViewCellSelectionStyleNone);
}

- (void)fm_bindObserver {
    @weakify(self)
    
    void (^checkStatusBlock)(BOOL) = ^(BOOL isCheck) {
        if (isCheck) {
            self->_checkIconButton.cb_setImageOfNamed(kIcon_store_check_selected);
        } else {
            self->_checkIconButton.cb_setImageOfNamed(kIcon_store_check_normal);
        }
    };
    
    [[self rac_valuesAndChangesForKeyPath:@"viewModel.storeEntity" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(RACTuple *tuple) {
        @strongify(self) if (!self) return;
        
        FMStoreCheckModel *storeEntity = tuple.first;
        checkStatusBlock(storeEntity.isCheck);
        
        [self->_haedImgView sd_setImageWithURL:[NSURL URLWithString:storeEntity.logoUrl] placeholderImage:UIImage.new];
        self->_storeNameLabel.text = storeEntity.name ?: @"--";
        
        NSString *storeDistance = [NSString stringWithFormat:@"距您%.1f公里", storeEntity.storeDistance.doubleValue];
        self->_distanceLabel.text = storeEntity.storeDistance ? storeDistance : @"--";
        
        self->_telephoneLabel.text = storeEntity.phone ? [NSString stringWithFormat:@"电话：%@", storeEntity.phone] : @"--";
        
        self->_addressLabel.text = storeEntity.detailedAddress ?: @"--";
    }];
    
    /*
     [RACObserve(self.viewModel, storeEntity) subscribeNext:^(FMStoreCheckModel *storeEntity) {
     @strongify(self)
     
     if (storeEntity.isCheck) {
     self->_checkIconButton.cb_setImageOfNamed(@"icon_store_check_selected");
     } else {
     self->_checkIconButton.cb_setImageOfNamed(@"icon_store_check_normal");
     }
     }];
     */
}

- (void)setViewModel:(FMStoreCheckViewModel *)viewModel {
    _viewModel = viewModel;
    
    [self fm_bindViewModel];
}

- (void)fm_bindViewModel {
    @weakify(self)  if (! _viewModel) return;
    
    [[_storeItemButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        if (self.viewModel.storeEntity.isCheck == YES) {
            [SVProgressHUD showInfoWithStatus:@"请选择其它门店"];
            return ;
        }
        /*
        PagingView *pagingView = (PagingView *)self.tableView.superview;
        for (FMStoreCheckModel *entity in pagingView.entitys) {
            if (![entity isEqual:self.viewModel.storeEntity]) {
                entity.isCheck = NO;
            }
        }
        BOOL isCheck = self.viewModel.storeEntity.isCheck;
        self.viewModel.storeEntity.isCheck = !isCheck;
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:self.viewModel.storeEntity.indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        */
        [self->_viewModel.checkActionSubject sendNext:self.viewModel.storeEntity];
    }];
    
    [[_telephoneButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        
        [self->_viewModel.telephoneActionSubject sendNext:self.viewModel.storeEntity];
    }];
    
    [[_addressButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        
        [self->_viewModel.addressActionSubject sendNext:self.viewModel.storeEntity];
    }];
}

@end
