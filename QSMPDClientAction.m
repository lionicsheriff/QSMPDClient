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
	qsmpd_add_song(conn, song_file);
	qsmpd_close(conn);
	return nil;
}
- (QSObject *)addTrackAndPlay:(QSObject *)dObject{
	NSString *song_file = [dObject objectForMeta:@"file"];
	MpdObj *conn = qsmpd_connect();
	qsmpd_add_song_not_exists_and_play(conn, song_file);
	qsmpd_close(conn);
	return nil;
}

- (QSObject *)queueTrack:(QSObject *)dObject{
	NSString *song_file = [dObject objectForMeta:@"file"];
	MpdObj *conn = qsmpd_connect();
	qsmpd_add_song_next(conn, song_file);
	qsmpd_close(conn);
	return nil;
}

@end
