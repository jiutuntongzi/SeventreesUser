//
//  FMOrderListController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderListController.h"

#import "PagingView.h"
#import "FMOrderCell.h"
#import "FMOrderDetailsController.h"


@interface FMOrderListController ()

@property (nonatomic, strong) PagingView *pagingView;

@end

@implementation FMOrderListController

- (void)fm_addSubviews {
    __weak typeof(self) weakSelf = self;

    // FMOrderCellRowHeight 动态组高
    PagingView *pagingView = [[PagingView alloc] initWithLimit:10 uriPath:kOrderListQueryURIPath rowHeight:FMOrderCellRowHeight params:@{@"orderType": @(global_orderType).stringValue} requestDataHandler:^(NetworkResultModel *resultModel) {
        
        if (![resultModel.statusCode isEqualToString:@"OK"]) {
            [SVProgressHUD showInfoWithStatus:resultModel.statusMsg];
            [SVProgressHUD dismissWithDelay:1.f];
        }
        NSArray *dictAry = @[
                             @{
                                 @"orderId": @(2676),           // --订单id
                                 @"orderCode": @"1568794293868",      //  --订单编码
                                 @"orderStatus": @(1),           // --订单状态（1 未付款 2 拣货中 3已关闭 4 已发货 5 未评价 6 退货中 7 已退货 8 拒接退货 9 订单取消 10 部分已发货 11已完成）
                                 @"createTime": @"2019-09-18 16:11:33",  //  --订单时间
                                 @"orderPrice": @(29.99),          //  --订单金额
                                 @"poOrderGoodsModelList": @[ // --商品信息
                                         @{
                                             @"goodsId": @(16),  //  --商品id
                                             @"goodsImage": @"http://shengmei1868.com/upload/20181026/7a37f8151c314523b5d289b7dad50452.png",  // --图片
                                             @"goodsName": @"奶粉",  //  --名字
                                             @"goodsNum": @(2),   // --数量
                                             @"goodsPrice": @(59.02) //   --价格
                                             }
                                         ]
                                 },
                             @{
                                 @"orderId": @(2677),           // --订单id
                                 @"orderCode": @"1568794293868",      //  --订单编码
                                 @"orderStatus": @(2),           // --订单状态（1 未付款 2 拣货中 3已关闭 4 已发货 5 未评价 6 退货中 7 已退货 8 拒接退货 9 订单取消 10 部分已发货 11已完成）
                                 @"createTime": @"2019-09-18 16:11:33",  //  --订单时间
                                 @"orderPrice": @(29.99),          //  --订单金额
                                 @"poOrderGoodsModelList": @[ // --商品信息
                                         @{
                                             @"goodsId": @(17),  //  --商品id
                                             @"goodsImage": @"http://shengmei1868.com/upload/20181026/7a37f8151c314523b5d289b7dad50452.png",  // --图片
                                             @"goodsName": @"奶粉",  //  --名字
                                             @"goodsNum": @(1),   // --数量
                                             @"goodsPrice": @(59.02) //   --价格
                                             }
                                         ]
                                 },
                             @{
                                 @"orderId": @(2678),           // --订单id
                                 @"orderCode": @"1568794293868",      //  --订单编码
                                 @"orderStatus": @(4),           // --订单状态（1 未付款 2 拣货中 3已关闭 4 已发货 5 未评价 6 退货中 7 已退货 8 拒接退货 9 订单取消 10 部分已发货 11已完成）
                                 @"createTime": @"2019-09-18 16:11:33",  //  --订单时间
                                 @"orderPrice": @(99.99),          //  --订单金额
                                 @"poOrderGoodsModelList": @[ // --商品信息
                                         @{
                                             @"goodsId": @(17),  //  --商品id
                                             @"goodsImage": @"http://shengmei1868.com/upload/20181026/7a37f8151c314523b5d289b7dad50452.png",  // --图片
                                             @"goodsName": @"奶粉",  //  --名字
                                             @"goodsNum": @(1),   // --数量
                                             @"goodsPrice": @(59.02) //   --价格
                                             }
                                         ]
                                 },
                             @{
                                 @"orderId": @(2678),           // --订单id
                                 @"orderCode": @"1568794293868",      //  --订单编码
                                 @"orderStatus": @(5),           // --订单状态（1 未付款 2 拣货中 3已关闭 4 已发货 5 未评价 6 退货中 7 已退货 8 拒接退货 9 订单取消 10 部分已发货 11已完成）
                                 @"createTime": @"2019-09-18 16:11:33",  //  --订单时间
                                 @"orderPrice": @(59.99),          //  --订单金额
                                 @"poOrderGoodsModelList": @[ // --商品信息
                                         @{
                                             @"goodsId": @(17),  //  --商品id
                                             @"goodsImage": @"http://shengmei1868.com/upload/20181026/7a37f8151c314523b5d289b7dad50452.png",  // --图片
                                             @"goodsName": @"奶粉",  //  --名字
                                             @"goodsNum": @(1),   // --数量
                                             @"goodsPrice": @(59.02) //   --价格
                                             }
                                         ]
                                 },
                            ];
        
        return [[FMOrderModel mj_objectArrayWithKeyValuesArray:dictAry] copy];

//        return [[FMOrderModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"data"]] copy];
        
    } cellConfig:^UITableViewCell* (UITableView *tableView, NSIndexPath *indexPath, NSArray *entitys) {
        FMOrderCell *cell = FMOrderCell.ctc_cellReuseNibLoadForTableView(tableView);
        FMOrderCellViewModel *viewModel = [[FMOrderCellViewModel alloc] init];
        viewModel.orderEntity = entitys[indexPath.row];
        cell.viewModel = viewModel;
        return cell;
        
    } cellDidSelectHandler:^(FMOrderModel *orderEntity) {
        DLog(@"orderEntity == %@", orderEntity);
        [FMOrderDetailsController showByType:FMOrderDetailsPageStyleWaitPay orderId:orderEntity.orderId fromController:weakSelf];
//        FMOrderDetailsController *nextVC = [[FMOrderDetailsController alloc] init];
//        nextVC.type = FMOrderDetailsPageStyleWaitPay;
//        nextVC.orderId = orderEntity.orderId;
//        [weakSelf.navigationController pushViewController:nextVC animated:YES];
    }];
    _pagingView = pagingView;
    self.view.cv_addSubview(pagingView);
}

- (void)fm_makeConstraints {
    self.view.bounds = CGRectMake(0, 0, self.view.width, kScreenHeight - kStatusBarHeight - kFixedHeight - 44.f);
    _pagingView.cv_frame(self.view.bounds);
}

- (void)requestReloadData {
    [_pagingView requestData];
}



@end
