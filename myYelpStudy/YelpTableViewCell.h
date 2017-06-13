//
//  YelpTableViewCell.h
//  myYelpStudy
//
//  Created by Yi Zhu on 5/28/17.
//  Copyright © 2017 Yi Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpDataModel.h"
@interface YelpTableViewCell : UITableViewCell

- (void)upBasedOnDataModel:(YelpDataModel *)dataModel;

@end
