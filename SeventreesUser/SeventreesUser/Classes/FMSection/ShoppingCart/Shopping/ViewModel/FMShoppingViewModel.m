//
//  FMShoppingViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/23.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMShoppingViewModel.h"

@implementation FMShoppingViewModel

- (void)fm_initialize {
    
    @weakify(self)
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(id result) {
        @strongify(self)    if (!self) return;
        
        [self.refreshUISubject sendNext:result]; // 登录成功发UI信号
    }];
    
    [[self.requestDataCommand.executing skip:1] subscribeNext:^(id x) {
        if ([x isEqualToNumber:@(YES)]) {
            DLog(@"（命令执行中..）");
        } else {
            DLog(@"（命令未开始 / 命令执行完成OK");
        }
    }];
}

#pragma mark - Lazyload

- (RACCommand *)requestDataCommand {
    if (!_requestDataCommand) {
        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                DLog(@"self.shoppingGoodsModel == %@", self.shoppingGoodsModel);
                // 网络请求
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.douban.com/v2/book/search?q=%22%E7%BE%8E%E5%A5%B3%22"]];
                [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
                        [subscriber sendNext:resultDictionary];
                        [subscriber sendCompleted];
                    });
                }] resume];

                return [RACDisposable disposableWithBlock:^{
                    DLog(@"网络请求命令资源销毁了");
                }];
                
            }];
        }];
    }
    return _requestDataCommand;
}

- (RACSubject *)refreshUISubject {
    if (!_refreshUISubject) {
        _refreshUISubject = [RACSubject subject];
    }
    return _refreshUISubject;
}

@end
