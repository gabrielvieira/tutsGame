//
//  Timer.h
//  tutInvader
//
//  Created by GABRIEL VIEIRA on 22/04/14.
//  Copyright (c) 2014 Gabriel Vieira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timer : NSObject {
    NSDate *start;
    NSDate *end;
}

- (void) startTimer;
- (void) stopTimer;
- (double) timeElapsedInSeconds;
- (double) timeElapsedInMilliseconds;
- (double) timeElapsedInMinutes;

@end
