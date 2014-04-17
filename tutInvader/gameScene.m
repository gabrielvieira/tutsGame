//
//  MyScene.m
//  tutInvader
//
//  Created by Gabriel Vieira on 15/04/14.
//  Copyright (c) 2014 Gabriel Vieira. All rights reserved.
//

#import "gameScene.h"

@implementation gameScene

#pragma mark class init

-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.bg2 = [SKSpriteNode spriteNodeWithImageNamed:@"newbg2"];
        self.bg2.position = CGPointMake(568*2.5, size.width /2);
         [self addChild:self.bg2];
        
        
        self.bg1 = [SKSpriteNode spriteNodeWithImageNamed:@"newbg1"];
        self.bg1.position = CGPointMake(size.height /2, size.width /2);
        [self addChild:self.bg1];
       
        self.pode = NO;
        
        
        self.chao = [[SKSpriteNode alloc]initWithColor:[UIColor yellowColor] size:CGSizeMake(2 * size.height, 1)];
        self.chao.position = CGPointMake(0, -1);
        self.chao.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.chao.size];
        self.chao.physicsBody.categoryBitMask = borda;
        self.chao.physicsBody.dynamic = NO;
        [self addChild:self.chao];
        
        
        
        
        self.aguaFrame = [self loadSpriteSheetFromImageWithName:@"jelly" withNumberOfSprites:12 withNumberOfRows:4 withNumberOfSpritesPerRow:3];
        
        
        self.spriteTut = [SKSpriteNode spriteNodeWithImageNamed:@"tut"];
        
       
        
        self.spriteTut = [SKSpriteNode spriteNodeWithImageNamed:@"tut"];
        self.spriteTut.size = CGSizeMake(40, 60);
        self.spriteTut.position = CGPointMake(50, 160);
        SKAction *action = [SKAction rotateByAngle:(M_PI/2) * (-1) duration:1];
        [self.spriteTut runAction:action];
        self.spriteTut.physicsBody.dynamic = YES;
        self.spriteTut.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.spriteTut.size.width/2];
        self.spriteTut.physicsBody.categoryBitMask = tartaruga;
        self.spriteTut.physicsBody.contactTestBitMask = tartaruga | borda ;
        self.spriteTut.physicsBody.collisionBitMask = tartaruga | borda ;
       
        [self addChild:self.spriteTut];
        SKAction *cu = [SKAction animateWithTextures:self.aguaFrame timePerFrame:0.15f];
        [self.spriteTut runAction:[SKAction repeatActionForever:cu]];
        self.spriteTut.anchorPoint = CGPointMake(0.5, 0.5);
        
        
        self.physicsWorld.gravity = CGVectorMake(0.0f, 0.0f);
        self.physicsWorld.contactDelegate = self;
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        self.pointsPerSecondSpeed = 70;
        self.podeMoverBg1 = YES;
        self.podeMoverBg2 = NO;
        
        
        
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
    
    if (self.bg1.position.x <= -270) {
        self.podeMoverBg2 = YES;
    }
    
    if ((self.bg2.position.x < 852 && self.bg2.position.x > 840 ) && self.podeMoverBg2 == YES) {
        self.podeMoverBg1 = NO;
        self.bg1.position = CGPointMake(568*2.5, 160);
    }
    
    if (self.bg2.position.x <= -270) {
        self.podeMoverBg1 = YES;
    }
    
    if ((self.bg1.position.x < 852 && self.bg1.position.x > 840 ) && self.podeMoverBg1 == YES) {
        self.podeMoverBg2 = NO;
        self.bg2.position = CGPointMake(568*2.5, 160);
    }
   
    
    

    //To compute velocity we need delta time to multiply by points per second
    if (_lastUpdateTime) {
        _deltaTime = currentTime - _lastUpdateTime;
    } else {
        _deltaTime = 0;
    }
    _lastUpdateTime = currentTime;
    
    
    
    CGPoint bgVelocity = CGPointMake(-_pointsPerSecondSpeed, 0.0);
    CGPoint amtToMove = CGPointMake(bgVelocity.x * _deltaTime, bgVelocity.y * _deltaTime);
    
    
    
    if (self.podeMoverBg1) {
        self.bg1.position = CGPointMake(self.bg1.position.x+amtToMove.x, self.bg1.position.y);
    }
    
    if (self.podeMoverBg2) {
         self.bg2.position = CGPointMake(self.bg2.position.x+amtToMove.x, self.bg2.position.y);
    }
    

    }

-(void)atirar
{
    SKSpriteNode *tiro = [[SKSpriteNode alloc]initWithColor:[UIColor yellowColor] size:CGSizeMake(2, 2)];
    tiro.position = CGPointMake(self.spriteTut.position.x + 30, self.spriteTut.position.y);
    tiro.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:tiro.size];
    
    tiro.physicsBody.dynamic = YES;
    [self addChild:tiro];
    [tiro.physicsBody applyForce:CGVectorMake(5.0f, 0.0f)];
}

-(NSMutableArray*)loadSpriteSheetFromImageWithName:(NSString*)name withNumberOfSprites:(int)numSprites withNumberOfRows:(int)numRows withNumberOfSpritesPerRow:(int)numSpritesPerRow {
    
    NSMutableArray* animationSheet = [NSMutableArray array];
    
    SKTexture* mainTexture = [SKTexture textureWithImageNamed:name];
    
    for(int j = numRows-1; j >= 0; j--) {
        for(int i = 0; i < numSpritesPerRow; i++) {
            
            SKTexture* part = [SKTexture textureWithRect:CGRectMake(i*(1.0f/numSpritesPerRow), j*(1.0f/numRows), 1.0f/numSpritesPerRow, 1.0f/numRows) inTexture:mainTexture];
            
            [animationSheet addObject:part];
            
            if(animationSheet.count == numSprites)
                break;
        }
        
        if(animationSheet.count == numSprites)
            break;
        
    }
    return animationSheet;
}

@end
