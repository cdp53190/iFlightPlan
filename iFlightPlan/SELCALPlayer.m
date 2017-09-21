//
//  SELCALPlayer.m
//  iFlightPlan
//
//  Created by Seiji Mitsuda on 2016/10/09.
//  Copyright © 2016年 Another Sky. All rights reserved.
//

#import "SELCALPlayer.h"

@implementation SELCALPlayer
{
    AEBlockChannel *tone1,*tone2,*tone3,*tone4;
}

static const int kInputChannelsChangedContext;

-(void)playWithSELCALString:(NSString *)string {
    
    if (string.length != 4) {
        return;
    }
    
    if (_audioController) {

        [_audioController removeObserver:self forKeyPath:@"numberOfInputChannels"];
        
        NSMutableArray *channelsToRemove = [NSMutableArray arrayWithObjects:tone1,tone2,tone3,tone4,nil];
        
        tone1 = nil;
        tone2 = nil;
        tone3 = nil;
        tone4 = nil;
        
        [_audioController removeChannels:channelsToRemove];
        
    } else {
    
        _audioController = [[AEAudioController alloc] initWithAudioDescription:AEAudioStreamBasicDescriptionNonInterleavedFloatStereo inputEnabled:NO];
        _audioController.preferredBufferDuration = 0.005;
        _audioController.useMeasurementMode = YES;

    }

    [_audioController start:NULL];

    AEAudioUnitChannel *audioUnitPlayer = [[AEAudioUnitChannel alloc] initWithComponentDescription:AEAudioComponentDescriptionMake(kAudioUnitManufacturer_Apple, kAudioUnitType_Generator, kAudioUnitSubType_AudioFilePlayer)];


    tone1 = [self blockChannelWithSELCALLetter:[string substringWithRange:NSMakeRange(0, 1)]];
    if (tone1 == nil) return;
    tone1.channelIsMuted = NO;

    tone2 = [self blockChannelWithSELCALLetter:[string substringWithRange:NSMakeRange(1, 1)]];
    if (tone2 == nil) return;
    tone2.channelIsMuted = NO;

    tone3 = [self blockChannelWithSELCALLetter:[string substringWithRange:NSMakeRange(2, 1)]];
    if (tone3 == nil) return;
    tone3.channelIsMuted = YES;

    tone4 = [self blockChannelWithSELCALLetter:[string substringWithRange:NSMakeRange(3, 1)]];
    if (tone4 == nil) return;
    tone4.channelIsMuted = YES;
    [_audioController addChannels:@[tone1,tone2,tone3,tone4]];
    
    // Finally, add the audio unit player
    [_audioController addChannels:@[audioUnitPlayer]];
    
    [_audioController addObserver:self forKeyPath:@"numberOfInputChannels" options:0 context:(void*)&kInputChannelsChangedContext];
    
    
    
    [self performSelector:@selector(changeSound) withObject:nil afterDelay:1.25];
    [self performSelector:@selector(stopSound) withObject:nil afterDelay:2.5];
    
}

-(void)playMuteSound {
    
    if (_audioController) {
        
        [_audioController removeObserver:self forKeyPath:@"numberOfInputChannels"];
        
        NSMutableArray *channelsToRemove = [NSMutableArray arrayWithObjects:tone1,tone2,tone3,tone4,nil];
        
        tone1 = nil;
        tone2 = nil;
        tone3 = nil;
        tone4 = nil;
        
        [_audioController removeChannels:channelsToRemove];
        
    } else {
        
        _audioController = [[AEAudioController alloc] initWithAudioDescription:AEAudioStreamBasicDescriptionNonInterleavedFloatStereo inputEnabled:NO];
        _audioController.preferredBufferDuration = 0.005;
        _audioController.useMeasurementMode = YES;
        
    }
    
    [_audioController start:NULL];
    
    AEAudioUnitChannel *audioUnitPlayer = [[AEAudioUnitChannel alloc] initWithComponentDescription:AEAudioComponentDescriptionMake(kAudioUnitManufacturer_Apple, kAudioUnitType_Generator, kAudioUnitSubType_AudioFilePlayer)];
    
    
    tone1 = [self blockChannelOfMuteSound];
    if (tone1 == nil) return;
    tone1.channelIsMuted = NO;
    
    [_audioController addChannels:@[tone1]];
    
    // Finally, add the audio unit player
    [_audioController addChannels:@[audioUnitPlayer]];
    
    [_audioController addObserver:self forKeyPath:@"numberOfInputChannels" options:0 context:(void*)&kInputChannelsChangedContext];
 
}

