//
//  FMGoodsDetailsModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMGoodsDetailsSpellGroupGoodsMsgModel : NSObject

@property (nonatomic, assign) NSNumber *normalPrice;

@property (nonatomic, assign) NSNumber *virtualSales;

@property (nonatomic, assign) NSNumber *buyMax;

@property (nonatomic, assign) NSNumber *originalPrice;

@property (nonatomic, assign) NSNumber *price;

@property (nonatomic, assign) NSNumber *userNum;

@end


@interface FMGoodsDetailsShowImagesExtraModel : NSObject

@end


@interface FMGoodsDetailsShowImagesModel : NSObject

@property (nonatomic, copy) NSString *dr;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) FMGoodsDetailsShowImagesExtraModel *extra;

@property (nonatomic, assign) NSNumber * type;

@end


@interface FMGoodsDetailsOrdinaryGoodsMsgModel : NSObject

@property (nonatomic, assign) NSNumber *price;

@property (nonatomic, assign) NSNumber *buyMax;

@property (nonatomic, assign) NSNumber *virtualSales;

@end


@interface FMGoodsDetailsGoodsSkusExtraModel : NSObject

@end


@interface FMGoodsDetailsGoodsSkuModelsModel : NSObject

@property (nonatomic, assign) NSNumber *id;

@property (nonatomic, assign) NSNumber *virtualSales;

@property (nonatomic, strong) FMGoodsDetailsGoodsSkusExtraModel *extra;

@property (nonatomic, copy) NSString *skuCode;

@property (nonatomic, copy) NSString *propertiesName;

@property (nonatomic, copy) NSString *picUrl;

@property (nonatomic, assign) NSNumber *normalPrice;

@property (nonatomic, assign) NSNumber *retailPrice;

@property (nonatomic, assign) NSNumber *stock;

@property (nonatomic, assign) NSNumber *salePrice;

@property (nonatomic, copy) NSString *dr;

@property (nonatomic, assign) NSNumber *sales;

@end


@interface FMGoodsDetailsActivityGoodsMsgModel : NSObject

@property (nonatomic, assign) NSNumber *virtualSales;

@property (nonatomic, assign) NSNumber *originalPrice;

@property (nonatomic, assign) NSNumber *price;

@property (nonatomic, assign) NSNumber *buyMax;

@end


@interface FMGoodsDetailsBargainingGoodsMsgModel : NSObject

@property (nonatomic, assign) NSNumber *minPrice;

@property (nonatomic, assign) NSNumber *originalPrice;

@property (nonatomic, assign) NSNumber *price;

@property (nonatomic, assign) NSNumber *virtualSales;

@property (nonatomic, assign) NSNumber *buyMax;

@end


@interface FMGoodsDetailsGoodsCommentssExtraModel : NSObject

@end


@interface FMGoodsDetailsGoodsCommentsModelsModel : NSObject

@property (nonatomic, assign) NSNumber *userId;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, assign) NSNumber *id;

@property (nonatomic, copy) NSString *createdDateTime;

@property (nonatomic, copy) NSString *dr;

@property (nonatomic, strong) FMGoodsDetailsGoodsCommentssExtraModel *extra;

@property (nonatomic, assign) NSNumber *goodsId;

@property (nonatomic, assign) NSNumber *goodsStar;

@property (nonatomic, copy) NSString *userHeadUrl;

@property (nonatomic, copy) NSArray *apiPmCommentsImgs;

@end


@interface FMGoodsDetailsDetailsImagesExtraModel : NSObject

@end


@interface FMGoodsDetailsDetailsImagesModel : NSObject

@property (nonatomic, copy) NSString *dr;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) FMGoodsDetailsDetailsImagesExtraModel *extra;

@property (nonatomic, assign) NSNumber *type;

@end

#pragma mark ——— FMGoodsDetailsModel

@interface FMGoodsDetailsModel : NSObject

@property (nonatomic, assign) NSNumber *brandGoodsNum;

@property (nonatomic, copy) NSString *brandContent;

@property (nonatomic, strong) FMGoodsDetailsSpellGroupGoodsMsgModel *spellGroupGoodsMsg;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, copy) NSString *specJson;

@property (nonatomic, copy) NSArray<FMGoodsDetailsShowImagesModel *> *showImages;

@property (nonatomic, copy) NSString *videoUrl;

@property (nonatomic, assign) NSNumber *isCollect;

@property (nonatomic, assign) NSNumber *goodsId;

@property (nonatomic, strong) FMGoodsDetailsOrdinaryGoodsMsgModel *ordinaryGoodsMsg;

@property (nonatomic, copy) NSArray<FMGoodsDetailsGoodsSkuModelsModel *> *goodsSkuModels;

@property (nonatomic, copy) NSString *brandName;

@property (nonatomic, assign) NSNumber *brandId;

@property (nonatomic, assign) NSNumber *commentNum;

@property (nonatomic, copy) NSString *videoImage;

@property (nonatomic, strong) FMGoodsDetailsActivityGoodsMsgModel *activityGoodsMsg;

@property (nonatomic, copy) NSString *brandImg;

@property (nonatomic, strong) FMGoodsDetailsBargainingGoodsMsgModel *bargainingGoodsMsg;

@property (nonatomic, copy) NSArray<FMGoodsDetailsGoodsCommentsModelsModel *> *goodsCommentsModels;

@property (nonatomic, copy) NSArray<FMGoodsDetailsDetailsImagesModel *> *detailsImages;

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

