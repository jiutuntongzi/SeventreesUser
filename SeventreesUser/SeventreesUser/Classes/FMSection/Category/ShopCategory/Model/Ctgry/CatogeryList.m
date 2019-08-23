//
//	CatogeryList.m
//
//	Create by 志伟 谌 on 7/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CatogeryList.h"
#import "Brand.h"

NSString *const kCatogeryListBrands = @"brands";
NSString *const kCatogeryListCategory = @"category";
NSString *const kCatogeryListCreateId = @"createId";
NSString *const kCatogeryListCreated = @"created";
NSString *const kCatogeryListIdField = @"id";
NSString *const kCatogeryListIsParent = @"isParent";
NSString *const kCatogeryListModified = @"modified";
NSString *const kCatogeryListModifyId = @"modifyId";
NSString *const kCatogeryListName = @"name";
NSString *const kCatogeryListParentId = @"parentId";
NSString *const kCatogeryListPicUrl = @"picUrl";
NSString *const kCatogeryListSortOrder = @"sortOrder";
NSString *const kCatogeryListStatus = @"status";
NSString *const kCatogeryListType = @"type";

@interface CatogeryList ()
@end
@implementation CatogeryList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kCatogeryListBrands] isKindOfClass:[NSNull class]]){
        
        NSArray * brandsDictionaries = dictionary[kCatogeryListBrands];
        NSMutableArray * brandsItems = [NSMutableArray array];
        for(NSDictionary * brandsDictionary in brandsDictionaries){
            Brand *brandsItem = [[Brand alloc] initWithDictionary:brandsDictionary];
            [brandsItems addObject:brandsItem];
        }
        self.brands = brandsItems;
        
		//self.brands = dictionary[kCatogeryListBrands];
	}	
	if(![dictionary[kCatogeryListCategory] isKindOfClass:[NSNull class]]){
		self.category = [dictionary[kCatogeryListCategory] integerValue];
	}

	if(![dictionary[kCatogeryListCreateId] isKindOfClass:[NSNull class]]){
		self.createId = [dictionary[kCatogeryListCreateId] integerValue];
	}

	if(![dictionary[kCatogeryListCreated] isKindOfClass:[NSNull class]]){
		self.created = dictionary[kCatogeryListCreated];
	}	
	if(![dictionary[kCatogeryListIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kCatogeryListIdField] integerValue];
	}

	if(![dictionary[kCatogeryListIsParent] isKindOfClass:[NSNull class]]){
		self.isParent = dictionary[kCatogeryListIsParent];
	}	
	if(![dictionary[kCatogeryListModified] isKindOfClass:[NSNull class]]){
		self.modified = dictionary[kCatogeryListModified];
	}	
	if(![dictionary[kCatogeryListModifyId] isKindOfClass:[NSNull class]]){
		self.modifyId = [dictionary[kCatogeryListModifyId] integerValue];
	}

	if(![dictionary[kCatogeryListName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kCatogeryListName];
	}	
	if(![dictionary[kCatogeryListParentId] isKindOfClass:[NSNull class]]){
		self.parentId = [dictionary[kCatogeryListParentId] integerValue];
	}

	if(![dictionary[kCatogeryListPicUrl] isKindOfClass:[NSNull class]]){
		self.picUrl = dictionary[kCatogeryListPicUrl];
	}	
	if(![dictionary[kCatogeryListSortOrder] isKindOfClass:[NSNull class]]){
		self.sortOrder = [dictionary[kCatogeryListSortOrder] integerValue];
	}

	if(![dictionary[kCatogeryListStatus] isKindOfClass:[NSNull class]]){
		self.status = [dictionary[kCatogeryListStatus] integerValue];
	}

	if(![dictionary[kCatogeryListType] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[kCatogeryListType] integerValue];
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
		dictionary[kCatogeryListBrands] = self.brands;
	}
	dictionary[kCatogeryListCategory] = @(self.category);
	dictionary[kCatogeryListCreateId] = @(self.createId);
	if(self.created != nil){
		dictionary[kCatogeryListCreated] = self.created;
	}
	dictionary[kCatogeryListIdField] = @(self.idField);
	if(self.isParent != nil){
		dictionary[kCatogeryListIsParent] = self.isParent;
	}
	if(self.modified != nil){
		dictionary[kCatogeryListModified] = self.modified;
	}
	dictionary[kCatogeryListModifyId] = @(self.modifyId);
	if(self.name != nil){
		dictionary[kCatogeryListName] = self.name;
	}
	dictionary[kCatogeryListParentId] = @(self.parentId);
	if(self.picUrl != nil){
		dictionary[kCatogeryListPicUrl] = self.picUrl;
	}
	dictionary[kCatogeryListSortOrder] = @(self.sortOrder);
	dictionary[kCatogeryListStatus] = @(self.status);
	dictionary[kCatogeryListType] = @(self.type);
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
		[aCoder encodeObject:self.brands forKey:kCatogeryListBrands];
	}
	[aCoder encodeObject:@(self.category) forKey:kCatogeryListCategory];	[aCoder encodeObject:@(self.createId) forKey:kCatogeryListCreateId];	if(self.created != nil){
		[aCoder encodeObject:self.created forKey:kCatogeryListCreated];
	}
	[aCoder encodeObject:@(self.idField) forKey:kCatogeryListIdField];	if(self.isParent != nil){
		[aCoder encodeObject:self.isParent forKey:kCatogeryListIsParent];
	}
	if(self.modified != nil){
		[aCoder encodeObject:self.modified forKey:kCatogeryListModified];
	}
	[aCoder encodeObject:@(self.modifyId) forKey:kCatogeryListModifyId];	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kCatogeryListName];
	}
	[aCoder encodeObject:@(self.parentId) forKey:kCatogeryListParentId];	if(self.picUrl != nil){
		[aCoder encodeObject:self.picUrl forKey:kCatogeryListPicUrl];
	}
	[aCoder encodeObject:@(self.sortOrder) forKey:kCatogeryListSortOrder];	[aCoder encodeObject:@(self.status) forKey:kCatogeryListStatus];	[aCoder encodeObject:@(self.type) forKey:kCatogeryListType];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.brands = [aDecoder decodeObjectForKey:kCatogeryListBrands];
	self.category = [[aDecoder decodeObjectForKey:kCatogeryListCategory] integerValue];
	self.createId = [[aDecoder decodeObjectForKey:kCatogeryListCreateId] integerValue];
	self.created = [aDecoder decodeObjectForKey:kCatogeryListCreated];
	self.idField = [[aDecoder decodeObjectForKey:kCatogeryListIdField] integerValue];
	self.isParent = [aDecoder decodeObjectForKey:kCatogeryListIsParent];
	self.modified = [aDecoder decodeObjectForKey:kCatogeryListModified];
	self.modifyId = [[aDecoder decodeObjectForKey:kCatogeryListModifyId] integerValue];
	self.name = [aDecoder decodeObjectForKey:kCatogeryListName];
	self.parentId = [[aDecoder decodeObjectForKey:kCatogeryListParentId] integerValue];
	self.picUrl = [aDecoder decodeObjectForKey:kCatogeryListPicUrl];
	self.sortOrder = [[aDecoder decodeObjectForKey:kCatogeryListSortOrder] integerValue];
	self.status = [[aDecoder decodeObjectForKey:kCatogeryListStatus] integerValue];
	self.type = [[aDecoder decodeObjectForKey:kCatogeryListType] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	CatogeryList *copy = [CatogeryList new];

	copy.brands = [self.brands copy];
	copy.category = self.category;
	copy.createId = self.createId;
	copy.created = [self.created copy];
	copy.idField = self.idField;
	copy.isParent = [self.isParent copy];
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
