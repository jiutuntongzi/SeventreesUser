//
//  FMNewAddressController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMNewAddressController.h"

@interface FMNewAddressController ()

@property (nonatomic, weak) IBOutlet UIButton *saveButton;

@end

@implementation FMNewAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)fm_addSubviews {
    @weakify(self)
    [[_saveButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)    if (!self) return;
        
    }];
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
