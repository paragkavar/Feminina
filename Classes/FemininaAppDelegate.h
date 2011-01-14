//
//  FemininaAppDelegate.h
//  Feminina
//
//  Created by Patricia Daibes.
//  Copyright Favime 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FemininaViewController;

@interface FemininaAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    FemininaViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FemininaViewController *viewController;

@end

