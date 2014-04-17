//
//  MyScene.h
//  tutInvader
//

//  Copyright (c) 2014 Gabriel Vieira. All rights reserved.
//


static const uint32_t borda     =  0x1 << 0;
static const uint32_t tartaruga =  0x1 << 1;


#import <SpriteKit/SpriteKit.h>

@interface gameScene : SKScene <SKPhysicsContactDelegate>

@property SKSpriteNode *spriteTut;
@property SKSpriteNode *chao;
@property SKSpriteNode *bg1;
@property SKSpriteNode *bg2;
@property BOOL pode;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property NSTimeInterval lastUpdateTime;
@property NSTimeInterval deltaTime;
@property float pointsPerSecondSpeed;
@property BOOL podeMoverBg1;
@property BOOL podeMoverBg2;
@property NSArray *aguaFrame;

@end
