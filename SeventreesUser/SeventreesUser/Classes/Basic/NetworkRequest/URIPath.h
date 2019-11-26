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

#define       kCategoryGoodsListQueryURIPath   @"/api/pmgoods/queryBrandGoods"      // 分页商品列表查询

#pragma mark ——— 商品详情

#define       kQueryGoodsDetailsURIPath      @"/api/pmgoods/queryGoodsDetails"       // 查询商品详情

#define       kQueryApiPmCommentsURIPath     @"/api/pmcomments/queryApiPmComments"   // 查询商品详情评论

#define       kQueryBrandInfoURIPath         @"/api/pmbrand/brandInfo"               // 查询品牌详情

#pragma mark ——— 购物车

#define       kShoppingQueryGoodsListURIPath         @"/api/pmshoppingcart/query"       // 查询购物车商品列表

#define       kShoppingAddGoodsURIPath               @"/api/pmshoppingcart/create"        // 购物车加入商品

#define       kShoppingDeleteListToURIPath           @"/api/pmshoppingcart/delete"      // 购物车删除商品列表

#define       kShoppingUpdateGoodsCountURIPath       @"/api/pmshoppingcart/update"      // 更新（+/-）购物车商品数量

#pragma mark ——— 收藏管理

#define      kCollectListQueryURIPath      @"/api/pccollect/queryCollectList"      // 查询我的收藏列表

#define      kCollectAddGoodsURIPath       @"/api/pccollect/create"                // 加入/取消收藏商品

#pragma mark ——— 优惠卷

#define      kCouponListQueryURIPath        @"/api/srvoucher/voucherList"           // 查询优惠卷分页列表

#define      kCouponGainURIPath             @"/api/srvoucher/getVoucher"            // 领取优惠卷

#define      kSelectCouponListURIPath       @"/api/poorder/queryCouponList"         // 选择优惠卷列表


#pragma mark ——— 个人资料

#define      kPersonalProfileQueryURIPath           @"/api/sysuser/getUserMsg"       // 查询个人资料

#define      kPersonalProfileUpdateURIPath          @"/api/sysuser/update"           // 修改个人资料

#define      kUpdateByCodeURIPath                   @"/api/sysuser/updateByCode"     // 修改手机号或密码

#define      kStoreListQueryURIPath                 @"/api/opshop/queryStoreList"    // 换绑门店查询门店列表

#define      kUpdateBindStoreURIPath                @"/api/sysuser/updateStore"      // 换绑门店

#pragma mark ——— 我的积分

#define      kIntegralQueryURIPath       @"/api/pcintegral/queryIntegral"     // 查询我的剩余积分

#define      kSignInIntegralURIPath      @"/api/pcintegral/signIntegral"      // 签到送积分

#define      kIntegralRecordListQueryURIPath    @"/api/pcintegralrecord/queryApiPcIntegralRecord"   // 查询积分收支明细

#define      kIntegralExplainHTMLQueryURIPath   @"/api/pcintegral/queryInstructionsHtml"   // 查询积分说明HTML网页

#pragma mark ——— 我的订单

#define      kOrderCreateURIPath                  @"/api/poorder/createOrder"             // 生成订单（下单）

#define      kOrderListQueryURIPath               @"/api/poorder/queryOrderList"          // 查订单列表

#define      kOrderDetialsQueryURIPath            @"/api/poorder/queryOrderListInfo"      // 查订单详情

#define      kOrderCancelURIPath                  @"/api/poorder/cancelOrder"             // 取消订单

#define      kOrderConfirmReceivingURIPath        @"/api/poorder/confirmReceiving"        // 确认收货

#define      kOrderGoPaymentURIPath               @"/api/poorder/paymentOrder"            // 订单支付详情

#define      kOrderLogisticsQueryURIPath          @"/api/poorder/queryLogisticsMsg"       // 查询物流信息

#pragma mark ——— 活动/砍价

#define      kBargainCategoryQueryURIPath         @"/api/pmcategory/findActivityCategory"       // 砍价分页菜单

#define      kActivityInfoURIPath                 @"/api/spactivity/activityInfo"       // 砍价详情（发起砍价）

#define      kBargainCreateURIPath                @"/api/spgroup/createBargain"         // 发起砍价

#define      kYetStartBargainInfoURIPath          @"/api/spgroup/bargainInfo"           // 已发起的砍价详情

#pragma mark ——— 售后/退货

#define      kAfterSalesListQueryURIPath          @"/api/seaftersales/queryAfterSales"      // 查询退货/退款列表

#define      kAfterSalesDetailsQueryURIPath       @"/api/seaftersales/queryAfterSalesDetails"     // 退货/退款详情

#define      kAfterSalesGoodsListQueryURIPath     @"/api/seaftersales/selectAfterSalesGoods"      // 查询退货/退款详情的商品列表

#define      kAfterSalesGoodsPriceQueryURIPath    @"/api/seaftersales/selectAfterSalesGoodsPrice"    // 查询退货退款商品的总价格

#define      kAfterSalesOrderCreateURIPath        @"/api/seaftersales/createAfterSales"      // 创建退货/退款订单

#define      kAfterSalesLogisticsInfoURIPath      @"/api/seaftersales/writeAfterSalesMsg"    // 填写物流信息

#endif /* URIPath_h */
