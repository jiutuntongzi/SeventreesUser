//
//  PagingCalculateUtility.m
//  YXGJSJ
//
//  Created by wushiye on 2019/7/25.
//  Copyright © 2019 印象管家商家. All rights reserved.
//

#import "PagingCalculateUtility.h"
#import "NetworkRequestManager.h"
#import "MJRefresh.h"


@interface PagingCalculateUtility ()

/** 是否上拉加载：YES / NO (默认：isUpPull = NO) */
@property (nonatomic, assign) BOOL isUpPull;

/** 分页的页号 (默认：pageNo = 1) */
@property (nonatomic, assign) NSUInteger pageNo;

/** 分页限制 (默认：limit = 10) */
@property (nonatomic, assign) NSUInteger limit;

/** 统一资源标识(URI)请求路径 */
@property (nonatomic, copy) NSString *uriPath;

/** 请求参数：除limit、page字段外的 */
@property (nonatomic, strong) NSMutableDictionary *mParams;

@property (nonatomic, copy) NetworkRequestDataHandler requestDataHandler;

@property (nonatomic, copy) FinishReloadTABHandler finishReloadDataHandler;

@property (nonatomic, strong) NSMutableArray *entitys;

@end

@implementation PagingCalculateUtility

#pragma mark ——— Public Interface

- (void)execPullDownRefresh {
    _isUpPull = NO;
    _pageNo = 1;
    
    [self requestLoadData];
}


- (void)execUpPullLoad {
    _isUpPull = YES;
    _pageNo++;
    
    [self requestLoadData];
}

#pragma mark ——— Private Interface

- (instancetype)initWithPageNo:(NSUInteger)pageNo limit:(NSUInteger)limit uriPath:(NSString *)uriPath params:(NSDictionary *)params requestDataHandler:(NetworkRequestDataHandler)requestDataHandler finishReloadData:(FinishReloadTABHandler)finishReloadDataHandler {
    if (self = [super init]) {
        _pageNo = pageNo;
        _limit = limit;
        _uriPath = [uriPath copy];
        _mParams = [params mutableCopy];
        
        _requestDataHandler = requestDataHandler;
        _finishReloadDataHandler = finishReloadDataHandler;
    }
    return self;
}

/** 加载数据：上拉/下拉 */
- (void)requestLoadData {
    if (_limit != 0) {
        self.mParams[@"limit"] = @(_limit);
        self.mParams[@"page"] = @(_pageNo);
    }
    [networkMgr POST:_uriPath params:[self.mParams copy] success:^(NetworkResultModel *resultModel) {
//        if (! resultModel.isSuccess) {
//            if (!self->_isUpPull) -- self.pageNo;
//        }
        if (!self->_requestDataHandler) return;
        NSArray *entitys = [self->_requestDataHandler(resultModel) copy];
        if (!self->_isUpPull) [self.entitys removeAllObjects];
        [self.entitys addObjectsFromArray:entitys];
        
        if (self->_finishReloadDataHandler) self->_finishReloadDataHandler(self.entitys);
        
    } failure:^(NSError *error) {
        if (!self->_isUpPull) -- self.pageNo;
        if (self->_finishReloadDataHandler) self->_finishReloadDataHandler(self.entitys);
    }];
}

- (NSMutableDictionary *)mParams {
    if (!_mParams) {
        _mParams = [[NSMutableDictionary alloc] initWithCapacity:2];
    }
    return _mParams;
}

- (NSMutableArray *)entitys {
    if (!_entitys) {
        _entitys = [[NSMutableArray alloc] initWithCapacity:20];
    }
    return _entitys;
}

@end
