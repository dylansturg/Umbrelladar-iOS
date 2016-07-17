//
//  TrackedLocationsSource.h
//  Umbrelladar
//
//  Created by Dylan Sturgeon on 7/16/16.
//  Copyright © 2016 dylansturg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LocationsManager.h"

@interface TrackedLocationsSource : NSObject<UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithLocationsManager:(LocationsManager *) locationsManager;

- (void)refreshLocations;

- (int) locationsCount;

@end
