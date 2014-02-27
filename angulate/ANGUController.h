//
//  ANGUController.h
//  angulate
//
//  Created by Jonathon Rubin on 2/23/14.
//  Copyright (c) 2014 Jonathon Rubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANGUPoint;

@interface ANGUController : NSObject

- (id)initWithPoints:(NSMutableArray*) points;

@property NSMutableArray * points;

@end
