//
//  MapTableViewCell.m
//  myYelpStudy
//
//  Created by Yi Zhu on 6/3/17.
//  Copyright © 2017 Yi Zhu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MapTableViewCell.h"
#import "YelpDataModel.h"
#import "YelpAnnotation.h"
@import MapKit;

@interface MapTableViewCell()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end


@implementation MapTableViewCell

- (void)upBasedOnDataModel:(YelpDataModel *)dataModel
{
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(dataModel.latitude, dataModel.longitude);
    NSString *subtitle = [NSString stringWithFormat:@"%@ - %@",dataModel.categories,dataModel.displayAddress];
    YelpAnnotation *annotation = [[YelpAnnotation alloc] initWithCoordinate:loc title:dataModel.name subtitle:subtitle dataModel:dataModel];
    [self.mapView addAnnotation:annotation];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(loc, 500, 500);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    
    [self.mapView setRegion:adjustedRegion animated:YES];
    self.mapView.showsUserLocation = YES;
    [self.mapView setCenterCoordinate:loc];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
