//
//  DetailViewHeaderTableViewCell.h
//  myYelpStudy
//
//  Created by Yi Zhu on 6/3/17.
//  Copyright © 2017 Yi Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpDataModel.h"

@interface DetailViewHeaderTableViewCell : UITableViewCell
-(void)upBasedOnDataModel:(YelpDataModel *)dataModel;
@end
