//
//  YelpDataModel.h
//  myYelpStudy
//
//  Created by Yi Zhu on 5/27/17.
//  Copyright © 2017 Yi Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YelpDataModel:NSObject
@property (nonatomic, copy) NSString *businessId;
@property (nonatomic, assign) NSInteger reviewCount;
@property (nonatomic, copy) NSString *categories;
@property (nonatomic, strong) UIImage *ratingImage;
@property (nonatomic, copy) NSString *displayPhone;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *displayAddress;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray <YelpDataModel *>*)buildDataModelArrayFromDictionaryArray:(NSArray<NSDictionary *> *)dictArray;


@end
