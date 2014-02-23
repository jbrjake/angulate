//
//  ANGUController.h
//  angulate
//
//  Created by Jonathon Rubin on 2/23/14.
//  Copyright (c) 2014 Jonathon Rubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANGUController : NSObject

- (id)initWithPoints:(NSMutableArray*) points;
- (void)calculateMidPoint;

@property NSMutableArray * points;

@end
