//
//  FMGoodsDetailsModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMStoreInfoModel.h"
#import "FMImageEyeModel.h"
#import "FMShopCarToolModel.h"

@interface FMGoodsDetailsSpellGroupGoodsMsgModel : NSObject

@property (nonatomic, strong) NSNumber *normalPrice;

@property (nonatomic, strong) NSNumber *virtualSales;

@property (nonatomic, strong) NSNumber *buyMax;

@property (nonatomic, strong) NSNumber *originalPrice;

@property (nonatomic, strong) NSNumber *price;

@property (nonatomic, strong) NSNumber *userNum;

@end


@interface FMGoodsDetailsShowImagesExtraModel : NSObject

@end


@interface FMGoodsDetailsShowImagesModel : NSObject

@property (nonatomic, copy) NSString *dr;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) FMGoodsDetailsShowImagesExtraModel *extra;

@property (nonatomic, strong) NSNumber * type;

@end


@interface FMGoodsDetailsOrdinaryGoodsMsgModel : NSObject

/** 自定义商品名（非JSON转Model数据）*/
@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, strong) NSNumber *price;

@property (nonatomic, strong) NSNumber *buyMax;

@property (nonatomic, strong) NSNumber *virtualSales;

@end


@interface FMGoodsDetailsGoodsSkusExtraModel : NSObject

@end


@interface FMGoodsDetailsGoodsSkuModel : NSObject

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, strong) NSNumber *virtualSales;

@property (nonatomic, strong) FMGoodsDetailsGoodsSkusExtraModel *extra;

@property (nonatomic, copy) NSString *skuCode;

@property (nonatomic, copy) NSString *propertiesName;

@property (nonatomic, copy) NSString *picUrl;

@property (nonatomic, strong) NSNumber *normalPrice;

@property (nonatomic, strong) NSNumber *retailPrice;

@property (nonatomic, strong) NSNumber *stock;

@property (nonatomic, strong) NSNumber *salePrice;

@property (nonatomic, copy) NSString *dr;

@property (nonatomic, strong) NSNumber *sales;

@end


@interface FMGoodsDetailsActivityGoodsMsgModel : NSObject

@property (nonatomic, strong) NSNumber *virtualSales;

@property (nonatomic, strong) NSNumber *originalPrice;

@property (nonatomic, strong) NSNumber *price;

@property (nonatomic, strong) NSNumber *buyMax;

@end


@interface FMGoodsDetailsBargainingGoodsMsgModel : NSObject

@property (nonatomic, strong) NSNumber *minPrice;

@property (nonatomic, strong) NSNumber *originalPrice;

@property (nonatomic, strong) NSNumber *price;

@property (nonatomic, strong) NSNumber *virtualSales;

@property (nonatomic, strong) NSNumber *buyMax;

@end


@interface FMGoodsDetailsCommentssExtraModel : NSObject

@end


@interface FMGoodsDetailsCommentsModel : NSObject

@property (nonatomic, strong) NSNumber *userId;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *userName;

/** evaluateId : id */
@property (nonatomic, strong) NSNumber *evaluateId;

@property (nonatomic, copy) NSString *createdDateTime;

@property (nonatomic, copy) NSString *dr;

@property (nonatomic, strong) FMGoodsDetailsCommentssExtraModel *extra;

@property (nonatomic, strong) NSNumber *goodsId;

@property (nonatomic, strong) NSNumber *goodsStar;

@property (nonatomic, strong) NSNumber *serverStar;

@property (nonatomic, strong) NSNumber *expressStar;

@property (nonatomic, copy) NSString *userHeadUrl;

@property (nonatomic, copy) NSArray<FMImageEyeModel *> *apiPmCommentsImgs;

@end


@interface FMGoodsDetailsImagesExtraModel : NSObject

@end


@interface FMGoodsDetailsImagesModel : NSObject

@property (nonatomic, copy) NSString *dr;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) NSNumber *type;

@property (nonatomic, strong) FMGoodsDetailsImagesExtraModel *extra;



@end

