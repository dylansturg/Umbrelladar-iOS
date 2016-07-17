//
//  TrackedLocationCell.m
//  Umbrelladar
//
//  Created by Dylan Sturgeon on 7/16/16.
//  Copyright © 2016 dylansturg. All rights reserved.
//

#import "TrackedLocationCell.h"

@interface TrackedLocationCell()
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation TrackedLocationCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
    if(self.location){
        self.locationLabel.text = self.location.name;
    }
}

- (IBAction)mapButtonTapped:(id)sender {
    NSLog(@"map button tapped for %@", self.location.name);
}

- (void)setLocation:(Location *)location{
    _location = location;
    
    if(self.locationLabel){
        self.locationLabel.text = location.name;
    }
}

@end
