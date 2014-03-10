//
//  ArtistDetailViewController.h
//  CoreDataTutorial
//
//  Created by Son Ngo on 3/6/14.
//  Copyright (c) 2014 Son Ngo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddArtistViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *nationalityField;
@property (weak, nonatomic) IBOutlet UIDatePicker *birthdayPicker;
@property (weak, nonatomic) IBOutlet UITextView *bioTextView;

- (IBAction)doneButtonClicked:(id)sender;

@end
