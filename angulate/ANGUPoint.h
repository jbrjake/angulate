//
//  ANGUPoint.h
//  angulate
//
//  Created by Jonathon Rubin on 2/23/14.
//  Copyright (c) 2014 Jonathon Rubin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ANGUPoint : NSObject

- (id)initWithAddress:(NSString*)address;

@property CLLocationCoordinate2D latlong;
@property NSString * address;

@end
