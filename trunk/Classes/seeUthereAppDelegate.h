//  Copyright 2008 Juan González (opsidao). All rights reserved.
//
//  This file is part of seeUthere.

//  seeUthere is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.

//  seeUthere is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.

//  You should have received a copy of the GNU General Public License
//  along with seeUthere.  If not, see <http://www.gnu.org/licenses/>.


#import "MapView.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface seeUthereAppDelegate : NSObject <UIApplicationDelegate,CLLocationManagerDelegate> {
    UIWindow *window;
    MapView *mapView;
	UIToolbar *toolbar;
	UIBarButtonItem *locateMeButton;
	UIBarButtonItem *sendButton;
	CLLocationManager *locationManager;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) MapView *mapView;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) UIBarButtonItem *locateMeButton;
@property (nonatomic, retain) UIBarButtonItem *sendButton;

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;

- (IBAction)locateMe:(id)sender;
- (IBAction)send:(id)sender;

@end
