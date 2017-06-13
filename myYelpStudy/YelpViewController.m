//
//  ViewController.m
//  myYelpStudy
//
//  Created by Yi Zhu on 5/27/17.
//  Copyright © 2017 Yi Zhu. All rights reserved.
//

#import "YelpViewController.h"
#import "YelpDataModel.h"
#import "YelpNetworking.h"
#import "YelpTableViewCell.h"
#import "YelpDataStore.h"
#import "DetailYelpViewController.h"


@interface YelpViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,CLLocationManagerDelegate>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UISearchBar *searchBar;
@property (nonatomic, copy) NSArray <YelpDataModel *> *dataModels;
@property (nonatomic) CLLocation *userLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end


@implementation YelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YelpTableViewCell" bundle:nil] forCellReuseIdentifier:@"YelpViewCell"];
    
    [self.view addSubview:self.tableView];
    self.userLocation = [[CLLocation alloc] initWithLatitude:37.3263625 longitude:-122.027210];
    
    [[YelpNetworking sharedInstance] fetchRestaurantsBasedOnLocation:self.userLocation term:@"restaurant" completionBlock:^(NSArray<YelpDataModel *> *dataModelArray) {
        self.dataModels = dataModelArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStylePlain target:self action:@selector(didTapSettings)];
    
    //     Setup search bar
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.tintColor = [UIColor lightGrayColor];
    self.navigationItem.titleView = self.searchBar;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

-(void) didTapSettings
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark bang zhu zhao code
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YelpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YelpViewCell"];
    [cell upBasedOnDataModel:self.dataModels[indexPath.row]];
    return cell;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataModels count];
}


#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
    // fake location
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:37.3263625 longitude:-122.027210];
    
    [[YelpNetworking sharedInstance] fetchRestaurantsBasedOnLocation:loc term:searchBar.text completionBlock:^(NSArray<YelpDataModel *> *dataModelArray) {
        self.dataModels = dataModelArray;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

// Reset search bar state after cancel button clicked
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
}

#pragma mark - Location manager methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops..."
                                                                   message:@"Failed to Get Location"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    self.userLocation = currentLocation;
    [[YelpDataStore sharedInstance] setUserLocation:currentLocation];
    
    [manager stopUpdatingLocation];
    NSLog(@"current location %lf %lf", self.userLocation.coordinate.latitude, self.userLocation.coordinate.longitude);
    [[YelpNetworking sharedInstance] fetchRestaurantsBasedOnLocation:currentLocation term:@"restaurant" completionBlock:^(NSArray<YelpDataModel *> *dataModelArray) {
        self.dataModels = dataModelArray;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailYelpViewController
    *detailVC = [[DetailYelpViewController
                  alloc] initWithDataModel:self.dataModels[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
