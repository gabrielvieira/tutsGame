//
//  gameTut.m
//  tutInvader
//
//  Created by GABRIEL VIEIRA on 17/04/14.
//  Copyright (c) 2014 Gabriel Vieira. All rights reserved.
//

#import "gameTut.h"
#import "Define.h"

@implementation gameTut

-(id)init
{
    
    self = [super init];
    if (self) {
        
        self = (gameTut *)[SKSpriteNode spriteNodeWithImageNamed:@"tut"];
        self.size = CGSizeMake(50, 80);
        self.position = CGPointMake(150, 160);
        self.physicsBody.dynamic = YES;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
        self.physicsBody.categoryBitMask = tartaruga;
        self.physicsBody.contactTestBitMask = tartaruga | borda | inimigo;
        self.physicsBody.collisionBitMask = tartaruga | borda | inimigo;
        self.zPosition = 100;
        self.anchorPoint = CGPointMake(0.5, 0.5);
    }
    return self;

}

@end
