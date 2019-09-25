//
//  FMNewAddressController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMNewAddressController.h"

#import "CZHAddressPickerView.h"

@interface FMNewAddressController ()

@property (nonatomic, weak) IBOutlet UIButton *pullMenuButton;

@property (nonatomic, weak) IBOutlet UIButton *defaultSwitchButton;

@property (nonatomic, weak) IBOutlet UIButton *saveButton;

@end

@implementation FMNewAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addActions];
}

- (void)fm_addSubviews {
    
}

- (void)addActions {
    @weakify(self)
    [[_saveButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)    if (!self) return;
        
    }];
    
    // 省市区：三级菜单下拉框
    [[_pullMenuButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)    if (!self) return;
        
        [CZHAddressPickerView areaPickerViewWithAreaBlock:^(NSString *province, NSString *city, NSString *area) {
            NSString *address = [NSString stringWithFormat:@"%@%@%@", province, city, area];
            DLog(@"address == %@", address);
        }];
    }];
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.view.cv_endEditing();
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    if (_stype == FMNewAddressControllerPageStyleEdit) {
        self.navigationItem.title = @"编辑收货地址";
    } else {
        self.navigationItem.title = @"新建收货地址";
    }
}

- (void)fm_refreshData {
    if (_stype == FMNewAddressControllerPageStyleEdit) {
        
    } else {
        
    }
}

@end