#pragma mark ——— FMGoodsDetailsModel

@interface FMGoodsDetailsModel : NSObject

@property (nonatomic, strong) NSNumber *goodsId;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, strong) NSNumber *brandId;

@property (nonatomic, copy) NSString *brandName;

@property (nonatomic, strong) NSNumber *brandGoodsNum;

@property (nonatomic, copy) NSString *brandContent;

@property (nonatomic, copy) NSString *brandImg;

@property (nonatomic, copy) NSString *videoUrl;

@property (nonatomic, strong) NSNumber *isCollect;

@property (nonatomic, strong) NSNumber *commentNum;

@property (nonatomic, copy) NSString *videoImage;

@property (nonatomic, copy) NSString *specJson;


@property (nonatomic, copy) NSArray<FMGoodsDetailsShowImagesModel *> *showImages;
/** 手动转换处理的轮播图（非JSON转Model数据）*/
//@property (nonatomic, copy) NSArray<NSString *> *imageURLStrings;

@property (nonatomic, strong) FMGoodsDetailsSpellGroupGoodsMsgModel *spellGroupGoodsMsg;

@property (nonatomic, strong) FMGoodsDetailsOrdinaryGoodsMsgModel *ordinaryGoodsMsg;

@property (nonatomic, copy) NSArray<FMGoodsDetailsGoodsSkuModel *> *goodsSkuModels;

@property (nonatomic, strong) FMGoodsDetailsActivityGoodsMsgModel *activityGoodsMsg;

@property (nonatomic, strong) FMGoodsDetailsBargainingGoodsMsgModel *bargainingGoodsMsg;



/** 用户评价列表 */
@property (nonatomic, copy) NSArray<FMGoodsDetailsCommentsModel *> *goodsCommentsModels;

@property (nonatomic, copy) NSArray<FMGoodsDetailsImagesModel *> *detailsImages;
/** 手动转换处理的图片列表 （非JSON转Model数据）*/
@property (nonatomic, copy) NSArray<NSString *> *imageURLStrings;

/** 手动转换处理的店铺信息Model （非JSON转Model数据）*/
@property (nonatomic, strong) FMStoreInfoModel *storeModel;

/** 添加商品到购物车接口请求参数 (手动转换处理，非JSON转Model数据) */
@property (nonatomic, strong) FMShopCarToolModel *goodsParamsEntity;

