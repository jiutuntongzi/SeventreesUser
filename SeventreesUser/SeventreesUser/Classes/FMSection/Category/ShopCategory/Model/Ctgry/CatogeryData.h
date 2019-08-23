//
//	CatogeryData.h
//
//	Create by 志伟 谌 on 7/11/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Brand.h"
#import "CatogeryList.h"

@interface CatogeryData : NSObject

@property (nonatomic, strong) NSArray * brands;
@property (nonatomic, assign) NSInteger category;
@property (nonatomic, assign) NSInteger createId;
@property (nonatomic, strong) NSString * created;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * isParent;
@property (nonatomic, strong) NSArray * list;
@property (nonatomic, strong) NSString * modified;
@property (nonatomic, assign) NSInteger modifyId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger parentId;
@property (nonatomic, strong) NSString * picUrl;
@property (nonatomic, assign) NSInteger sortOrder;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
