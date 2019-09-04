//
//  FMBuyerEvaluateViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBuyerEvaluateViewModel.h"

@implementation FMBuyerEvaluateViewModel

- (void)fm_initialize {
    @weakify(self)

    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(id result) {
        @strongify(self)
        
        [self.refreshUISubject sendNext:result];
    }];
    
    [[self.requestDataCommand.executing skip:1] subscribeNext:^(id x) {
        if ([x isEqualToNumber:@(YES)]) {
            DLog(@"（HTTP请求：命令执行中..）");
        } else {
            DLog(@"（HTTP请求：命令未开始 / 命令执行完成");
        }
    }];
}

#pragma mark - Lazyload

- (RACCommand *)requestDataCommand {
    if (!_requestDataCommand) {
//        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//                @strongify(self)
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.douban.com/v2/book/search?q=%22%E7%BE%8E%E5%A5%B3%22"]];
                [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
                        [subscriber sendNext:resultDictionary];
                        [subscriber sendCompleted];
                    });
                }] resume];
                return [RACDisposable disposableWithBlock:nil];
            }];
        }];
    }
    return _requestDataCommand;
}

- (RACSubject *)refreshUISubject {
    if (!_refreshUISubject) {
        _refreshUISubject = [[RACSubject alloc] init];
    }
    return _refreshUISubject;
}

- (RACSubject *)actionSubject {
    if (!_actionSubject) {
        _actionSubject = [[RACSubject alloc] init];
    }
    return _actionSubject;
}

@end
