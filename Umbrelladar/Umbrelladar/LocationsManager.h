//
//  LocationsManager.h
//  Umbrelladar
//
//  Created by Dylan Sturgeon on 7/16/16.
//  Copyright © 2016 dylansturg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Location.h"

@interface LocationsManager : NSObject

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

- (NSArray<Location *> *)fetchStoredLocations;

- (Location *)createNewLocation;

- (void)deleteLocation:(Location *)location;

- (void)saveLocation:(Location *) location;

@end
