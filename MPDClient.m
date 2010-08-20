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

// All of these take a connection, use it, but don't close it.

/*
 * MPD
 */

void qsmpd_play(MpdObj *conn){
	mpd_player_play(conn);
}
void qsmpd_pause(MpdObj *conn){
	mpd_player_pause(conn);
}
// toggle between pause and play, put it into one of those states if not already
void qsmpd_toggle(MpdObj *conn){


	int state = mpd_player_get_state(conn);
	if (state == MPD_STATUS_STATE_PLAY){
		qsmpd_pause(conn);
	} else {
		qsmpd_play(conn);
	}
}
void qsmpd_stop(MpdObj *conn){
	mpd_player_stop(conn);
}
void qsmpd_next(MpdObj *conn){
	mpd_player_next(conn);
}
void qsmpd_prev(MpdObj *conn){
	mpd_player_prev(conn);
}

void qsmpd_clear(MpdObj *conn){
	mpd_playlist_clear(conn);
}


/*
 * Tracks
 */

int qsmpd_add_song(MpdObj *conn,NSString *path){
	const char *songfile = [path UTF8String];	
	int song_id = mpd_playlist_add_get_id(conn,songfile);
	return song_id;
}
void qsmpd_add_song_at_position(MpdObj *conn,NSString *path,int position){
	int song_id = qsmpd_add_song(conn,path);
	int last_pos = mpd_playlist_get_playlist_length(conn);	
	mpd_playlist_move_pos(conn, last_pos, position);
}


void qsmpd_play_song(MpdObj *conn,int pos){
	mpd_player_play_id(conn,pos);
}


void qsmpd_add_song_and_play(MpdObj *conn,NSString *path){
	int song_id = qsmpd_add_song(conn,path);
	qsmpd_play_song(conn,song_id);
}
//This returns the first match on a file name
MpdData *find_song_in_playlist(MpdObj *conn, NSString *path){
	const char *song_file = [path UTF8String];
	mpd_playlist_search_start(conn,1);
	mpd_playlist_search_add_constraint(conn,MPD_TAG_ITEM_FILENAME,song_file);
	MpdData *data = mpd_playlist_search_commit(conn);
	if (data){
		do{
			if (data->type == MPD_DATA_TYPE_SONG){
				return data;
			}
			data = mpd_data_get_next(data);
		}while(data);
		
	}
	return NULL;
}
int qsmpd_song_playlist_position(MpdObj *conn,NSString *path){
	MpdData *data = find_song_in_playlist(conn,path);
	if (data){
		return data->song->pos;
	}else{
		return -1;
	}
}
int qsmpd_song_playlist_id(MpdObj *conn, NSString *path){
	MpdData *data = find_song_in_playlist(conn,path);
	if (data){
		return data->song->id;
	}else{
		return -1;
	}
	
}

int qsmpd_add_song_not_exists(MpdObj *conn,NSString *path){
	int song_id = qsmpd_song_playlist_id(conn, path);
	if (song_id != -1){
		return song_id;
	}else{
		return qsmpd_add_song(conn,path);
	}
}
void qsmpd_add_song_not_exists_and_play(MpdObj *conn,NSString *path){
	int pos = qsmpd_add_song_not_exists(conn,path);
	qsmpd_play_song(conn, pos);
}
	

void qsmpd_add_song_next(MpdObj *conn,NSString *path){
	int current_pos = mpd_player_get_current_song_pos(conn);
	qsmpd_add_song_at_position(conn,path,current_pos + 1);
}


