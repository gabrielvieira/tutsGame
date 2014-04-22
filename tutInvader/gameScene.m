//
//  MyScene.m
//  tutInvader
//
//  Created by Gabriel Vieira on 15/04/14.
//  Copyright (c) 2014 Gabriel Vieira. All rights reserved.
//

#import "gameScene.h"
#import "gameFloor.h"
#import "gameTut.h"

@implementation gameScene

#pragma mark class init

-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.bg2 = [SKSpriteNode spriteNodeWithImageNamed:@"newbg2"];
        self.bg2.position = CGPointMake(568*2.5, size.width /2);
        [self addChild:self.bg2];
        
        
        
        self.emenySpawn = [[Timer alloc]init];
        [self.emenySpawn startTimer];
        
        
        self.bg1 = [SKSpriteNode spriteNodeWithImageNamed:@"newbg1"];
        self.bg1.position = CGPointMake(size.height /2, size.width /2);
        [self addChild:self.bg1];
       
        self.pode = NO;
        
        
        self.chao = [[gameFloor alloc]initWithSize:CGSizeMake(size.height , 1)];
        [self addChild:self.chao];
        
        
        
        self.aguaFrame = [self loadSpriteSheetFromImageWithName:@"jelly" withNumberOfSprites:12 withNumberOfRows:4 withNumberOfSpritesPerRow:3];
        
        self.tirosFrame = [self alocandoSpriteTiro];
        
        
        
        self.spriteTut = [[gameTut alloc]init];
        SKAction *action = [SKAction rotateByAngle:(M_PI/2) * (-1) duration:1];
       [self.spriteTut runAction:action];
       
        [self addChild:self.spriteTut];
        
        NSString *myParticlePath = [[NSBundle mainBundle] pathForResource:@"FireParticle" ofType:@"sks"];
        self.FireParticle = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
        self.FireParticle.particlePosition = CGPointMake(self.spriteTut.position.x - 30, self.spriteTut.position.y);
        self.FireParticle.particleBirthRate = 250;
        
        [self addChild:self.FireParticle];
        
       // SKAction *cu = [SKAction animateWithTextures:self.aguaFrame timePerFrame:0.2f];
        //[self.spriteTut runAction:[SKAction repeatActionForever:cu]];
        self.spriteTut.anchorPoint = CGPointMake(0.5, 0.5);
        
        
        self.physicsWorld.gravity = CGVectorMake(0.0f, 0.0f);
        self.physicsWorld.contactDelegate = self;
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        self.pointsPerSecondSpeed = 70;
        self.podeMoverBg1 = YES;
        self.podeMoverBg2 = NO;
        
        [self EnemiesAndClouds];
        
        NSLog(@"%f  %f", self.size.height , self.size.width);
        
        self.podeDescer = NO;
        self.podeSubir = NO;
        
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
    
    if (touchPoint.x < self.size.width/2 && touchPoint.y < self.size.height/2) {
        self.podeDescer = YES;
    }
    
    if (touchPoint.x < self.size.width/2 && touchPoint.y > self.size.height/2) {
        self.podeSubir = YES;
    }
    
   
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.pode = NO;
    self.podeDescer = NO;
    self.podeSubir = NO;

    NSLog(@"cabou");
}

#pragma mark Colision

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"contact detected");
    
    SKPhysicsBody *firstBody;
    SKPhysicsBody *secondBody;
    
    if ([contact.bodyA.node.name isEqualToString:@"tiro" ]) {
        
        [contact.bodyA.node removeFromParent];
    }
    
    if ([contact.bodyB.node.name isEqualToString:@"tiro" ]) {
        
        [contact.bodyB.node removeFromParent];
    }
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    //Your f
}

#pragma mark Main Game Loop

-(void)update:(CFTimeInterval)currentTime {
    
    /*
    [self.emenySpawn stopTimer];
    if ((int)[self.emenySpawn timeElapsedInSeconds] == 1) {
        
        [self EnemiesAndClouds];
        [self.emenySpawn startTimer];
    }
     */
    
    
    if (self.pode) {
        
        [self atirar];
        self.pode = NO;
    }
    
    
    if (self.podeDescer) {
        self.spriteTut.position = CGPointMake(self.spriteTut.position.x, self.spriteTut.position.y - 4);
        self.FireParticle.position =  CGPointMake(self.spriteTut.position.x - 160, self.spriteTut.position.y - 160);
        
    }
    
    if (self.podeSubir) {
        self.spriteTut.position = CGPointMake(self.spriteTut.position.x, self.spriteTut.position.y + 4);
        self.FireParticle.position =  CGPointMake(self.spriteTut.position.x - 160, self.spriteTut.position.y - 160);

    }
    
    
    [self verificaBackground];
    
    //To compute velocity we need delta time to multiply by points per second
    if (self.lastUpdateTime)
    {
        self.deltaTime = currentTime - self.lastUpdateTime;
    }
    else
    {
        self.deltaTime = 0;
    }
    
    self.lastUpdateTime = currentTime;
    
    CGPoint bgVelocity = CGPointMake(-self.pointsPerSecondSpeed, 0.0);
    CGPoint amtToMove = CGPointMake(bgVelocity.x * self.deltaTime, bgVelocity.y * self.deltaTime);
    
    if (self.podeMoverBg1) {
        self.bg1.position = CGPointMake(self.bg1.position.x+amtToMove.x, self.bg1.position.y);
    }
    
    if (self.podeMoverBg2) {
         self.bg2.position = CGPointMake(self.bg2.position.x+amtToMove.x, self.bg2.position.y);
    }
}

