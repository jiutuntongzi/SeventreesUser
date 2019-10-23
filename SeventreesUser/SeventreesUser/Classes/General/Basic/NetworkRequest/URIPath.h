//
//  URIPath.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/8.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#ifndef URIPath_h
#define URIPath_h

#define       kRegisterURIPath              @"/api/sysRegister/register"        // 注册

#define       kLoginURIPath                 @"/api/token"                       // 登录

#define       kSendVerifyCodeURIPath        @"/api/sysRegister/getCode"         // 获取短信验证码

#pragma mark ——— 首页

#define       kHomeListURIPath              @"/api/pllayout/list"               // 首页数据列表

#define       kHomeSysnoticeURIPath         @"/api/sysnotice/all"               // 首页公告跑马灯

#define       kHomeFindNameLikeURIPath      @"/api/pllayout/findNameLike"       // 首页模糊搜索商品、品牌名称

#define       kHomeAueryBrandURIPath        @"/api/pmbrand/queryBrand"          // 首页查询品牌

#define       kHomeQueryBrandGoodsURIPath   @"/api/pmgoods/queryBrandGoods"      // 首页查询商品

#pragma mark ——— 商品

#define       kQueryGoodsDetailsURIPath      @"/api/pmgoods/queryGoodsDetails"        // 查询商品详情

#define       kQueryApiPmCommentsURIPath     @"/api/pmcomments/queryApiPmComments"   // 查询商品详情评论

#define       kQueryBrandInfoURIPath         @"/api/pmbrand/brandInfo"               // 查询品牌详情




#endif /* URIPath_h */
