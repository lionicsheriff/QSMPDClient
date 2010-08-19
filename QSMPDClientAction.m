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
	MpdObj *conn = qsmpd_connect();
	qsmpd_addSong(conn, song_file);
	qsmpd_close(conn);
	return nil;
}
- (QSObject *)addTrackAndPlay:(QSObject *)dObject{
	NSString *song_file = [dObject objectForMeta:@"file"];
	MpdObj *conn = qsmpd_connect();
	int pos = qsmpd_addSong(conn, song_file);
	qsmpd_playSong(conn, pos);
	qsmpd_close(conn);
	return nil;
}

- (QSObject *)addTrackToNext:(QSObject *)dObject{
	NSString *song_file = [dObject objectForMeta:@"file"];
	MpdObj *conn = qsmpd_connect();
	int pos = qsmpd_addSong(conn, song_file);
	qsmpd_playSong(conn, pos);
	
	qsmpd_close(conn);
	return nil;
}

@end
