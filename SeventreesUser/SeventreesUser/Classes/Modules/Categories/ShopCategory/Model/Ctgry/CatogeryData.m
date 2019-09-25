//
//	CatogeryData.m
//
//	Create by 志伟 谌 on 7/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CatogeryData.h"

NSString *const kCatogeryDataBrands = @"brands";
NSString *const kCatogeryDataCategory = @"category";
NSString *const kCatogeryDataCreateId = @"createId";
NSString *const kCatogeryDataCreated = @"created";
NSString *const kCatogeryDataIdField = @"id";
NSString *const kCatogeryDataIsParent = @"isParent";
NSString *const kCatogeryDataList = @"list";
NSString *const kCatogeryDataModified = @"modified";
NSString *const kCatogeryDataModifyId = @"modifyId";
NSString *const kCatogeryDataName = @"name";
NSString *const kCatogeryDataParentId = @"parentId";
NSString *const kCatogeryDataPicUrl = @"picUrl";
NSString *const kCatogeryDataSortOrder = @"sortOrder";
NSString *const kCatogeryDataStatus = @"status";
NSString *const kCatogeryDataType = @"type";

@interface CatogeryData ()
@end
@implementation CatogeryData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kCatogeryDataBrands] != nil && [dictionary[kCatogeryDataBrands] isKindOfClass:[NSArray class]]){
		NSArray * brandsDictionaries = dictionary[kCatogeryDataBrands];
		NSMutableArray * brandsItems = [NSMutableArray array];
		for(NSDictionary * brandsDictionary in brandsDictionaries){
			Brand * brandsItem = [[Brand alloc] initWithDictionary:brandsDictionary];
			[brandsItems addObject:brandsItem];
		}
		self.brands = brandsItems;
	}
	if(![dictionary[kCatogeryDataCategory] isKindOfClass:[NSNull class]]){
		self.category = [dictionary[kCatogeryDataCategory] integerValue];
	}

	if(![dictionary[kCatogeryDataCreateId] isKindOfClass:[NSNull class]]){
		self.createId = [dictionary[kCatogeryDataCreateId] integerValue];
	}

	if(![dictionary[kCatogeryDataCreated] isKindOfClass:[NSNull class]]){
		self.created = dictionary[kCatogeryDataCreated];
	}	
	if(![dictionary[kCatogeryDataIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kCatogeryDataIdField] integerValue];
	}

	if(![dictionary[kCatogeryDataIsParent] isKindOfClass:[NSNull class]]){
		self.isParent = dictionary[kCatogeryDataIsParent];
	}	
	if(dictionary[kCatogeryDataList] != nil && [dictionary[kCatogeryDataList] isKindOfClass:[NSArray class]]){
		NSArray * listDictionaries = dictionary[kCatogeryDataList];
		NSMutableArray * listItems = [NSMutableArray array];
		for(NSDictionary * listDictionary in listDictionaries){
			CatogeryList * listItem = [[CatogeryList alloc] initWithDictionary:listDictionary];
			[listItems addObject:listItem];
		}
		self.list = listItems;
	}
	if(![dictionary[kCatogeryDataModified] isKindOfClass:[NSNull class]]){
		self.modified = dictionary[kCatogeryDataModified];
	}	
	if(![dictionary[kCatogeryDataModifyId] isKindOfClass:[NSNull class]]){
		self.modifyId = [dictionary[kCatogeryDataModifyId] integerValue];
	}

	if(![dictionary[kCatogeryDataName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kCatogeryDataName];
	}	
	if(![dictionary[kCatogeryDataParentId] isKindOfClass:[NSNull class]]){
		self.parentId = [dictionary[kCatogeryDataParentId] integerValue];
	}

	if(![dictionary[kCatogeryDataPicUrl] isKindOfClass:[NSNull class]]){
		self.picUrl = dictionary[kCatogeryDataPicUrl];
	}	
	if(![dictionary[kCatogeryDataSortOrder] isKindOfClass:[NSNull class]]){
		self.sortOrder = [dictionary[kCatogeryDataSortOrder] integerValue];
	}

	if(![dictionary[kCatogeryDataStatus] isKindOfClass:[NSNull class]]){
		self.status = [dictionary[kCatogeryDataStatus] integerValue];
	}

	if(![dictionary[kCatogeryDataType] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[kCatogeryDataType] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.brands != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Brand * brandsElement in self.brands){
			[dictionaryElements addObject:[brandsElement toDictionary]];
		}
		dictionary[kCatogeryDataBrands] = dictionaryElements;
	}
	dictionary[kCatogeryDataCategory] = @(self.category);
	dictionary[kCatogeryDataCreateId] = @(self.createId);
	if(self.created != nil){
		dictionary[kCatogeryDataCreated] = self.created;
	}
	dictionary[kCatogeryDataIdField] = @(self.idField);
	if(self.isParent != nil){
		dictionary[kCatogeryDataIsParent] = self.isParent;
	}
	if(self.list != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(CatogeryList * listElement in self.list){
			[dictionaryElements addObject:[listElement toDictionary]];
		}
		dictionary[kCatogeryDataList] = dictionaryElements;
	}
	if(self.modified != nil){
		dictionary[kCatogeryDataModified] = self.modified;
	}
	dictionary[kCatogeryDataModifyId] = @(self.modifyId);
	if(self.name != nil){
		dictionary[kCatogeryDataName] = self.name;
	}
	dictionary[kCatogeryDataParentId] = @(self.parentId);
	if(self.picUrl != nil){
		dictionary[kCatogeryDataPicUrl] = self.picUrl;
	}
	dictionary[kCatogeryDataSortOrder] = @(self.sortOrder);
	dictionary[kCatogeryDataStatus] = @(self.status);
	dictionary[kCatogeryDataType] = @(self.type);
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.brands != nil){
		[aCoder encodeObject:self.brands forKey:kCatogeryDataBrands];
	}
	[aCoder encodeObject:@(self.category) forKey:kCatogeryDataCategory];	[aCoder encodeObject:@(self.createId) forKey:kCatogeryDataCreateId];	if(self.created != nil){
		[aCoder encodeObject:self.created forKey:kCatogeryDataCreated];
	}
	[aCoder encodeObject:@(self.idField) forKey:kCatogeryDataIdField];	if(self.isParent != nil){
		[aCoder encodeObject:self.isParent forKey:kCatogeryDataIsParent];
	}
	if(self.list != nil){
		[aCoder encodeObject:self.list forKey:kCatogeryDataList];
	}
	if(self.modified != nil){
		[aCoder encodeObject:self.modified forKey:kCatogeryDataModified];
	}
	[aCoder encodeObject:@(self.modifyId) forKey:kCatogeryDataModifyId];	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kCatogeryDataName];
	}
	[aCoder encodeObject:@(self.parentId) forKey:kCatogeryDataParentId];	if(self.picUrl != nil){
		[aCoder encodeObject:self.picUrl forKey:kCatogeryDataPicUrl];
	}
	[aCoder encodeObject:@(self.sortOrder) forKey:kCatogeryDataSortOrder];	[aCoder encodeObject:@(self.status) forKey:kCatogeryDataStatus];	[aCoder encodeObject:@(self.type) forKey:kCatogeryDataType];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.brands = [aDecoder decodeObjectForKey:kCatogeryDataBrands];
	self.category = [[aDecoder decodeObjectForKey:kCatogeryDataCategory] integerValue];
	self.createId = [[aDecoder decodeObjectForKey:kCatogeryDataCreateId] integerValue];
	self.created = [aDecoder decodeObjectForKey:kCatogeryDataCreated];
	self.idField = [[aDecoder decodeObjectForKey:kCatogeryDataIdField] integerValue];
	self.isParent = [aDecoder decodeObjectForKey:kCatogeryDataIsParent];
	self.list = [aDecoder decodeObjectForKey:kCatogeryDataList];
	self.modified = [aDecoder decodeObjectForKey:kCatogeryDataModified];
	self.modifyId = [[aDecoder decodeObjectForKey:kCatogeryDataModifyId] integerValue];
	self.name = [aDecoder decodeObjectForKey:kCatogeryDataName];
	self.parentId = [[aDecoder decodeObjectForKey:kCatogeryDataParentId] integerValue];
	self.picUrl = [aDecoder decodeObjectForKey:kCatogeryDataPicUrl];
	self.sortOrder = [[aDecoder decodeObjectForKey:kCatogeryDataSortOrder] integerValue];
	self.status = [[aDecoder decodeObjectForKey:kCatogeryDataStatus] integerValue];
	self.type = [[aDecoder decodeObjectForKey:kCatogeryDataType] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	CatogeryData *copy = [CatogeryData new];

	copy.brands = [self.brands copy];
	copy.category = self.category;
	copy.createId = self.createId;
	copy.created = [self.created copy];
	copy.idField = self.idField;
	copy.isParent = [self.isParent copy];
	copy.list = [self.list copy];
	copy.modified = [self.modified copy];
	copy.modifyId = self.modifyId;
	copy.name = [self.name copy];
	copy.parentId = self.parentId;
	copy.picUrl = [self.picUrl copy];
	copy.sortOrder = self.sortOrder;
	copy.status = self.status;
	copy.type = self.type;

	return copy;
}
@end
