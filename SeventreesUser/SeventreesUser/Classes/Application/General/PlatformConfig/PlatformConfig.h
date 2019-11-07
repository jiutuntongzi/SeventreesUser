//
//  PlatformConfig.h
//  Chain-Master
//
//  Created by FMMac on 2019/4/5.
//  Copyright © 2019 apple. All rights reserved.
//

#ifndef PlatformConfig_h
#define PlatformConfig_h

#import <Foundation/Foundation.h>


///////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////  三方平台支付、分享、推送、地图Key等 >>>  ///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark ——— <第三方平台配置>

/******************************* 支付宝支付 *******************************/

/** 支付宝支付AppScheme */
extern NSString * const aliPayAppScheme;

/******************************* 微信支付 *******************************/
/** 微信商户ID */
extern NSString * const weChatPartnerid;

/******************************* 微信平台分享 *******************************/
/** 微信AppId */
extern NSString * const weChatAppId;

/** 微信私钥 */
extern NSString * const weChatSecret;

/******************************* QQ平台分享 *******************************/
/** QQ AppId */
extern NSString * const qqAppId;

/** QQ AppKey */
extern NSString * const qqAppKey;

/******************************* 新浪微博平台分享 *******************************/
/** 新浪微博 AppKey */
extern NSString * const weiboAppKey;

/** 新浪微博 AppSecret */
extern NSString * const weiboSecret;

/******************************* 支付宝分享 *******************************/
/** 支付宝AppID */
extern NSString * const aliPayAppId;

/****************************  魔窗一键跳转URL、公司网站、联车宝盒微信公众号原始ID ******************************/

/** 魔窗一键跳转链接 （可作分享来源） */
extern NSString * const mlinkURLStr;

/** 联车宝盒微信公众号原始ID */
extern NSString * const weChatOriginalId;

/** 微信App内一键关注微信公众号链接 */
extern NSString * const weChatAttentionURL;

/***************************************** 极光推送AppKey *****************************************/
/** 极光推送AppKey */
extern NSString * const JPUSHAppKey;

/**  TTSAppId：与申请百度地图相应App的应用编号对应 （用于百度地图后台语音）*/
extern NSString * const baiduMapTTSAppID;

/***************************************** 百度地图鹰眼AK *****************************************/
/** 百度地图鹰眼AK */
extern NSString * const baiduMapAK;


///////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////// <<< 三方平台支付、分享、推送、地图Key等   ///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////   App应用信息 >>>  ///////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark ——— <应用信息>

/** AppID */
extern NSString * const appleAppID;

/** 苹果App商店下载地址（可作分享来源） */
extern NSString * const appStoreURL;

/** 应用包名（产品唯一标识） */
extern NSString * const appBundleId;

/**
 Universal Links（通用链接）是iOS9.0出的新技术。如果我们的应用支持通用链接，那么就可以通过https链接来打开APP（手机中已经安装此APP），或者跳转到https链接（手机中没有安装此APP）。 */
extern NSString * const appUniversalLinks;

/** 运营品牌
 * 1：Seventrees
 */
NSUInteger extern const operationBrand;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////  <<< App应用信息   ///////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////


#endif /* PlatformConfig_h */