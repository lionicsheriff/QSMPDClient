//
//  QSMPDClientSource.h
//  QSMPDClient
//
//  Created by Matthew Goodall on 18/08/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <QSCore/QSObjectSource.h>
#import "libmpd.h"
#import "MPDConnection.h"

#define QSMPDClientType @"QSMPDClientType"
#define QSMPDClientTrackType @"QSMPDClientTrackType"
#define QSMPDClientAlbumType @"QSMPDClientAlbumType"

@interface QSMPDClientSource : QSObjectSource
{
}
@end

