//
//  ETMyScene.h
//  Money
//

//  Copyright (c) 2014 Erlend Thune. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@import AVFoundation;

#import "ETViewController.h"

@interface ETMyScene : SKScene<SKPhysicsContactDelegate>
- (void)initGame:(ETViewController*) vc;
- (bool)pausePlayGame;
- (bool)audioOnOff;
- (void) pauseGame;
- (void) playGame;
@property (strong, nonatomic) SKSpriteNode *jumperNode;
@property (strong, nonatomic) SKSpriteNode *pauseNode;
@property (strong, nonatomic) SKSpriteNode *soundNode;
@property (strong, nonatomic) SKLabelNode *targetNode;
@property (strong, nonatomic) SKLabelNode *targetNode2;
@property (strong, nonatomic) SKSpriteNode *cheeseNodeStatus;
@property (strong, nonatomic) SKLabelNode *cheeseNodeStatusText;
@property (strong, nonatomic) SKSpriteNode *floorNumberSymbol;
@property (strong, nonatomic) SKLabelNode *floorNumberText;
@property (strong, nonatomic) SKSpriteNode* platform;
@property (strong, nonatomic) SKSpriteNode* elevator;
@property (strong, nonatomic) SKSpriteNode* elevatorSupport;
@property (strong, nonatomic) SKSpriteNode* elevatorShaft;
@property (strong, nonatomic) SKSpriteNode* tunnellShaft;
@property (strong, nonatomic) SKSpriteNode* tunnellShaftAbove;
@property (strong, nonatomic) SKSpriteNode* tunnellShaftBelow;
@property (strong, nonatomic) SKSpriteNode* crust;
@property (strong, nonatomic) SKSpriteNode* crustAbove;
@property (strong, nonatomic) SKSpriteNode* crustBelow;
@property (strong, nonatomic) NSMutableArray *numberNodes;
@property (strong, nonatomic) NSMutableArray *lineNodes;
@property (strong, nonatomic) NSArray *floorImageNameArray;
@property (strong, nonatomic) NSArray *nextLevelValueArray;
@property (weak, nonatomic) ETViewController* vc;

@property  short consecutiveTraps;
@property  CGFloat impulse;
@property float bgscale;
@property float scrscale;
@property NSInteger state;
@property NSInteger floorNumber;
@property float yoff;
@property float shaftHeight;
@property CGFloat speedlevel;
@property bool bGameOver;
@property bool bSuccess;
@property bool bOnPlatform;
@property bool bPause;
@property bool bAudioOn;
@property int distance;
@property int noOfElementsInHorisontalShaft;
@property bool bJumpRequested;
@property bool bFirstLeftBorderCollision;
@property bool bLiftSequenceStarted;
@property bool bLevelTransition;
@property bool bLevelUp;
@property bool bLevelDown;
@property NSInteger cheeseCollected;
@property (strong, nonatomic) UILabel *label;

@property bool bElevatorSoundPaused;
@property bool bLevelUpSoundPaused;
@property bool bLevelDownSoundPaused;
@property bool bSuccessSongPaused;
@property bool bLoungeSoundPaused;

@property (strong, nonatomic) SKAction* cheeseSound;
@property (strong, nonatomic) SKAction* jumpSound;
@property (strong, nonatomic) AVAudioPlayer* avLoungeSong;
@property (strong, nonatomic) AVAudioPlayer* avSuccessSong;
@property (strong, nonatomic) AVAudioPlayer* avElevatorSound;
@property (strong, nonatomic) AVAudioPlayer* avLevelUpSound;
@property (strong, nonatomic) AVAudioPlayer* avLevelDownSound;

@end
