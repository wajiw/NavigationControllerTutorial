//
//  RootViewController.h
//  NavigationControllerTutorial
//
//  Created by Wa-jiw Casey on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController <UIActionSheetDelegate>{
    NSMutableArray *menuList;
}

@property(nonatomic, retain) NSMutableArray *menuList;

- (IBAction)styleAction:(id)sender;

@end
