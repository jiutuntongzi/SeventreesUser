//
//  FMGoodsDetailsPageStyle.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#ifndef FMGoodsDetailsPageStyle_h
#define FMGoodsDetailsPageStyle_h

typedef NS_ENUM(NSUInteger, FMGoodsDetailsPageStyle) {
    FMGoodsDetailsPageStyleNormal       = 0,         // 普通商品详情
    FMGoodsDetailsPageStyleSpell        = 1,         // 拼团商品详情
    FMGoodsDetailsPageStyleActivity    = 2,         // 活动商品详情
};

// 全局的 商品详情页面类型
static FMGoodsDetailsPageStyle global_goodsDetailsPageStyle = FMGoodsDetailsPageStyleActivity;

#endif /* FMGoodsDetailsPageStyle_h */
