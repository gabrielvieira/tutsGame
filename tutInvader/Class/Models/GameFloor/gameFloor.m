//
//  gameFloor.m
//  tutInvader
//
//  Created by GABRIEL VIEIRA on 17/04/14.
//  Copyright (c) 2014 Gabriel Vieira. All rights reserved.
//

#import "gameFloor.h"
#import "Define.h"

@implementation gameFloor

-(id)initWithSize : (CGSize)size
{
    self = [super init];
    
    if (self) {
        
        self.color = [UIColor yellowColor];
        self.size = size;
        self.position = CGPointMake(size.width / 2, -1);
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.categoryBitMask = borda;
        self.physicsBody.dynamic = NO;
    }
    
    return self;
}

@end
