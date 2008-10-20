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


#import "CrossView.h"


@implementation CrossView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.opaque=NO;
		self.userInteractionEnabled=NO;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	NSLog(@"Painting!!!");
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(context, 5);
	CGContextSetStrokeColorWithColor(context, [[[UIColor alloc] initWithRed:0.2 green:0.3 blue: 0.5 alpha:0.5] CGColor]);
	//Horizontal
	CGContextBeginPath(context);
	CGContextMoveToPoint(context,self.center.x-self.bounds.size.width/4,self.bounds.origin.y+self.bounds.size.height/2);
	CGContextAddLineToPoint(context,self.center.x+self.bounds.size.width/4,self.bounds.origin.y+self.bounds.size.height/2);
	CGContextClosePath(context);
	CGContextStrokePath(context);
	//Vertical
	CGContextBeginPath(context);
	CGContextMoveToPoint(context,self.bounds.origin.x+self.bounds.size.width/2,self.center.y-self.bounds.size.width/4);
	CGContextAddLineToPoint(context,self.bounds.origin.x+self.bounds.size.width/2,self.center.y+self.bounds.size.width/4);
	CGContextClosePath(context);
	CGContextStrokePath(context);
	
	//Circle
	CGRect circleBounds;
	circleBounds.origin.x = self.center.x-self.bounds.size.width/4;
	circleBounds.origin.y = self.center.y-self.bounds.size.width/4;
	circleBounds.size.width = self.bounds.size.width/2;
	circleBounds.size.height = self.bounds.size.width/2;
	
	CGContextSetStrokeColorWithColor(context, [[[UIColor alloc] initWithRed:0.0 green:0.3 blue: 0.8 alpha:0.2] CGColor]);
	CGContextBeginPath(context);
	CGContextAddEllipseInRect(context,circleBounds);
	CGContextStrokePath(context);
}


- (void)dealloc {
    [super dealloc];
}


@end
