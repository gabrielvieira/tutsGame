//
//  MyScene.m
//  tutInvader
//
//  Created by Gabriel Vieira on 15/04/14.
//  Copyright (c) 2014 Gabriel Vieira. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

#pragma mark class init

-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.bg = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
        self.bg.position = CGPointMake(0, size.width /2);
        [self addChild:self.bg];
       
        self.pode = NO;
        
        
        self.chao = [[SKSpriteNode alloc]initWithColor:[UIColor yellowColor] size:CGSizeMake(2 * size.height, 1)];
        self.chao.position = CGPointMake(0, -1);
        self.chao.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.chao.size];
        self.chao.physicsBody.categoryBitMask = borda;
        self.chao.physicsBody.dynamic = NO;
        [self addChild:self.chao];
        
        
        
        self.spriteTut = [SKSpriteNode spriteNodeWithImageNamed:@"tut"];
        self.spriteTut.size = CGSizeMake(40, 60);
        self.spriteTut.position = CGPointMake(50, 160);
        SKAction *action = [SKAction rotateByAngle:(M_PI/2) * (-1) duration:1];
        [self.spriteTut runAction:action];
        self.spriteTut.physicsBody.dynamic = YES;
        self.spriteTut.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.spriteTut.size.width * 0.5];
        self.spriteTut.physicsBody.categoryBitMask = tartaruga;
        self.spriteTut.physicsBody.contactTestBitMask = tartaruga | borda ;
        self.spriteTut.physicsBody.collisionBitMask = tartaruga | borda ;
       
        [self addChild:self.spriteTut];
        
        
        
        self.physicsWorld.gravity = CGVectorMake(0.0f, 0.0f);
        self.physicsWorld.contactDelegate = self;
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        

    }
    return self;
}

#pragma mark touch events

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

#pragma mark Colision

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"colisao");
}

#pragma mark Main Game Loop

-(void)update:(CFTimeInterval)currentTime {
    
    if (self.pode) {
        
        [self atirar];

        self.pode = NO;
    }
    
    self.bg.position = CGPointMake(self.bg.position.x -1, self.bg.position.y)   ;
    
    if (self.bg.position.x <= -490) {
        self.bg.position = CGPointMake(0, self.bg.position.y)   ;
    }
    
   
    /* Called before each frame is rendered */
}

-(void)atirar
{
    SKSpriteNode *tiro = [[SKSpriteNode alloc]initWithColor:[UIColor yellowColor] size:CGSizeMake(2, 2)];
    tiro.position = self.spriteTut.position;
    tiro.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:tiro.size];
    
    tiro.physicsBody.dynamic = YES;
    [self addChild:tiro];
    [tiro.physicsBody applyForce:CGVectorMake(5.0f, 0.0f)];
}

@end
