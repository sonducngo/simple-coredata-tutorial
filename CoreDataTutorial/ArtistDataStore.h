//
//  ArtistDataStore.h
//  CoreDataTutorial
//
//  Created by Son Ngo on 3/2/14.
//  Copyright (c) 2014 Son Ngo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Artist.h"

@interface ArtistDataStore : NSObject

+ (ArtistDataStore *)sharedStore;

- (Artist *)createArtist;
- (void)deleteArtist:(Artist *)artist;
- (NSArray *)artists;
- (void)save:(NSError *)error;

@end
