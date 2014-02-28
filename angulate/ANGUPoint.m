//
//  ANGUPoint.m
//  angulate
//
//  Created by Jonathon Rubin on 2/23/14.
//  Copyright (c) 2014 Jonathon Rubin. All rights reserved.
//

#import "ANGUPoint.h"
#import <AddressBook/AddressBook.h>

@implementation ANGUPoint

- (id)initWithAddress:(NSString*)address {

    self = [super init];
    if (self) {
        _address = [[NSString alloc] initWithString:address];
        CLGeocoder * geocoder = [[CLGeocoder alloc] init];
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [geocoder geocodeAddressString:self.address completionHandler:^(NSArray *placemarks, NSError *error)
         {
             if (error){
                 NSLog(@"Geocode failed with error: %@", error);
                 return;
             }
             
             CLPlacemark * placemark = placemarks[0];
             CLLocation * location = placemark.location;
             self.latlong = location.coordinate;
             
             dispatch_semaphore_signal(sema);
         }];

        // CLGeocoder runs asynch on the main thread, so we need to wait until it completes
        // Otherwise, the CLI app returns before the geocoding is complete
        while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW)) {
            [[NSRunLoop currentRunLoop]
             runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0]];
        }        
    }
    return self;
}

- (id)initWithLat:(CLLocationDegrees)lat andLon:(CLLocationDegrees)lon {
    self = [super init];
    if (self) {
        CLGeocoder * geocoder = [[CLGeocoder alloc] init];
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        CLLocation * location = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            if (error){
                NSLog(@"Reverse geocode failed with error: %@", error);
                return;
            }
            
            CLPlacemark * placemark = placemarks[0];
            CLLocation * location = placemark.location;
            self.latlong = location.coordinate;
            
            if (![placemark.addressDictionary objectForKey:@"Street"]) {
                // No good address, just use the coordinates
                _address = [[NSString alloc] initWithFormat:@"%f,%f", lat, lon];
            }
            else {
                _address = [[NSString alloc] initWithFormat:@"%@", [[[ABAddressBook sharedAddressBook] formattedAddressFromDictionary:placemark.addressDictionary] string]];
            }
            dispatch_semaphore_signal(sema);

        }];

        // CLGeocoder runs asynch on the main thread, so we need to wait until it completes
        // Otherwise, the CLI app returns before the geocoding is complete
        while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW)) {
            [[NSRunLoop currentRunLoop]
             runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0]];
        }
    }
    
    return self;
}

- (NSMutableString *)description {
    NSMutableString * ret = [[NSMutableString alloc] initWithFormat:@"Address: %@, Lat: %f, Long: %f", self.address, self.latlong.latitude, self.latlong.longitude];
    
    return ret;
}
@end
