//
//  PageOneViewController.m
//  NavigationControllerTutorial
//
//  Created by Wa-jiw Casey on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PageOneViewController.h"


@implementation PageOneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"PageOneTitle", @"");
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Addtitle", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(addAction:)] autorelease];
    
    self.navigationItem.rightBarButtonItem = addButton;
}

-(IBAction)addAction:(id)sender
{
    NSLog(@"button clicked");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
