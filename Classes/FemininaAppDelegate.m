//
//  FemininaAppDelegate.m
//  Feminina
//
//  Created by Patricia Daibes.
//  Copyright Favime 2010. All rights reserved.
//

#import "FemininaAppDelegate.h"
#import "FemininaViewController.h"

@implementation FemininaAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
       
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
