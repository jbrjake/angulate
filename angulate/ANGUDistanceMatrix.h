//
//  ANGUDistanceMatrix.h
//  angulate
//
//  Created by Jonathon Rubin on 2/25/14.
//  Copyright (c) 2014 Jonathon Rubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANGUPoint;

@interface ANGUDistanceMatrix : NSObject

- (id)initWithPoints:(NSArray*)points;
- (ANGUPoint*)calculateMidPointForPoints:(NSArray*)points;

@property NSMutableDictionary * matrix;

@end
