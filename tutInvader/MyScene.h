//
//  MyScene.h
//  tutInvader
//

//  Copyright (c) 2014 Gabriel Vieira. All rights reserved.
//
static const uint32_t borda     =  0x1 << 0;
static const uint32_t tartaruga        =  0x1 << 1;

#import <SpriteKit/SpriteKit.h>

@interface MyScene : SKScene

@property SKSpriteNode *spriteTut;
@property BOOL pode;

@end
