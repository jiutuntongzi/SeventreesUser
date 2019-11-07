//
//	CatogeryModel.m
//
//	Create by 志伟 谌 on 7/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CatogeryModel.h"

NSString *const kCatogeryModelCode = @"code";
NSString *const kCatogeryModelData = @"data";
NSString *const kCatogeryModelMsg = @"msg";

@interface CatogeryModel ()
@end
@implementation CatogeryModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kCatogeryModelCode] isKindOfClass:[NSNull class]]){
		self.code = [dictionary[kCatogeryModelCode] integerValue];
	}

	if(dictionary[kCatogeryModelData] != nil && [dictionary[kCatogeryModelData] isKindOfClass:[NSArray class]]){
		NSArray * dataDictionaries = dictionary[kCatogeryModelData];
		NSMutableArray * dataItems = [NSMutableArray array];
		for(NSDictionary * dataDictionary in dataDictionaries){
			CatogeryData * dataItem = [[CatogeryData alloc] initWithDictionary:dataDictionary];
			[dataItems addObject:dataItem];
		}
		self.data = dataItems;
	}
	if(![dictionary[kCatogeryModelMsg] isKindOfClass:[NSNull class]]){
		self.msg = dictionary[kCatogeryModelMsg];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kCatogeryModelCode] = @(self.code);
	if(self.data != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(CatogeryData * dataElement in self.data){
			[dictionaryElements addObject:[dataElement toDictionary]];
		}
		dictionary[kCatogeryModelData] = dictionaryElements;
	}
	if(self.msg != nil){
		dictionary[kCatogeryModelMsg] = self.msg;
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
	[aCoder encodeObject:@(self.code) forKey:kCatogeryModelCode];	if(self.data != nil){
		[aCoder encodeObject:self.data forKey:kCatogeryModelData];
	}
	if(self.msg != nil){
		[aCoder encodeObject:self.msg forKey:kCatogeryModelMsg];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.code = [[aDecoder decodeObjectForKey:kCatogeryModelCode] integerValue];
	self.data = [aDecoder decodeObjectForKey:kCatogeryModelData];
	self.msg = [aDecoder decodeObjectForKey:kCatogeryModelMsg];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	CatogeryModel *copy = [CatogeryModel new];

	copy.code = self.code;
	copy.data = [self.data copy];
	copy.msg = [self.msg copy];

	return copy;
}
@end