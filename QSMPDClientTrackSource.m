//
//  QSMPDClientTrackSource.m
//  QSMPDClient
//
//  Created by Matthew Goodall on 18/08/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "QSMPDClientTrackSource.h"
#import <QSCore/QSObject.h>

//true = up to date, so don't rescan
@implementation QSMPDClientTrackSource
- (BOOL)indexIsValidFromDate:(NSDate *)indexDate forEntry:(NSDictionary *)theEntry{
	MpdObj *obj = qsmpd_connect();
	mpd_status_update(obj);
    u_long updatetime = mpd_server_get_database_update_time(obj);
	u_long lastupdate = 1 ;
	if (updatetime>lastupdate){
		lastupdate = (u_long)time(NULL);
		return FALSE;
	}
	
	
	return YES;
}
/*
- (NSImage *) iconForEntry:(NSDictionary *)dict{
    return nil;
}
*/

// Return a unique identifier for an object (if you haven't assigned one before)
//- (NSString *)identifierForObject:(id <QSObject>)object{
//    return nil;
//}

- (NSArray *) objectsForEntry:(NSDictionary *)theEntry{
    NSMutableArray *objects=[NSMutableArray arrayWithCapacity:1];
    QSObject *newObject;
	
	MpdObj *obj = qsmpd_connect();

	// Add tracks
	MpdData *data = mpd_database_get_complete(obj);

	NSImage *icon = [[NSBundle bundleForClass:[self class]]imageNamed:@"music"];

	//MpdData *data = mpd_database_get_directory_recursive(obj,"/");
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
				 NSString *artist = @"Unknown";
				if (data->song->artist){
					artist =  [NSString stringWithUTF8String:data->song->artist];
				 }

				 NSString *album = @"Unknown";
				 if (data->song->album){
					album =  [NSString stringWithUTF8String:data->song->album];
				 }
				 
				 [newObject setDetails: [NSString stringWithFormat:@"%@ - %@", artist, album]];
				//basic album searching in this catalogue
				[newObject setLabel:album];
				
				//file is the id (used in the add commands), playlists use 'id' and pos
				NSString *file = [NSString stringWithUTF8String:data->song->file];
				[newObject setObject:file forMeta:@"file"];
				
				//[newObject setParentID:@"QSMPD_Tracks"];
				
				[newObject setIcon:icon];

				[objects addObject:newObject];
				data = mpd_data_get_next(data);
			}
		}while(data);
	}
	
	qsmpd_close(obj);
    return objects;
    
}


// Object Handler Methods


- (void)setQuickIconForObject:(QSObject *)object{
 
 NSImage *icon = [[NSBundle bundleForClass:[self class]]imageNamed:@"music"];

    [object setIcon:icon]; // An icon that is either already in memory or easy to load
}
/*
- (BOOL)loadIconForObject:(QSObject *)object{
	//return NO;
   // id data=[object objectForType:kQSMPDClientType];
//	[object setIcon:nil];
    return YES;
}*/

@end
