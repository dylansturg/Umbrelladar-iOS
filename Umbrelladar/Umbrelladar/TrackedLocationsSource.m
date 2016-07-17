//
//  TrackedLocationsSource.m
//  Umbrelladar
//
//  Created by Dylan Sturgeon on 7/16/16.
//  Copyright © 2016 dylansturg. All rights reserved.
//

#import "TrackedLocationsSource.h"
#import "Location.h"
#import "TrackedLocationCell.h"

@interface TrackedLocationsSource()
@property (strong, nonatomic) NSArray<Location *> *locations;
@property (strong, nonatomic) LocationsManager *locationsManager;
@end

@implementation TrackedLocationsSource

- (instancetype)initWithLocationsManager:(LocationsManager *)locationsManager{
    self = [super init];
    if(self){
        self.locationsManager = locationsManager;
    }
    return self;
}

- (NSInteger) tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger) section{
    return self.locations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TrackedLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrackedLocationCell"];
    
    cell.location = [self.locations objectAtIndex:indexPath.row];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:89/255.0f green:59/255.0f blue:153/255.0f alpha:1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        Location *deletedLocation = [self.locations objectAtIndex:indexPath.row];
        if(deletedLocation){
            [self.locationsManager deleteLocation:deletedLocation];
            [self refreshLocations];
            
            [tableView beginUpdates];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView endUpdates];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)refreshLocations{
    _locations = [self.locationsManager fetchStoredLocations];
}

- (int)locationsCount{
    return (int)self.locations.count;
}

- (NSArray<Location *> *)locations {
    if(_locations != nil){
        return _locations;
    }
    
    [self refreshLocations];
    return _locations;
}

@end
