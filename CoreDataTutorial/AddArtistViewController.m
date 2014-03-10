//
//  ArtistDetailViewController.m
//  CoreDataTutorial
//
//  Created by Son Ngo on 3/6/14.
//  Copyright (c) 2014 Son Ngo. All rights reserved.
//

#import "AddArtistViewController.h"

// 1
#import "ArtistDataStore.h"
#import "Artist.h"

#pragma mark -
@implementation AddArtistViewController

// 2
- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationItem.title = @"Add Artist";
  self.birthdayPicker.datePickerMode = UIDatePickerModeDate;
  
  self.bioTextView.delegate      = self;
  self.nameField.delegate        = self;
  self.nationalityField.delegate = self;
  
  UITapGestureRecognizer *tapGR  =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(viewTapped:)];
  
  
  [self.view addGestureRecognizer:tapGR];
}

// 3
#pragma mark - UITapGestureRecognizer
- (void)viewTapped:(UITapGestureRecognizer *)gr {
  [self.view endEditing:YES];
}

// 4
#pragma mark - IBAction
- (IBAction)doneButtonClicked:(id)sender {
  
  ArtistDataStore *store = [ArtistDataStore sharedStore];
  
  Artist *newArtist = [store createArtist];
  newArtist.name        = self.nameField.text;
  newArtist.bio         = self.bioTextView.text;
  newArtist.birthday    = [self.birthdayPicker date];
  newArtist.nationality = self.nationalityField.text;
  
  NSError *error;
  [store save:error];
  if (error) {
    [NSException raise:@"Couldn't Save to Persistence Store"
                format:@"Error: %@", error.localizedDescription];
  }
  
  // navigate back to the parent view controller
  [self.navigationController popViewControllerAnimated:YES];
}

// 5
#pragma mark - UITextViewDelegate methods
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
  if ([text isEqual:@"\n"]) {
    [textView resignFirstResponder];
    return NO;
  }
  return YES;
}

#pragma mark - UITextFieldDelegate methods
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

@end
