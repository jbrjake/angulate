//
//  main.m
//  angulate
//
//  Created by Jonathon Rubin on 2/23/14.
//  Copyright (c) 2014 Jonathon Rubin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANGUController.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
#ifndef DEBUG
        if (argc < 3 ) {
            fprintf(stderr, "Please provide at least two points of interest.\n");
            return 1;
        }
#endif
        
        NSMutableArray * points = [[NSMutableArray alloc] init];
#ifdef DEBUG
        [points addObject:@"3400 Central Ave. Saint Petersburg, FL 33711"];
        [points addObject:@"300 E Kennedy Blvd Tampa, FL 33602"];
#else
        for (int i = 1; i < argc; i++) {
            NSString * point = [NSString stringWithUTF8String:argv[i]];
            [points addObject:point];
        }
#endif
        ANGUController * anguController = [[ANGUController alloc] initWithPoints:points];

        anguController = nil;
    }
    return 0;
}

