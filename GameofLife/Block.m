//
//  MyCocos2DClass.m
//  Sprites
//
//  Created by jeremy wall on 8/20/13.
//  Copyright 2013 jeremy wall. All rights reserved.
//


#import "Block.h"


@implementation Block
@synthesize bAlive, Locx, Locy, sCoordinate, AliveColor, Tagindex;


-(id)initWithLocation:(coordinate)Location{
	if ((self = [super initWithFile:@"HDSquare.png"])){
		
		//bAlive = NO;
		self.AliveColor = ccBLUE;
		sCoordinate.x = Location.x;
		sCoordinate.y = Location.y;
		[self addObserver:self forKeyPath:@"bAlive" options:0 context:NULL];
	}
	return self;

}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"bAlive"])
    {
		if (bAlive == YES) {[self setColor:AliveColor];}
		else{[self setColor:ccWHITE];}
    }
}


-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	
	
	return YES;
}


- (void)onEnter
{
	 
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [super onEnter];
}

- (void)onExit
{
	
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
}

-(void) removeMe
{
    [self removeFromParentAndCleanup:YES];
}

- (void)dealloc
{
    [super dealloc];
}


@end
