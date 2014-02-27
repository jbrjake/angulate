//
//  ANGUDistanceMatrix.m
//  angulate
//
//  Created by Jonathon Rubin on 2/25/14.
//  Copyright (c) 2014 Jonathon Rubin. All rights reserved.
//

#import "ANGUDistanceMatrix.h"
#import "ANGUPoint.h"

@implementation ANGUDistanceMatrix

- (id)initWithPoints:(NSArray*)points {
    self = [super init];
    if (self) {
        _matrix = [[NSMutableDictionary alloc] init];
        
        NSMutableString * distanceQuery = [[NSMutableString alloc] init];
        [distanceQuery appendString:@"https://maps.googleapis.com/maps/api/distancematrix/json?"];
        [distanceQuery appendString:@"origins="];
        for (ANGUPoint * point in points) {
            [distanceQuery appendFormat:@"%@|", point.address];
        }
    
        ANGUPoint * midPoint = [self calculateMidPointForPoints:points];
        [distanceQuery appendString:@"&destinations="];
        [distanceQuery appendFormat:@"%f,%f|", midPoint.latlong.latitude, midPoint.latlong.longitude];
        [distanceQuery appendFormat:@"%f,%f|", midPoint.latlong.latitude-.1, midPoint.latlong.longitude-.1];
        [distanceQuery appendFormat:@"%f,%f|", midPoint.latlong.latitude-.1, midPoint.latlong.longitude+.1];
        [distanceQuery appendFormat:@"%f,%f|", midPoint.latlong.latitude+.1, midPoint.latlong.longitude+.1];
        [distanceQuery appendFormat:@"%f,%f|", midPoint.latlong.latitude+.1, midPoint.latlong.longitude-.1];
        [distanceQuery appendString:@"&sensor=false"];
        NSLog(@"Crafted URL: %@", distanceQuery);
        NSURL * distanceQueryURL = [[NSURL alloc] initWithString:[distanceQuery stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"Sending query: %@", distanceQueryURL);
        NSURLRequest * distanceQueryRequest = [NSURLRequest requestWithURL:distanceQueryURL];
        NSURLResponse * distanceQueryResponse = nil;
        NSError * error = nil;
        NSData * response = [NSURLConnection sendSynchronousRequest:distanceQueryRequest returningResponse:&distanceQueryResponse error:&error];
        
        NSLog(@"Response: %@", distanceQueryResponse);
        NSLog(@"Error: %@", error ? error : @"none");
        id jsonResponse = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
        if ([jsonResponse isKindOfClass:[NSDictionary class]]) {
            [self.matrix addEntriesFromDictionary:jsonResponse];
            NSLog(@"%@", self.matrix);
        }
    }
    return self;
}

// http://stackoverflow.com/a/18623672
- (ANGUPoint*)calculateMidPointForPoints:(NSArray*)points {
    double x = 0;
    double y = 0;
    double z = 0;
    
    for (ANGUPoint * point in points) {
        double lat = point.latlong.latitude * M_PI / 180;
        double lon = point.latlong.longitude * M_PI / 180;
        
        double a = cos(lat) * cos(lon);
        double b = cos(lat) * sin(lon);
        double c= sin(lat);
        
        x += a;
        y += b;
        z += c;
    }
    
    x = x / points.count;
    y = y / points.count;
    z = z / points.count;
    
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
