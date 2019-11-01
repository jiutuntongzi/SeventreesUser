//
//  FMTableViewCell.m
//  YXGJSJ
//
//  Created by wushiye on 2019/7/29.
//  Copyright © 2019 印象管家商家. All rights reserved.
//

#import "FMTableViewCell.h"

@implementation FMTableViewCell

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
    if (self = [super init]) {
        [self bindMVVMModulars];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [self bindMVVMModulars];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self bindMVVMModulars];
    }
    return self;
}

- (void)bindMVVMModulars {
    [self fm_setupSubviews];
    [self fm_makeConstraints];
    [self fm_bindObserver];
    [self fm_bindViewModel];
}

/** 设置子views */
- (void)fm_setupSubviews { /** Subclass Implement */ };

/** 生成布局约束 */
- (void)fm_makeConstraints { /** Subclass Implement */ };

/** 绑定KVO观察 */
- (void)fm_bindObserver { /** Subclass Implement */ };

/** 绑定ViewModel */
- (void)fm_bindViewModel { /** Subclass Implement */ };


@end
