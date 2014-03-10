//
//  ArtistDataStore.m
//  CoreDataTutorial
//
//  Created by Son Ngo on 3/2/14.
//  Copyright (c) 2014 Son Ngo. All rights reserved.
//

#import "ArtistDataStore.h"

// 1
@interface ArtistDataStore ()

@property (nonatomic, strong) NSManagedObjectModel *model;
@property (nonatomic, strong) NSManagedObjectContext *context;

@end

#pragma mark -
@implementation ArtistDataStore

// 5
- (id)init {
  if (self = [super init]) {
    [self initManagedObjectModel];
    [self initManagedObjectContext];
  }
  return self;
}

#pragma mark - instance methods for adding/deleting managed objects
// 6
- (Artist *)createArtist {
  return [NSEntityDescription insertNewObjectForEntityForName:@"Artist"
                                       inManagedObjectContext:self.context];
}

// 7
- (void)deleteArtist:(Artist *)artist {
  [self.context deleteObject:artist];
}

// 8
- (NSArray *)artists {
  
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Artist"];
  NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
  [fetchRequest setSortDescriptors:@[sortDescriptor]];
  
  NSError *error;
  NSArray *artists = [self.context executeFetchRequest:fetchRequest error:&error];
  
  if (error != nil) {
    [NSException raise:@"Exception on retrieving artists"
                format:@"Error: %@", error.localizedDescription];
  }
  
  return artists;
}

// 9
- (void)save:(NSError *)error {
  [self.context save:&error];
}

// 2
#pragma mark - static methods
+ (ArtistDataStore *)sharedStore {
  static ArtistDataStore *store;
  if (store == nil) {
    store = [[ArtistDataStore alloc] init];
  }
  return store;
}

#pragma mark - private methods
// 3
- (void)initManagedObjectModel {
  NSURL *momdURL = [[NSBundle mainBundle] URLForResource:@"Artist" withExtension:@"momd"];
  self.model = [[NSManagedObjectModel alloc] initWithContentsOfURL:momdURL];
}

// 4
- (void)initManagedObjectContext {
  NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
  
  NSError *error;
  NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType
                                               configuration:nil
                                                         URL:[self storeArchivePath]
                                                     options:nil
                                                       error:&error];
  if (store == nil || error != nil) {
    [NSException raise:@"Exception Occurred while adding persistence store"
                format:@"Error: %@", error.localizedDescription];
  }
  
  self.context = [[NSManagedObjectContext alloc] init];
  [self.context setPersistentStoreCoordinator:psc];
}

- (NSURL *)storeArchivePath {
  NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                         inDomains:NSUserDomainMask];
  return [[urls firstObject] URLByAppendingPathComponent:@"store.data"];
}

@end
