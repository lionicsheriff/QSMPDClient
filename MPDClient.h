//
//  MPDClient.h
//  QSMPDClient
//
//  Created by Matthew Goodall on 18/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <libmpd.h>

MpdObj *qsmpd_connect(void);
void qsmpd_close(MpdObj *conn);

void qsmpd_play(MpdObj *conn);
void qsmpd_toggle(MpdObj *conn);
void qsmpd_stop(MpdObj *conn);
void qsmpd_next(MpdObj *conn);
void qsmpd_prev(MpdObj *conn);

void qsmpd_clear(MpdObj *conn);

int qsmpd_add_song(MpdObj *conn,NSString *path);
void qsmpd_add_song_at_position(MpdObj *conn,NSString *path,int pos);
void qsmpd_play_song(MpdObj *conn,int pos);
void qsmpd_add_song_and_play(MpdObj *conn,NSString *path);
void qsmpd_add_song_next(MpdObj *conn,NSString *path);

