//
//  MapTableViewCell.h
//  myYelpStudy
//
//  Created by Yi Zhu on 6/3/17.
//  Copyright © 2017 Yi Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpDataModel.h"
#import "YelpAnnotation.h"
@import MapKit;


@interface MapTableViewCell : UITableViewCell

- (void)upBasedOnDataModel:(YelpDataModel *)dataModel;

@end
