//
//  IntroLayer.h
//  GameofLife
//
//  Created by jeremy wall on 11/27/13.
//  Copyright jeremy wall 2013. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface IntroLayer : CCLayer
{
}

typedef struct {
    int x;
    int y;
} coordinate;


@property (nonatomic, retain) CCSpriteBatchNode *Batch;
@property (nonatomic, retain) NSMutableArray *aLife;
@property CGSize ScreenSize;
@property int GridHeight;
@property int GridWidth;

@property BOOL isDrawing;


+(CCScene *) scene;
-(void)AddResetMenu;
-(BOOL)checkRow:(int)x col:(int)y;
-(void) RefreshTimer:(ccTime)delta;

@end
