//
//  MyScene.m
//  tutInvader
//
//  Created by Gabriel Vieira on 15/04/14.
//  Copyright (c) 2014 Gabriel Vieira. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.pode = NO;
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        self.spriteTut = [SKSpriteNode spriteNodeWithImageNamed:@"tut"];
        self.spriteTut.size = CGSizeMake(40, 60);
        self.spriteTut.position = CGPointMake(100, 300);
        SKAction *action = [SKAction rotateByAngle:(M_PI/2) * (-1) duration:1];
        [self.spriteTut runAction:action];
        
        [self addChild:self.spriteTut];
        self.spriteTut.physicsBody.dynamic = YES;
        self.spriteTut.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.spriteTut.size.width * 0.5];
        
        self.physicsWorld.gravity = CGVectorMake(0.0f, -1.0f);

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInNode:self] ;
    
   
        if (touchPoint.x > self.size.width /2) {
           self.pode = YES;
        }
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.pode = NO;
}

-(void)update:(CFTimeInterval)currentTime {
    
    if (self.pode) {
         self.spriteTut.position = CGPointMake(self.spriteTut.position.x +2, self.spriteTut.position.y);
    }
  
    /* Called before each frame is rendered */
}

@end
