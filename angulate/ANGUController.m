//
//  ANGUController.m
//  angulate
//
//  Created by Jonathon Rubin on 2/23/14.
//  Copyright (c) 2014 Jonathon Rubin. All rights reserved.
//

#import "ANGUController.h"
#import "ANGUPoint.h"

@implementation ANGUController

- (id)initWithPoints:(NSMutableArray*) points;
{
    self = [super init];
    if (self) {
        _points = [[NSMutableArray alloc] init];
        for (NSString * address in points) {
            ANGUPoint * point = [[ANGUPoint alloc] initWithAddress:address];
            [self.points addObject:point];
        }
        NSLog(@"Points: %@", self.points);
        [self calculateMidPoint];
    }
    return self;
}

// http://stackoverflow.com/a/18623672
- (ANGUPoint*)calculateMidPoint {
    double x = 0;
    double y = 0;
    double z = 0;
    
    for (ANGUPoint * point in self.points) {
        double lat = point.latlong.latitude * M_PI / 180;
        double lon = point.latlong.longitude * M_PI / 180;
        
        double a = cos(lat) * cos(lon);
        double b = cos(lat) * sin(lon);
        double c= sin(lat);
        
        x += a;
        y += b;
        z += c;
    }
    
    x = x / self.points.count;
    y = y / self.points.count;
    z = z / self.points.count;
    
    double lon = atan2(y, x);
    double hyp = sqrt(x * x + y * y);
    double lat = atan2(z, hyp);
    
    double mid_lat = lat * 180 / M_PI;
    double mid_lon = lon * 180 / M_PI;
    
    NSLog(@"Midpoint is %f, %f", mid_lat, mid_lon);
    
    ANGUPoint * midPoint = [[ANGUPoint alloc] initWithAddress:[NSString stringWithFormat:@"%f,%f", mid_lat, mid_lon]];
    return midPoint;
}

@end
