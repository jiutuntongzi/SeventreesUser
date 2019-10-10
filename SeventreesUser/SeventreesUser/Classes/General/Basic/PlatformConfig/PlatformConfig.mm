//
//  PlatformConfig.c
//  Chain-Master
//
//  Created by FMMac on 2019/4/5.
//  Copyright © 2019 apple. All rights reserved.
//

#include "PlatformConfig.h"

///////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////  三方平台支付、分享、推送、地图Key等 >>>  ///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////


#pragma mark - 支付宝支付
/** 阿里支付AppScheme */
//@"scme2017121300673431d41891://wcb_yckc";
NSString * const aliPayAppScheme = @"CarBox";

#pragma mark - 微信支付
/** 微信商户ID */
NSString * const weChatPartnerid = @"";

#pragma mark - 微信平台分享
/** 微信私钥 */
NSString * const weChatSecret = @"484d1571d5dddb3f5ee3919f7255411a";

/** 微信AppId */
NSString * const weChatAppId = @"wx38169b0ece4b726c";

#pragma mark - QQ平台分享
/** QQ AppId */
NSString * const qqAppId = @"1106262490";

/** QQ AppKey */
NSString * const qqAppKey = @"OMJcl7PCWPBEkuUk";

#pragma mark - 新浪微博平台分享

/** 新浪微博 AppKey */
NSString * const weiboAppKey = @"1239274028";

/** 新浪微博私钥 AppSecret */
NSString * const weiboSecret = @"184a54ee6d306251ae8e5831358dad6e";

#pragma mark - 支付宝分享
/** 支付宝AppID */
NSString * const aliPayAppId = @"2017121300673431";

/** 公司网站（分享内容来源） */
// 公司网站 @"http://www.wcbkj.com";

/** 魔窗一键跳转 */
NSString * const mlinkURLStr = @"https://atcwyj.mlinks.cc/AbLX";

/** 联车宝盒微信公众号原始ID */
NSString * const weChatOriginalId = @"gh_d07a93d4bf08";

/** 微信App内一键关注微信公众号链接 */
NSString * const weChatAttentionURL = @"https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MzIyNDg5Njg3NQ%3D%3D&scene=110#wechat_redirect";

#pragma mark - 极光推送AppKey
/** 极光推送AppKey */
NSString * const JPUSHAppKey = @"08d4f7542238839114df7aeb";

#pragma mark - 百度地图鹰眼AK

/** 百度地图鹰眼AK */
NSString * const baiduMapAK = @"08eFlbbegRxBp5R6Pbw0KPYl19DzTYyL";

/**  TTSAppId：与申请百度地图相应App的应用编号对应 （用于百度地图后台语音）*/
NSString * const baiduMapTTSAppID = @"9451555";


///////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////// <<< 三方平台支付、分享、推送、地图Key等   ///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////   App应用信息 >>>  ///////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - 应用信息

/** AppID */
NSString * const appleAppID = @"1239095898";

/** 苹果商店App下载地址 */
NSString * const appStoreURL = @"https://itunes.apple.com/cn/app/id1239095898?mt=8";

/** 应用包名（产品唯一标识） */
NSString * const appBundleId = @"com.ckapp.wcbkj";

/** 运营品牌
 * 1：Seventrees
 */
const NSUInteger operationBrand = 1;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////  <<< App应用信息   ///////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////
