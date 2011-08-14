//
//  RootViewController.m
//  NavigationControllerTutorial
//
//  Created by Wa-jiw Casey on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "Constants.h"
#import "ModalViewController.h"
@implementation RootViewController

@synthesize menuList;

static NSArray *pageNames = nil;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    
    //instantiate *menuList
    self.menuList = [NSMutableArray array];
    
    //instantiate pageNames
    if(!pageNames)
    {
        pageNames = [[NSArray alloc] initWithObjects:@"PageOne", nil];
    }
    
    //setup menu list
    for(NSString *pageName in pageNames)
    {
        [self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  NSLocalizedString([pageName stringByAppendingString:@"Title"], @""), kTitleKey,
                                  NSLocalizedString([pageName stringByAppendingString:@"Explain"], @""), kDetailKey, nil]];
    }
    
    UIButton *modalViewButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [modalViewButton addTarget:self action:@selector(modalViewAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *modalBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:modalViewButton];
    
    self.navigationItem.rightBarButtonItem = modalBarButtonItem;
    [modalBarButtonItem release];
    
    [self.tableView reloadData];
}

-(IBAction)modalViewAction:(id)sender
{
    ModalViewController *newView = [[ModalViewController alloc] initWithNibName:@"ModalViewController" bundle:nil];
    [self.navigationController presentModalViewController:newView animated:YES];
    [newView release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuList count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.opaque = NO;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
        
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.opaque = NO;
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.highlightedTextColor = [UIColor whiteColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        
    }

    NSDictionary *dataDictionary = [menuList objectAtIndex:indexPath.row];
    cell.textLabel.text = [dataDictionary valueForKey:kTitleKey];
    cell.detailTextLabel.text = [dataDictionary valueForKey:kDetailKey];
    
    // Configure the cell.
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *rowData = [self.menuList objectAtIndex:indexPath.row];
    UIViewController *targetViewController = [rowData objectForKey:kViewControllerKey];
    if(!targetViewController)
    {
        NSString *viewControllerName = [[pageNames objectAtIndex:indexPath.row] stringByAppendingString:@"ViewController"];
        targetViewController = [[NSClassFromString(viewControllerName) alloc] initWithNibName:viewControllerName bundle:nil];
        [rowData setValue:targetViewController forKey:kViewControllerKey];
    }
    
    [self.navigationController pushViewController:targetViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [menuList release];
    [super dealloc];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
            break;
        }
        case 1:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
            self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
            break;   
        }
        case 2:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
            self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
            break;   
        }
    }
}

- (IBAction)styleAction:(id)sender
{
    UIActionSheet *styleAlert = [[UIActionSheet alloc] initWithTitle:@"Choose a UIBarStyle" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Default", @"BlackOpaque", @"BlackTranslucent", nil];
    
    styleAlert.actionSheetStyle = self.navigationController.navigationBar.barStyle;
    
    [styleAlert showInView:self.view];
    [styleAlert release];
}

@end
