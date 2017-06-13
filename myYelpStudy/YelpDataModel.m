//
//  YelpDataModel.m
//  myYelpStudy
//
//  Created by Yi Zhu on 5/27/17.
//  Copyright © 2017 Yi Zhu. All rights reserved.
//


#import "YelpDataModel.h"

@implementation YelpDataModel
+ (NSArray <YelpDataModel *>*)buildDataModelArrayFromDictionaryArray:(NSArray<NSDictionary *> *)dictArray
{
    NSMutableArray<YelpDataModel *> *dataModelArray = [NSMutableArray new];
    for (NSDictionary *subDict in dictArray) {
        YelpDataModel *dataModel = [[YelpDataModel alloc] initWithDictionary:subDict];
        [dataModelArray addObject:dataModel];
    }
    return [dataModelArray copy];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.businessId = dictionary[@"id"];
        self.reviewCount = [dictionary[@"review_count"] integerValue];
        NSArray *categories = dictionary[@"categories"];
        NSMutableArray *categoryNames = [NSMutableArray array];
        [categories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [categoryNames addObject:obj[@"title"]];
        }];
        self.categories = [categoryNames componentsJoinedByString:@", "];
        self.ratingImage = [UIImage imageNamed:[self convertToRatingImageName:[dictionary[@"rating"] doubleValue]]];
        self.displayPhone = dictionary[@"display_phone"];
        self.imageUrl = dictionary[@"image_url"];
        NSArray *displayAddresses = [dictionary valueForKeyPath:@"location.display_address"];
        self.displayAddress =  [displayAddresses componentsJoinedByString:@", "];
        self.price = dictionary[@"price"];
        self.latitude = [[dictionary valueForKeyPath:@"coordinates.latitude"]  doubleValue];
        self.longitude = [[dictionary valueForKeyPath:@"coordinates.longitude"]  doubleValue];
        float meterToMile = 0.00062;
        self.distance = [dictionary[@"distance"] integerValue] * meterToMile;
        self.name = dictionary[@"name"];
    }
    return self;
}

- (NSString *)convertToRatingImageName:(double)rating
{
    if (rating == 0){
        return @"large_0";
    } else if (rating == 1){
        return @"large_1";
    } else if (rating == 1.5){
        return @"large_1_half";
    } else if (rating == 2){
        return @"large_2";
    } else if (rating == 2.5){
        return @"large_2_half";
    } else if (rating == 3){
        return @"large_3";
    } else if (rating == 3.5){
        return @"large_3_half";
    } else if (rating == 4){
        return @"large_4";
    } else if (rating == 4.5){
        return @"large_4_half";
    } else if (rating == 5){
        return @"large_5";
    } else {
        return @"";
    }
}
@end
