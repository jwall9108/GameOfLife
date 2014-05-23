//
//  MyCocos2DClass.h
//  Sprites
//
//  Created by jeremy wall on 8/20/13.
//  Copyright 2013 jeremy wall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "IntroLayer.h"


@interface Block : CCSprite {
	
}


@property  bool bAlive;
@property  int Locx;
@property  int Locy;
@property  int Tagindex;
@property (assign, nonatomic) coordinate sCoordinate;
@property (assign, nonatomic) ccColor3B AliveColor;


-(id)initWithLocation:(coordinate)Location;


@end