/*
{
    "message":"操作成功",
    "response":{
        "goodsDetailsModel":{
            "brandGoodsNum":2,
            "brandContent":"这是一个商品品牌",
            "spellGroupGoodsMsg":{
                "buyMax":20,
                "virtualSales":600,
                "originalPrice":50,
                "price":100,
                "normalPrice":12312,
                "userNum":8
            },
            "goodsName":"奶粉",
            "specJson":"[{"name":"颜色","value":["红色","蓝色"]},{"name":"尺码","value":["小码","中码","大码"]}]",
            "showImages":[
                          {
                              "dr":"N",
                              "url":"http://qiniu.shengmei1858.com/upload/20190920/b93bde98ae37421699eb80b73f7d9af0.png",
                              "extra":{
                                  
                              },
                              "type":1
                          }
                          ],
            "videoUrl":"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4",
            "goodsId":16,
            "isCollect":0,
            "ordinaryGoodsMsg":{
                "price":50,
                "buyMax":50,
                "virtualSales":908
            },
            "goodsSkuModels":[
                              {
                                  "extra":{
                                      
                                  },
                                  "id":1,
                                  "propertiesName":"颜色:红色,尺码:大码",
                                  "skuCode":"01010100000101",
                                  "virtualSales":100,
                                  "normalPrice":12312,
                                  "picUrl":"http://qiniu.shengmei1858.com/upload/20190920/b93bde98ae37421699eb80b73f7d9af0.png",
                                  "retailPrice":50,
                                  "stock":100,
                                  "salePrice":100,
                                  "dr":"N",
                                  "sales":100
                              },
                              {
                                  "extra":{
                                      
                                  },
                                  "id":2,
                                  "propertiesName":"颜色:红色,尺码:中码",
                                  "skuCode":"01010100000102",
                                  "virtualSales":100,
                                  "normalPrice":213123,
                                  "picUrl":"http://qiniu.shengmei1858.com/upload/20190920/b93bde98ae37421699eb80b73f7d9af0.png",
                                  "retailPrice":213123,
                                  "stock":100,
                                  "salePrice":100,
                                  "dr":"N",
                                  "sales":100
                              },
                              {
                                  "extra":{
                                      
                                  },
                                  "id":4,
                                  "propertiesName":"颜色:蓝色,尺码:小码",
                                  "skuCode":"01010100000104",
                                  "virtualSales":100,
                                  "normalPrice":2,
                                  "picUrl":"http://qiniu.shengmei1858.com/upload/20190920/b93bde98ae37421699eb80b73f7d9af0.png",
                                  "retailPrice":12,
                                  "stock":100,
                                  "salePrice":100,
                                  "dr":"N",
                                  "sales":100
                              },
                              {
                                  "extra":{
                                      
                                  },
                                  "id":5,
                                  "propertiesName":"颜色:蓝色,尺码:大码",
                                  "skuCode":"01010100000105",
                                  "virtualSales":100,
                                  "normalPrice":12,
                                  "picUrl":"http://qiniu.shengmei1858.com/upload/20190920/b93bde98ae37421699eb80b73f7d9af0.png",
                                  "retailPrice":12,
                                  "stock":100,
                                  "salePrice":100,
                                  "dr":"N",
                                  "sales":100
                              },
                              {
                                  "extra":{
                                      
                                  },
                                  "id":6,
                                  "propertiesName":"颜色:蓝色,尺码:中码",
                                  "skuCode":"01010100000106",
                                  "virtualSales":8,
                                  "normalPrice":20,
                                  "picUrl":"http://qiniu.shengmei1858.com/upload/20190920/b93bde98ae37421699eb80b73f7d9af0.png",
                                  "retailPrice":40,
                                  "stock":100,
                                  "salePrice":100,
                                  "dr":"N",
                                  "sales":100
                              }
                              ],
            "brandName":"Goodbaby/好孩子",
            "brandId":1,
            "commentNum":2,
            "videoImage":"http://qiniu.shengmei1858.com/upload/20190920/b93bde98ae37421699eb80b73f7d9af0.png",
            "activityGoodsMsg":{
                "virtualSales":600,
                "originalPrice":50,
                "price":100,
                "buyMax":20
            },
            "brandImg":"https://bbs-fd.zol-img.com.cn/t_s1200x5000/g4/M01/00/03/Cg-4WVQHEoCIaGc-AAN1EbYuLlsAARH5gGsRuoAA3Up966.jpg",
            "bargainingGoodsMsg":{
                "minPrice":1,
                "originalPrice":50,
                "price":100,
                "virtualSales":600,
                "buyMax":20
            },
            "goodsCommentsModels":[
                                   {
                                       "userId":7,
                                       "content":"我觉得特别好，特别好玩",
                                       "userName":"六六",
                                       "extra":{
                                           
                                       },
                                       "id":346,
                                       "dr":"N",
                                       "createdDateTime":"2019",
                                       "goodsId":16,
                                       "goodsStar":5,
                                       "userHeadUrl":"https://bbs-fd.zol-img.com.cn/t_s1200x5000/g4/M01/00/03/Cg-4WVQHEoCIaGc-AAN1EbYuLlsAARH5gGsRuoAA3Up966.jpg",
                                       "apiPmCommentsImgs":[
                                       
                                       ]
                                   }
                                   ],
            "detailsImages":[
                             {
                                 "dr":"N",
                                 "url":"http://qiniu.shengmei1858.com/upload/20190920/b93bde98ae37421699eb80b73f7d9af0.png",
                                 "extra":{
                                     
                                 },
                                 "type":2
                             }
                             ]
        }
    },
    "code":"OK"
}
*/

@end

