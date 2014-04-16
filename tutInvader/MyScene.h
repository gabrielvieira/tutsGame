//
//  MyScene.h
//  tutInvader
//

//  Copyright (c) 2014 Gabriel Vieira. All rights reserved.
//


static const uint32_t borda     =  0x1 << 0;
static const uint32_t tartaruga =  0x1 << 1;


#import <SpriteKit/SpriteKit.h>

@interface MyScene : SKScene <SKPhysicsContactDelegate>

@property SKSpriteNode *spriteTut;
@property SKSpriteNode *chao;
@property SKSpriteNode *bg;
@property BOOL pode;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@end
