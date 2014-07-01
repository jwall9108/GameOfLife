	//
//  IntroLayer.m
//  GameofLife
//
//  Created by jeremy wall on 11/27/13.
//  Copyright jeremy wall 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "HelloWorldLayer.h"
#import "Block.h"

#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer
@synthesize Batch = _Batch, aLife = _aLife,
GridHeight = _GridHeight, GridWidth = _GridWidth,
ScreenSize = _ScreenSize, isDrawing = _isDrawing;

bool arr[125*65] = {false};
// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(id) init
{
	if((self=[super init]))
	{
		[self AddResetMenu];
		_ScreenSize = [[CCDirector sharedDirector] winSize];
		_aLife = [[NSMutableArray alloc] init];
		_Batch = [CCSpriteBatchNode batchNodeWithFile:@"HDSquare.png"];
		_Batch.position = ccp(6, 6);
		[self buildCellGrid:125 Height:65];
		[self schedule:@selector(RefreshTimer:) interval:0];
	}
	return self;
}

-(void)buildCellGrid:(int)width Height:(int)height{
	
	_GridWidth  = width;
	_GridHeight = height;
	coordinate Location;
	for (Location.y = 0; Location.y <= _GridHeight - 1; Location.y++)
	{
		for (Location.x = 0; Location.x <= _GridWidth - 1; Location.x++)
		{
			Block *blk = [[Block alloc]initWithLocation:Location];
			blk.position = ccp(Location.x + (Location.x * 3.5), Location.y + (Location.y * 3.5));
			blk.bAlive = ([self getRandomNumberBetween:0 to:3] == 1);
			[_Batch addChild: blk];
		}
	}
	[self addChild:_Batch];

}
-(void) RefreshTimer:(ccTime)delta
{
	Block *node;
	int index = 0;
	CCARRAY_FOREACH(_Batch.children, node)
	{
		
		int count = 0;
		for (int x = node.sCoordinate.x - 1; x <= node.sCoordinate.x + 1; x++)
		{
			for (int y = node.sCoordinate.y - 1; y <= node.sCoordinate.y + 1; y++)
			{
				if (!( x == node.sCoordinate.x &&  y == node.sCoordinate.y))
				{count += [self checkRow:x col:y];}
			}
		}
		
		//ConwayLogic
		if(count < 1 || count >=4){arr[index] = 0;}
		else if((node.bAlive) && (count == 2 || count == 3)){arr[index]= 1;}
		else if ((!node.bAlive) && (count == 3)){arr[index]= 1;}
		else{arr[index]= 0;}

		index++;
	}
	[self ToggleBlocks];
}

-(BOOL)checkRow:(int)x col:(int)y
{
	if (x >= 0 && x < _GridWidth && y >= 0 && y < _GridHeight)
	{
		Block *on = [_Batch.children objectAtIndex:x +  y * _GridWidth];
		return on.bAlive;
	}
	else{return FALSE;}
}

-(void)reset:(CCMenuItem *)sender
{
	[self unschedule:@selector(RefreshTimer:)];
	ccColor3B SenderColor = sender.color;
	Block *node;
	CCARRAY_FOREACH(_Batch.children, node)
	{
		node.AliveColor = SenderColor;
		node.bAlive = ([self getRandomNumberBetween:0 to:3] == 1);
	}
	[self schedule:@selector(RefreshTimer:) interval:0];
}


-(void)drawStart
{
	[self unschedule:@selector(RefreshTimer:)];
	_isDrawing = YES;
	
	
	[self schedule:@selector(RefreshTimer:) interval:0];
}

-(int)getRandomNumberBetween:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}

-(void)AddResetMenu
{
	NSMutableArray *array = [[NSMutableArray alloc]init];
	for(int i = 0; i <= 8; i++)
	{
		CCMenuItem *Reset = [CCMenuItemImage itemWithNormalImage:@"ResetButton.png"
							 selectedImage:@"ResetButton.png" target:self selector:@selector(reset:)];
		Reset.position = ccp(i * 60,145);
		[Reset setColor:[self GetRandomColor]];
		[array addObject:Reset];
	}
	CCMenu *ResetButton = [CCMenu menuWithArray:array];
	ResetButton.position = ccp(45.5, 165);
	[self addChild: ResetButton];
	
}

-(void)ToggleBlocks
{
	Block *node;
	CCARRAY_FOREACH(_Batch.descendants, node)
	{node.bAlive = arr[node.sCoordinate.x +  node.sCoordinate.y * _GridWidth];}
}

-(ccColor3B)GetRandomColor
{
	return ccc3([self getRandomNumberBetween:0 to:255],
				[self getRandomNumberBetween:0 to:255],
				[self getRandomNumberBetween:0 to:255]);
}

-(void) onEnter
{
	[super onEnter];
}
	
	
@end
