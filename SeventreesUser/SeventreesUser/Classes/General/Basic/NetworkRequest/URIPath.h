//
//  URIPath.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/8.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#ifndef URIPath_h
#define URIPath_h

#pragma mark ——— 登录/注册/短信

#define       kRegisterURIPath              @"/api/sysRegister/register"        // 注册

#define       kLoginURIPath                 @"/api/token"                       // 登录

#define       kSendVerifyCodeURIPath        @"/api/sysRegister/getCode"         // 获取短信验证码

#pragma mark ——— 首页

#define       kHomeListURIPath              @"/api/pllayout/list"               // 首页数据列表

#define       kHomeSysnoticeURIPath         @"/api/sysnotice/all"               // 首页公告跑马灯

#define       kHomeFindNameLikeURIPath      @"/api/pllayout/findNameLike"       // 首页模糊搜索商品、品牌名称

#define       kHomeAueryBrandURIPath        @"/api/pmbrand/queryBrand"          // 首页查询品牌商品详情

#define       kHomeQueryBrandGoodsURIPath   @"/api/pmgoods/queryBrandGoods"      // 首页查询商品

#pragma mark ——— 商品详情

#define       kQueryGoodsDetailsURIPath      @"/api/pmgoods/queryGoodsDetails"       // 查询商品详情

#define       kQueryApiPmCommentsURIPath     @"/api/pmcomments/queryApiPmComments"   // 查询商品详情评论

#define       kQueryBrandInfoURIPath         @"/api/pmbrand/brandInfo"               // 查询品牌

#pragma mark ——— 购物车

#define       kShoppingQueryGoodsListURIPath         @"/api/pmshoppingcart/query"       // 查询购物车商品列表

#define       kShoppingAddGoodsURIPath               @"/api/pmshoppingcart/create"        // 购物车加入商品

#define       kShoppingDeleteListToURIPath           @"/api/pmshoppingcart/delete"      // 购物车删除商品列表

#define       kShoppingUpdateGoodsCountURIPath       @"/api/pmshoppingcart/update"      // 更新（+/-）购物车商品数量

#pragma mark ——— 收藏管理

#define      kCollectListQueryURIPath      @"/api/pccollect/queryCollectList"      // 查询我的收藏列表

#define      kCollectAddGoodsURIPath       @"/api/pccollect/create"                // 加入/取消收藏商品

#pragma mark ——— 优惠卷

#define      kCouponListQueryURIPath       @"/api/srvoucher/voucherList"           // 查询优惠卷列表

#define      kCouponGainURIPath            @"/api/srvoucher/getVoucher"            // 领取优惠卷



#endif /* URIPath_h */
