//
//  TrackedLocationsViewController.m
//  Umbrelladar
//
//  Created by Dylan Sturgeon on 7/16/16.
//  Copyright © 2016 dylansturg. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TrackedLocationsViewController.h"
#import "AppDelegate.h"
#import "TrackedLocationsSource.h"
#import "LocationsManager.h"
#import "Location.h"

@interface TrackedLocationsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *locationsTable;

@property (strong, nonatomic) TrackedLocationsSource *locationsSource;
@property (strong, nonatomic) LocationsManager *locationsManager;
@end

@implementation TrackedLocationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSManagedObjectContext *objectContext = ((AppDelegate*) [[UIApplication sharedApplication] delegate]).managedObjectContext;
    self.locationsManager = [[LocationsManager alloc] initWithManagedObjectContext:objectContext];
    self.locationsSource = [[TrackedLocationsSource alloc] initWithLocationsManager:self.locationsManager];
    
    self.locationsTable.dataSource = self.locationsSource;
    self.locationsTable.delegate = self.locationsSource;
    
    self.locationsTable.allowsSelectionDuringEditing = YES;
    self.locationsTable.allowsMultipleSelectionDuringEditing = NO;
    
    self.locationsTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (IBAction)addLocationTapped:(id)sender {
    Location *location = [self.locationsManager createNewLocation];
    location.name = @"Current Location";
    location.latitude = 0;
    location.longitude = 0;
    
    [self.locationsManager saveLocation:location];
    
    [self.locationsSource refreshLocations];
    
    int lastLocation = [self.locationsSource locationsCount];
    
    NSIndexPath *addedIndexPath = [NSIndexPath indexPathForRow:lastLocation - 1 inSection:0];
    
    [self.locationsTable beginUpdates];
    [self.locationsTable insertRowsAtIndexPaths:@[addedIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.locationsTable endUpdates];
}

@end
