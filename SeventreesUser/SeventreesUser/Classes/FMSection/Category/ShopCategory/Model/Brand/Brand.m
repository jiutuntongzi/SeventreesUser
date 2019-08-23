//
//	Brand.m
//
//	Create by 志伟 谌 on 7/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Brand.h"
#import "NSString+Size.h"

NSString *const kBrandCategoryId = @"categoryId";
NSString *const kBrandCountry = @"country";
NSString *const kBrandCreateId = @"createId";
NSString *const kBrandCreated = @"created";
NSString *const kBrandDepict = @"depict";
NSString *const kBrandIdField = @"id";
NSString *const kBrandLogoUrl = @"logoUrl";
NSString *const kBrandModified = @"modified";
NSString *const kBrandModifyId = @"modifyId";
NSString *const kBrandName = @"name";
NSString *const kBrandPicUrl = @"picUrl";
NSString *const kBrandStatus = @"status";

@interface Brand ()
@end
@implementation Brand


-(CGFloat)brandHeaderHeight{
    if (self.isDownBtnHide){
        return self.allExpandheight;
    }else{
        if (self.isExpand){
            return self.allExpandheight;
        }else{
            return 224;
        }
        
    }
 
}

-(BOOL)isDownBtnHide{
    
    return self.allExpandheight <= 244;
}

-(CGFloat)allExpandheight{
    
     return 180 + [self.depict heightWithFont:12 constrainedToWidth:[UIScreen mainScreen].bounds.size.width - 30];
}


/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kBrandCategoryId] isKindOfClass:[NSNull class]]){
		self.categoryId = [dictionary[kBrandCategoryId] integerValue];
	}

	if(![dictionary[kBrandCountry] isKindOfClass:[NSNull class]]){
		self.country = dictionary[kBrandCountry];
	}	
	if(![dictionary[kBrandCreateId] isKindOfClass:[NSNull class]]){
		self.createId = [dictionary[kBrandCreateId] integerValue];
	}

	if(![dictionary[kBrandCreated] isKindOfClass:[NSNull class]]){
		self.created = dictionary[kBrandCreated];
	}	
	if(![dictionary[kBrandDepict] isKindOfClass:[NSNull class]]){
		self.depict = dictionary[kBrandDepict];
	}	
	if(![dictionary[kBrandIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kBrandIdField] integerValue];
	}

	if(![dictionary[kBrandLogoUrl] isKindOfClass:[NSNull class]]){
		self.logoUrl = dictionary[kBrandLogoUrl];
	}	
	if(![dictionary[kBrandModified] isKindOfClass:[NSNull class]]){
		self.modified = dictionary[kBrandModified];
	}	
	if(![dictionary[kBrandModifyId] isKindOfClass:[NSNull class]]){
		self.modifyId = [dictionary[kBrandModifyId] integerValue];
	}

	if(![dictionary[kBrandName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kBrandName];
	}	
	if(![dictionary[kBrandPicUrl] isKindOfClass:[NSNull class]]){
		self.picUrl = dictionary[kBrandPicUrl];
	}	
	if(![dictionary[kBrandStatus] isKindOfClass:[NSNull class]]){
		self.status = dictionary[kBrandStatus];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kBrandCategoryId] = @(self.categoryId);
	if(self.country != nil){
		dictionary[kBrandCountry] = self.country;
	}
	dictionary[kBrandCreateId] = @(self.createId);
	if(self.created != nil){
		dictionary[kBrandCreated] = self.created;
	}
	if(self.depict != nil){
		dictionary[kBrandDepict] = self.depict;
	}
	dictionary[kBrandIdField] = @(self.idField);
	if(self.logoUrl != nil){
		dictionary[kBrandLogoUrl] = self.logoUrl;
	}
	if(self.modified != nil){
		dictionary[kBrandModified] = self.modified;
	}
	dictionary[kBrandModifyId] = @(self.modifyId);
	if(self.name != nil){
		dictionary[kBrandName] = self.name;
	}
	if(self.picUrl != nil){
		dictionary[kBrandPicUrl] = self.picUrl;
	}
	if(self.status != nil){
		dictionary[kBrandStatus] = self.status;
	}
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
	[aCoder encodeObject:@(self.categoryId) forKey:kBrandCategoryId];	if(self.country != nil){
		[aCoder encodeObject:self.country forKey:kBrandCountry];
	}
	[aCoder encodeObject:@(self.createId) forKey:kBrandCreateId];	if(self.created != nil){
		[aCoder encodeObject:self.created forKey:kBrandCreated];
	}
	if(self.depict != nil){
		[aCoder encodeObject:self.depict forKey:kBrandDepict];
	}
	[aCoder encodeObject:@(self.idField) forKey:kBrandIdField];	if(self.logoUrl != nil){
		[aCoder encodeObject:self.logoUrl forKey:kBrandLogoUrl];
	}
	if(self.modified != nil){
		[aCoder encodeObject:self.modified forKey:kBrandModified];
	}
	[aCoder encodeObject:@(self.modifyId) forKey:kBrandModifyId];	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kBrandName];
	}
	if(self.picUrl != nil){
		[aCoder encodeObject:self.picUrl forKey:kBrandPicUrl];
	}
	if(self.status != nil){
		[aCoder encodeObject:self.status forKey:kBrandStatus];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.categoryId = [[aDecoder decodeObjectForKey:kBrandCategoryId] integerValue];
	self.country = [aDecoder decodeObjectForKey:kBrandCountry];
	self.createId = [[aDecoder decodeObjectForKey:kBrandCreateId] integerValue];
	self.created = [aDecoder decodeObjectForKey:kBrandCreated];
	self.depict = [aDecoder decodeObjectForKey:kBrandDepict];
	self.idField = [[aDecoder decodeObjectForKey:kBrandIdField] integerValue];
	self.logoUrl = [aDecoder decodeObjectForKey:kBrandLogoUrl];
	self.modified = [aDecoder decodeObjectForKey:kBrandModified];
	self.modifyId = [[aDecoder decodeObjectForKey:kBrandModifyId] integerValue];
	self.name = [aDecoder decodeObjectForKey:kBrandName];
	self.picUrl = [aDecoder decodeObjectForKey:kBrandPicUrl];
	self.status = [aDecoder decodeObjectForKey:kBrandStatus];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Brand *copy = [Brand new];

	copy.categoryId = self.categoryId;
	copy.country = [self.country copy];
	copy.createId = self.createId;
	copy.created = [self.created copy];
	copy.depict = [self.depict copy];
	copy.idField = self.idField;
	copy.logoUrl = [self.logoUrl copy];
	copy.modified = [self.modified copy];
	copy.modifyId = self.modifyId;
	copy.name = [self.name copy];
	copy.picUrl = [self.picUrl copy];
	copy.status = [self.status copy];

	return copy;
}
@end
