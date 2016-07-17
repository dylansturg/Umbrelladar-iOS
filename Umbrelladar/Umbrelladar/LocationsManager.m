//
//  LocationsManager.m
//  Umbrelladar
//
//  Created by Dylan Sturgeon on 7/16/16.
//  Copyright © 2016 dylansturg. All rights reserved.
//

#import "LocationsManager.h"

@interface LocationsManager()
@property (strong, nonatomic) NSManagedObjectContext *objectContext;
@end

@implementation LocationsManager

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    self = [super init];
    if(self){
        self.objectContext = managedObjectContext;
    }
    return self;
}

- (NSArray<Location *> *)fetchStoredLocations{
    
    NSFetchRequest *locationsFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Location"];
    NSError *fetchError;
    
    NSArray *fetchResults = [self.objectContext executeFetchRequest:locationsFetchRequest error:&fetchError];
    
    if(fetchError){
        NSLog(@"Error while fetching locations: %@", fetchError);
        return nil;
    }
    
    return (NSArray<Location *> *)fetchResults;
}

- (Location*)createNewLocation{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.objectContext];
    Location *location = [[Location alloc] initWithEntity:entity insertIntoManagedObjectContext:self.objectContext];
    return location;
}

- (void)saveLocation:(Location *)location{
    [self.objectContext insertObject:location];
    
    NSError *saveError;
    [self.objectContext save:&saveError];
    
    if(saveError){
        NSLog(@"Error while saving new location: %@", saveError);
    }
}

- (void)deleteLocation:(Location *)location{
    [self.objectContext deleteObject:location];
    
    NSError *deleteError;
    [self.objectContext save:&deleteError];
    
    if(deleteError){
        NSLog(@"Error while deleting location: %@", deleteError);
    }
}

@end
