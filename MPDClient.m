//
//  MPDConnection.m
//  QSMPDClient
//
//  Created by Matthew Goodall on 18/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MPDClient.h"






MpdObj *qsmpd_connect(void){
	MpdObj *obj = NULL;
	obj = mpd_new_default();
	mpd_connect(obj);
	return obj;
}
void qsmpd_close(MpdObj *conn){
	mpd_free(conn);
}

int qsmpd_addSong(MpdObj *conn,NSString *path){
	const char *songfile = [path UTF8String];	
	int song_id = mpd_playlist_add_get_id(conn,songfile);
	return song_id;
}
void qsmpd_addSongAtPosition(MpdObj *conn,NSString *path,int position){
	int song_id = qsmpd_addSong(conn,path);
	int last_pos = mpd_playlist_get_playlist_length(conn);	
	mpd_playlist_move_pos(conn, last_pos, position);
}

void qsmpd_playSong(MpdObj *conn,int pos){
	mpd_player_play_id(conn,pos);
}

void qsmpd_addSongAndPlay(MpdObj *conn,NSString *path){
	int song_id = qsmpd_addSong(conn,path);
	qsmpd_playSong(conn,song_id);
}

void qsmpd_addSongNext(MpdObj *conn,NSString *path){
	int current_pos = mpd_playlist_get_current_song(conn)->pos;
	qsmpd_addSongAtPosition(conn,path,current_pos + 1);
}


