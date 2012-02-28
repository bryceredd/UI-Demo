//
//  ARLPuffLayer.m
//  smoke
//
//  Created by Bryce Redd on 2/8/12.
//  Copyright (c) 2012 Itv. All rights reserved.
//

#import "ARLPuffLayer.h"

@implementation ARLPuffLayer
- (id) init {
    if((self = [super init])) {
        
        CAEmitterCell* puff = [CAEmitterCell emitterCell];
        puff.birthRate = 4000;
        puff.lifetime = .05;
        puff.lifetimeRange = 0.5;
        puff.color = [[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.1] 
          CGColor];
        puff.contents = (id)[[UIImage imageNamed:@"fire"] CGImage];
        puff.velocity = 200;
        puff.velocityRange = 200;
        puff.emissionRange = M_PI*2;
        puff.scale = 2.0;
        puff.scaleRange = .5;
        puff.scaleSpeed = 1.0;

        [puff setName:@"fire"];
        
        self.emitterCells = [NSArray arrayWithObject:puff];
        
    } return self;
}

@end
