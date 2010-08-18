//
//  MPDConnection.h
//  QSMPDClient
//
//  Created by Matthew Goodall on 18/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import "libmpd.h"


@interface MPDConnection : NSObject {
	
}
+ (MpdObj *) connect;
+ (int)addSong:(NSString *)path;
+ (void) addSongWithPosition:(NSString *)path:(int)position;
+ (void)playSong:(int)position;
+ (void)enqueueSong:(int)position;
+ (void) addSongAndPlay:(NSString *)path;
+ (void) addSongAndQueue:(NSString *)path;
+ (void) addSongNext:(NSString *)path;
	
@end
