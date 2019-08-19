//
//  FMViewController.m
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/15.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "FMViewController.h"

@implementation FMViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    FMViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController);
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController);
        viewController.view.cv_backColor(UIColor.whiteColor);
        [viewController fm_addSubviews];
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

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
    if (self = [super init]) {
    }
    return self;
}

/** 添加子views */
- (void)fm_addSubviews { }

/** 绑定ViewModel */
- (void)fm_bindViewModel { }

/** 设置导航栏 */
- (void)fm_setupNavbar {
    static NSString * const _returnImageName = @"ic_return";
    
    UIButton *customButton = UIButton.cb_button();
    customButton.cv_frameOf(0.f, 0.f, kNavBarHeight, kNavBarHeight);
    customButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.navigationItem.cni_leftBarButtonItem(UIBarButtonItem.cbi_initWithCustomView(customButton));
    __weak typeof(self) weakSelf = self;
    customButton.cb_setImageOfNamed(_returnImageName).cc_setActionEventsCallback(UIControlEventTouchUpInside, ^(UIButton *button) {
        if ([weakSelf.navigationController popViewControllerAnimated:YES] == nil) {
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    });
}

/** 刷新数据 */
- (void)fm_refreshData { }

- (void)dealloc {
    DLog(@"销毁了");
}

@end