-(void)changeSound {
    
    tone1.channelIsMuted = YES;
    tone2.channelIsMuted = YES;
    tone3.channelIsMuted = NO;
    tone4.channelIsMuted = NO;
    
}

-(void)stopSound {
    
    [_audioController stop];
}

-(AEBlockChannel *)blockChannelWithSELCALLetter:(NSString *)letter {
    
    double frequency;
    
    if ([letter isEqualToString:@"A"]) {
        frequency = 312.6;
    } else if ([letter isEqualToString:@"B"]) {
        frequency = 346.7;
    } else if ([letter isEqualToString:@"C"]) {
        frequency = 384.6;
    } else if ([letter isEqualToString:@"D"]) {
        frequency = 426.6;
    } else if ([letter isEqualToString:@"E"]) {
        frequency = 473.2;
    } else if ([letter isEqualToString:@"F"]) {
        frequency = 524.8;
    } else if ([letter isEqualToString:@"G"]) {
        frequency = 582.1;
    } else if ([letter isEqualToString:@"H"]) {
        frequency = 645.7;
    } else if ([letter isEqualToString:@"J"]) {
        frequency = 716.1;
    } else if ([letter isEqualToString:@"K"]) {
        frequency = 794.3;
    } else if ([letter isEqualToString:@"L"]) {
        frequency = 881.0;
    } else if ([letter isEqualToString:@"M"]) {
        frequency = 977.2;
    } else if ([letter isEqualToString:@"P"]) {
        frequency = 1083.9;
    } else if ([letter isEqualToString:@"Q"]) {
        frequency = 1202.3;
    } else if ([letter isEqualToString:@"R"]) {
        frequency = 1333.5;
    } else if ([letter isEqualToString:@"S"]) {
        frequency = 1479.1;
    } else {
        return nil;
    }
    
    double sampleRate = 44100.0;
    
    __block double phase = 0.0;
    double freq = frequency * 2.0 * M_PI / sampleRate;
    AEBlockChannel *tone = [AEBlockChannel channelWithBlock:^(const AudioTimeStamp *time, UInt32 frames, AudioBufferList *audio) {
        
        //サイン波
        for ( int i=0; i<frames; i++ ) {
            float wave = sin(phase) * INT16_MAX / 2;
            ((SInt16*)audio->mBuffers[0].mData)[i] = wave;
            ((SInt16*)audio->mBuffers[1].mData)[i] = wave;
            phase += freq;
        }
        
    }];
    
    tone.volume = 1;
    tone.pan = 0;
    tone.audioDescription = AEAudioStreamBasicDescriptionNonInterleaved16BitStereo;
    tone.channelIsMuted = NO;
    
    return tone;
}

-(AEBlockChannel *)blockChannelOfMuteSound {
    
    double frequency = 0;
    
    double sampleRate = 44100.0;
    
    __block double phase = 0.0;
    double freq = frequency * 2.0 * M_PI / sampleRate;
    AEBlockChannel *tone = [AEBlockChannel channelWithBlock:^(const AudioTimeStamp *time, UInt32 frames, AudioBufferList *audio) {
        
        //サイン波
        for ( int i=0; i<frames; i++ ) {
            float wave = sin(phase) * INT16_MAX / 2;
            ((SInt16*)audio->mBuffers[0].mData)[i] = wave;
            ((SInt16*)audio->mBuffers[1].mData)[i] = wave;
            phase += freq;
        }
        
    }];
    
    tone.volume = 1;
    tone.pan = 0;
    tone.audioDescription = AEAudioStreamBasicDescriptionNonInterleaved16BitStereo;
    tone.channelIsMuted = NO;
    
    return tone;
}


@end
