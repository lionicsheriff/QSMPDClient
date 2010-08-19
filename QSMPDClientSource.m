//
//  QSMPDClientSource.m
//  QSMPDClient
//
//  Created by Matthew Goodall on 18/08/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "QSMPDClientSource.h"
#import <QSCore/QSObject.h>

//true = up to date, so don't rescan
@implementation QSMPDClientSource
- (BOOL)indexIsValidFromDate:(NSDate *)indexDate forEntry:(NSDictionary *)theEntry{
	MpdObj *obj = qsmpd_connect();
	mpd_status_update(obj);
    u_long updatetime = mpd_server_get_database_update_time(obj);
    u_long lastupdate = 1;
	
	if (updatetime>lastupdate){
		lastupdate = (u_long)time(NULL);
		return FALSE;
	}
	
	
	return YES;
}

- (NSImage *) iconForEntry:(NSDictionary *)dict{
    return nil;
}


// Return a unique identifier for an object (if you haven't assigned one before)
//- (NSString *)identifierForObject:(id <QSObject>)object{
//    return nil;
//}

- (NSArray *) objectsForEntry:(NSDictionary *)theEntry{
    NSMutableArray *objects=[NSMutableArray arrayWithCapacity:1];
    QSObject *newObject;
	
	MpdObj *obj = [MPDConnection connect];

	



	// Add tracks
	MpdData *data = mpd_database_get_complete(obj);
	NSMutableArray *tracks=[NSMutableArray arrayWithCapacity:1];
	if(data){
		do{
			if(data->type == MPD_DATA_TYPE_SONG){

				NSString *title = @"Unknown";

				if (data->song->title){
					title= [NSString stringWithUTF8String:data->song->title];
				}
				

				newObject=[QSObject objectWithName:title];
				[newObject setObject:title forType:QSMPDClientTrackType];
				[newObject setObject:title forType:QSTextType];
				[newObject setPrimaryType:QSMPDClientTrackType];
				
				//Pretty labels
/*				// Current query doesn't get tags I think.
				 NSString *artist = @"Unknown";
				 if (data->song->artist){
				 NSString *artist =  [NSString stringWithUTF8String:data->song->artist];
				 }
				 NSString *album = @"Unknown";
				 if (song_info->album){
				 NSString *artist =  [NSString stringWithUTF8String:song_info->album];
				 }
				 
				 [newObject setDetails: [NSString stringWithFormat:@"%@ - %@", artist, album]];
*/				 
				
				char *song_details[200];
				mpd_song_markup(song_details, 200, "%artist% - %album%", data->song);
				[newObject setDetails:[NSString stringWithUTF8String:song_details]];
				
				//file is the id (used in the add commands), playlists use 'id' and pos
				NSString *file = [NSString stringWithUTF8String:data->song->file];
				[newObject setObject:file forMeta:@"file"];
				
				
								
				[tracks addObject:newObject];
				data = mpd_data_get_next(data);
			}
		}while(data);
	}
	newObject=[QSObject objectWithName:@"Tracks"];
    //[newObject setObject:@"Tracks" forType:@"QSGroup"];
	[newObject setChildren:tracks];
	[objects addObject:newObject];
	
	mpd_free(obj);	
    return objects;
    
}


// Object Handler Methods

/*
- (void)setQuickIconForObject:(QSObject *)object{
    [object setIcon:nil]; // An icon that is either already in memory or easy to load
}
- (BOOL)loadIconForObject:(QSObject *)object{
	return NO;
    id data=[object objectForType:kQSMPDClientType];
	[object setIcon:nil];
    return YES;
}
*/
@end
