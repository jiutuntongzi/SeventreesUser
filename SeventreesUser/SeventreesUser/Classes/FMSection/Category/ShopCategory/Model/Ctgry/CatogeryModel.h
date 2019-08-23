//
//	CatogeryModel.h
//
//	Create by 志伟 谌 on 7/11/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "CatogeryData.h"

@interface CatogeryModel : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSArray * data;
@property (nonatomic, strong) NSString * msg;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end