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


#import "seeUthereAppDelegate.h"

@implementation seeUthereAppDelegate

@synthesize window;
@synthesize mapView;
@synthesize toolbar;
@synthesize locateMeButton;
@synthesize sendButton;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
	// Create objects
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	mapView = [[MapView alloc] initWithFrame:CGRectMake(0,20,320,416)];
	toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,436,320,44)];
	locateMeButton = [[UIBarButtonItem alloc] initWithTitle:@"Locate me!" style:UIBarButtonItemStyleBordered target:self action:@selector(locateMe:)];
	sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(send:)];
	
	UIWebView *mapAsBase = (UIWebView *) (mapView.mMapWebView);
	mapAsBase.delegate = self;
	
	locateMeButton.width = 150;
	sendButton.width = 150;
	
	// Set up view tree
	[toolbar setItems:[NSArray arrayWithObjects:locateMeButton,sendButton,nil]];
		
	[window addSubview:mapView];
	[window addSubview:toolbar];
	// Show window
	[window makeKeyAndVisible];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[mapView.mMapWebView moveByDx:1 dY:1];
	UIWebView *mapAsBase = (UIWebView *) (mapView.mMapWebView);
	mapAsBase.delegate = nil;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	printf("New location: %f,%f - %f\n",newLocation.coordinate.latitude,newLocation.coordinate.longitude,newLocation.horizontalAccuracy);
	BOOL stopLocating = YES;
	if(newLocation.horizontalAccuracy < 500) {
		[mapView.mMapWebView setZoom:20];
	} else if(newLocation.horizontalAccuracy < 5000) {
		[mapView.mMapWebView setZoom:18];
	} else if(newLocation.horizontalAccuracy < 50000) {
		[mapView.mMapWebView setZoom:15];
	} else {
		[mapView.mMapWebView setZoom:3];
		stopLocating=NO;
	}
	[mapView.mMapWebView setCenterWithLatLng:GLatLngMake(newLocation.coordinate.latitude,newLocation.coordinate.longitude)];

	locateMeButton.title=@"Locate me!";
	locateMeButton.enabled=YES;
	if (stopLocating) {
		[locationManager stopUpdatingLocation];
	}
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Localization failed!" message:[error localizedDescription] delegate: nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
	[alert show];
	[alert release];
	locateMeButton.title=@"Locate me!";
	locateMeButton.enabled=YES;
	[locationManager stopUpdatingLocation];
}
- (IBAction)locateMe:(id)sender {
	locateMeButton.title=@"Please wait";
	locateMeButton.enabled=NO;
	[locationManager startUpdatingLocation];
	NSLog(@"Locate");
}
- (IBAction)send:(id)sender {
	NSLog(@"Send");
	GLatLng coord = [mapView.mMapWebView getCenterLatLng];
	NSString *mapUrl = [NSString stringWithFormat:@"mailto:?subject=Location&body=http://maps.google.com?ll=%f,%f",coord.lat,coord.lng];
	NSLog(mapUrl);
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:mapUrl]];
}
- (void)dealloc {
	[mapView release];
	[toolbar release];
	[window release];
	[super dealloc];
}

@end
