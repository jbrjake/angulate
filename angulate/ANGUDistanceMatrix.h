//
//  ANGUDistanceMatrix.h
//  angulate
//
//  Created by Jonathon Rubin on 2/25/14.
//  Copyright (c) 2014 Jonathon Rubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANGUDistanceMatrix : NSMutableDictionary

- (id)initWithCoordinates:(NSArray*)coordinates;
- (ANGUPoint*)calculateMidPointForPoints:(NSArray*)points;

@end
