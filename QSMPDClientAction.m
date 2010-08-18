//
//  QSMPDClientAction.m
//  QSMPDClient
//
//  Created by Matthew Goodall on 18/08/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "QSMPDClientAction.h"

@implementation QSMPDClientAction

- (QSObject *)addTrack:(QSObject *)dObject{
	NSString *song_file = [dObject objectForMeta:@"file"];
	[MPDConnection addSong:song_file];
	return nil;
}
- (QSObject *)addTrackAndPlay:(QSObject *)dObject{
	NSString *song_file = [dObject objectForMeta:@"file"];
	[MPDConnection addSongAndPlay:song_file];
	return nil;
}

- (QSObject *)addTrackToNext:(QSObject *)dObject{
	NSString *song_file = [dObject objectForMeta:@"file"];
	[MPDConnection addSongNext:song_file];
	return nil;
}

@end
