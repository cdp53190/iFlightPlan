//
//  SELCALPlayer.h
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/09.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TheAmazingAudioEngine/TheAmazingAudioEngine/AEAudioController.h"
#import "TheAmazingAudioEngine/TheAmazingAudioEngine/AEBlockChannel.h"

@interface SELCALPlayer : NSObject

@property AEAudioController *audioController;

-(void)playWithSELCALString:(NSString *)string;

@end
