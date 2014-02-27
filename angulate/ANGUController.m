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

- (id)initWithPoints:(NSMutableArray*)points;
{
    self = [super init];
    if (self) {
        _points = [[NSMutableArray alloc] init];
        for (NSString * address in points) {
            ANGUPoint * point = [[ANGUPoint alloc] initWithAddress:address];
            [self.points addObject:point];
        }
        NSLog(@"Points: %@", self.points);
        
    }
    return self;
}

@end
