//
//  MPDConnection.m
//  QSMPDClient
//
//  Created by Matthew Goodall on 18/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MPDConnection.h"


@implementation MPDConnection

+ (MpdObj *)connect{
	MpdObj *obj = NULL;
	obj = mpd_new_default();
	mpd_connect(obj);
	return obj;
}

+ (int)addSong:(NSString *)path{
	MpdObj *obj = [MPDConnection connect];

	const char *songfile = [path UTF8String];	
	
	int song_id = mpd_playlist_add_get_id(obj,songfile);

	mpd_free(obj);
	
	return song_id;
}
+ (void) addSongWithPosition:(NSString *)path:(int)position{
	int song_id = [MPDConnection addSong:path];
	MpdObj *obj = [MPDConnection connect];
	int last_pos = mpd_playlist_get_playlist_length(obj);	

	mpd_playlist_move_pos(obj, last_pos, position);
	
	mpd_free(obj);
	
}

+ (void)playSong:(int)position{
	MpdObj *obj = [MPDConnection connect];
	mpd_player_play_id(obj,position);
	mpd_free(obj);
}

// libmpd command seems to be broken
+ (void)enqueueSong:(int)position{
	MpdObj *obj = [MPDConnection connect];
//	mpd_playlist_mpd_queue_add(obj,position);
	mpd_free(obj);
}

+ (void) addSongAndPlay:(NSString *)path{
	int song_id = [MPDConnection addSong:path];
	[MPDConnection playSong:song_id];
}

+ (void) addSongAndQueue:(NSString *)path{
	int song_id = [MPDConnection addSong:path];
	[MPDConnection enqueueSong:song_id];
}
+ (void) addSongNext:(NSString *)path{
	MpdObj *obj = [MPDConnection connect];
	int current_pos = mpd_playlist_get_current_song(obj)->pos;
		mpd_free(obj);
	[MPDConnection addSongWithPosition:path:current_pos + 1];
}

@end
