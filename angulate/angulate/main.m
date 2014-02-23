//
//  main.m
//  angulate
//
//  Created by Jonathon Rubin on 2/23/14.
//  Copyright (c) 2014 Jonathon Rubin. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        if (argc < 3 ) {
            fprintf(stderr, "Please provide at least two points of interest.\n");
            return 1;
        }
        else {
            NSMutableArray * points = [[NSMutableArray alloc] init];
            for (int i = 1; i < argc; i++) {
                NSString * point = [NSString stringWithUTF8String:argv[i]];
                [points addObject:point];
            }
            points = nil;
        }
    }
    return 0;
}

