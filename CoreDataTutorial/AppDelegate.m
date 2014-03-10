//
//  AppDelegate.m
//  CoreDataTutorial
//
//  Created by Son Ngo on 3/1/14.
//  Copyright (c) 2014 Son Ngo. All rights reserved.
//

#import "AppDelegate.h"
#import "ArtistDataStore.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // Override point for customization after application launch.
  ArtistDataStore *store = [ArtistDataStore sharedStore];
  
  if ([store artists].count <= 0) {
    NSArray *names = @[@"Ray Charles", @"Aretha Franklin", @"Eminem", @"Bruno Mars", @"Blake Shelton"];
    
    NSArray *bios = @[@"Ray Charles Robinson was an American singer-songwriter, musician and composer known as Ray Charles. He was a pioneer in the genre of soul music during the 1950s by fusing rhythm and blues, gospel, and blues styles",
                      @"Aretha Louise Franklin (born March 25, 1942) is an American singer and musician. Franklin began her career singing gospel at her father, minister C. L. Franklin's church as a child. In 1960, at age 18, Franklin embarked on a secular career, recording for Columbia Records only achieving modest success.",
                      @"Marshall Bruce Mathers III (born October 17, 1972),[1] better known by his stage name Eminem and by his alter ego Slim Shady, is an American rapper, record producer, songwriter, and actor.",
                      @"Peter Gene Hernandez (born October 8, 1985), known by his stage name Bruno Mars, is an American singer-songwriter, record producer, actor and choreographer.",
                      @"Blake Tollison Shelton (born June 18, 1976)[1][2] is an American country music singer and television personality."];
    NSArray *nationalities = @[@"African American", @"African American", @"American", @"American", @"American"];
    
    NSArray *birthDays = @[[self createDateWithMonth:9 Day:23 Year:1930],
                           [self createDateWithMonth:3 Day:25 Year:1942],
                           [self createDateWithMonth:10 Day:17 Year:1972],
                           [self createDateWithMonth:10 Day:8 Year:1985],
                           [self createDateWithMonth:6 Day:18 Year:1976]];
    
    
    for (int i=0; i<names.count; i++) {
      Artist *artist = [store createArtist];
      artist.name        = names[i];
      artist.bio         = bios[i];
      artist.nationality = nationalities[i];
      artist.birthday    = birthDays[i];
    }
    
    NSError *error;
    [store save:error];
    
    if (error != nil) {
      [NSException raise:@"Error saving data to context"
                  format:@"Error: %@", error.localizedDescription];
    }
  }
  
  return YES;
}

- (NSDate *)createDateWithMonth:(int)month Day:(int)day Year:(int)year {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  
  NSDateComponents *components = [[NSDateComponents alloc] init];
  [components setMonth:month];
  [components setDay:day];
  [components setYear:year];
  
  return [calendar dateFromComponents:components];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  
  NSError *error;
  [[ArtistDataStore sharedStore] save:error];
  
  if (error) {
    [NSException raise:@"Couldn't Save Core Data"
                format:@"Error: %@", error.localizedDescription];
  }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  NSError *error;
  [[ArtistDataStore sharedStore] save:error];
  
  if (error) {
    [NSException raise:@"Couldn't Save Core Data"
                format:@"Error: %@", error.localizedDescription];
  }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

@end
