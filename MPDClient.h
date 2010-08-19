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

int qsmpd_addSong(MpdObj *conn,NSString *path);
void qsmpd_addSongAtPosition(MpdObj *conn,NSString *path,int pos);

void qsmpd_playSong(MpdObj *conn,int pos);

void qsmpd_addSongAndPlay(MpdObj *conn,NSString *path);
void qsmpd_addSongNext(MpdObj *conn,NSString *path);
