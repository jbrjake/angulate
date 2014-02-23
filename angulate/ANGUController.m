//
//  ANGUController.m
//  angulate
//
//  Created by Jonathon Rubin on 2/23/14.
//  Copyright (c) 2014 Jonathon Rubin. All rights reserved.
//

#import "ANGUController.h"

@implementation ANGUController

- (id)initWithPoints:(NSMutableArray*) points;
{
    self = [super init];
    if (self) {
        _points = [[NSMutableArray alloc] initWithArray:points];
        
    }
    return self;
}

- (void)calculateMidPoint {
    
}

@end
