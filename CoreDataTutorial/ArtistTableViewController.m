//
//  ArtistTableViewController.m
//  CoreDataTutorial
//
//  Created by Son Ngo on 3/1/14.
//  Copyright (c) 2014 Son Ngo. All rights reserved.
//

#import "ArtistTableViewController.h"

// 1
#import "ArtistDataStore.h"
#import "Artist.h"

// 2
@interface ArtistTableViewController ()

@property (nonatomic, strong) NSArray *artists;

@end

#pragma mark -
@implementation ArtistTableViewController

// 3
- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationItem.title = @"Artists";
}

// 4
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  self.artists = [[ArtistDataStore sharedStore] artists];
  [self.tableView reloadData];
}

// 5
#pragma mark - UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.artists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  
  Artist *artist = [self.artists objectAtIndex:indexPath.row];
  cell.textLabel.text = artist.name;
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
  [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"Birthday: %@", [dateFormatter stringFromDate:artist.birthday]];
  
  return cell;
}

// For deleting table rows
// 6
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    // delete Artist managed object from Core Data
    Artist *artistToDelete = [self.artists objectAtIndex:indexPath.row];
    
    ArtistDataStore *store = [ArtistDataStore sharedStore];
    [store deleteArtist:artistToDelete];
    
    self.artists = [store artists];
    
    // delete row from the tableview
    [tableView deleteRowsAtIndexPaths:@[indexPath]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
  }
}

@end