-(void)atirar
{
    SKSpriteNode *tiro = [[SKSpriteNode alloc]initWithColor:[UIColor yellowColor] size:CGSizeMake(40, 18)];
    tiro.position = CGPointMake(self.spriteTut.position.x + 60, self.spriteTut.position.y);
    tiro.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:tiro.size];
    tiro.physicsBody.density = 0.1f;
    tiro.physicsBody.categoryBitMask = tiroAzul;
    tiro.physicsBody.contactTestBitMask = inimigo;
    tiro.physicsBody.collisionBitMask = inimigo;
    tiro.name = @"tiro";
    
    tiro.physicsBody.dynamic = YES;
    SKAction *cu = [SKAction animateWithTextures:self.tirosFrame timePerFrame:0.2f];
    [tiro runAction:[SKAction repeatActionForever:cu]];

    [self addChild:tiro];
    [tiro.physicsBody applyForce:CGVectorMake(25.0f, 0.0f)];
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

-(void)verificaBackground
{
    //varios bg monstro infinito
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

}

-(void)EnemiesAndClouds{
    //not always come
    SKSpriteNode *enemy;
    enemy = [[SKSpriteNode alloc]init];
    enemy.size = CGSizeMake(50, 50);
    SKAction *cu = [SKAction animateWithTextures:self.aguaFrame timePerFrame:0.2f];
    [enemy runAction:[SKAction repeatActionForever:cu]];

        enemy.scale = 0.6;
        
        enemy.position = CGPointMake(self.size.width/2, self.size.height/2);
        enemy.zPosition = 1;
    enemy.physicsBody.dynamic = YES;
    enemy.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:enemy.size.width/2];
    enemy.physicsBody.categoryBitMask = inimigo;
    enemy.physicsBody.contactTestBitMask = tartaruga | borda | tiroAzul;
    enemy.physicsBody.collisionBitMask = tartaruga | borda | tiroAzul;
    
        
        CGMutablePathRef cgpath = CGPathCreateMutable();
        /*
        //random values
        float xStart = [self getRandomNumberBetween:0+enemy.size.width to:self.size.width-enemy.size.width ];
        float xEnd = [self getRandomNumberBetween:0+enemy.size.width to:self.size.width-enemy.size.width ];
        
        //ControlPoint1
        float cp1X = [self getRandomNumberBetween:0+enemy.size.width to:self.size.width-enemy.size.width ];
        float cp1Y = [self getRandomNumberBetween:0+enemy.size.width to:self.size.width-enemy.size.height ];
        
        //ControlPoint2
        float cp2X = [self getRandomNumberBetween:0+enemy.size.width to:self.size.width-enemy.size.width ];
        float cp2Y = [self getRandomNumberBetween:0 to:cp1Y];
        
        CGPoint s = CGPointMake(600.0, 160);
        CGPoint e = CGPointMake(0.0, 320);
        CGPoint cp1 = CGPointMake(450, 320);
        CGPoint cp2 = CGPointMake(250, -320);
        CGPathMoveToPoint(cgpath,NULL, s.x, s.y);
        CGPathAddCurveToPoint(cgpath, NULL, cp1.x, cp1.y, cp2.x, cp2.y, e.x, e.y);
    
    SKAction *planeDestroy = [SKAction followPath:cgpath asOffset:NO orientToPath:YES duration:5];
    [self addChild:enemy];
    
    SKAction *remove = [SKAction removeFromParent];
    [enemy runAction:[SKAction sequence:@[planeDestroy,remove]]];
    
    */
    enemy.position = CGPointMake(450 , 160  );
     [self addChild:enemy];
    
}

- (NSInteger)getRandomNumberBetween:(NSInteger)min to :(NSInteger)max
{
    return min + arc4random() % (max - min + 1);
}

-(NSArray *)alocandoSpriteTiro
{
    NSArray *s = [NSArray arrayWithObjects:[SKTexture textureWithImageNamed:@"tiro3"],[SKTexture textureWithImageNamed:@"tiro2"],[SKTexture textureWithImageNamed:@"tiro1"], nil];

    return s;
}

@end
