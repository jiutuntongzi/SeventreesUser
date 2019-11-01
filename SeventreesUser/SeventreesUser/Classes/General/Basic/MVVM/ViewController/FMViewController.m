//
//  FMViewController.m
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/15.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "FMViewController.h"

@implementation FMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.automaticallyAdjustsScrollViewInsets = YES;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    FMViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController);
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController);
        
        [viewController fm_addSubviews];
        [viewController fm_bindObserver];
        [viewController fm_makeConstraints];
        [viewController fm_bindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        @strongify(viewController);
        
        [viewController fm_setupNavbar];
        [viewController fm_refreshData];
    }];
    
    return viewController;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

/** Subclass Implement */
- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
    if (self = [super init]) {
    }
    return self;
}

/** 添加子views */
- (void)fm_addSubviews { /** Subclass Implement */ }

/** 添加布局约束 */
- (void)fm_makeConstraints { /** Subclass Implement */ }

/** 绑定KVO观察 */
- (void)fm_bindObserver { /** Subclass Implement */ };

/** 绑定ViewModel */
- (void)fm_bindViewModel { /** Subclass Implement */ }


/** 设置导航栏 */
- (void)fm_setupNavbar {
    static NSString * const _returnImageName = @"icon_navBack";
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *returnItem = UIBarButtonItem.cbi_initWithImageStyleForTouchCallback(_returnImageName, 1, ^(UIBarButtonItem *leftItem) {
        if ([weakSelf.navigationController popViewControllerAnimated:YES] == nil) {
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    });
    self.navigationItem.cni_leftBarButtonItem(returnItem);
}

/** 刷新页面数据 */
- (void)fm_refreshData { /** Subclass Implement */ }

@end
