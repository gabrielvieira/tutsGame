//
//  MyScene.h
//  tutInvader
//

//  Copyright (c) 2014 Gabriel Vieira. All rights reserved.
//



#import <SpriteKit/SpriteKit.h>
#import "Define.h"
#import "Timer.h"

@interface gameScene : SKScene <SKPhysicsContactDelegate>

@property SKSpriteNode *spriteTut;
@property SKSpriteNode *chao;
@property SKSpriteNode *bg1;
@property SKSpriteNode *bg2;
@property BOOL pode;
@property NSTimeInterval lastUpdateTime;
@property NSTimeInterval deltaTime;
@property float pointsPerSecondSpeed;
@property BOOL podeMoverBg1;
@property BOOL podeMoverBg2;
@property NSArray *aguaFrame;
@property NSArray *tirosFrame;
@property NSArray *explosaoFrame;
@property BOOL podeSubir;
@property BOOL podeDescer;
@property SKEmitterNode *FireParticle;
@property Timer *emenySpawn;

@end
