/*
 * Copyright (c) 2005-2025, Kishonti Ltd
 * SPDX-License-Identifier: BSD-3-Clause
 * This file is part of GFXBench. See the top-level LICENSE file for details.
 */


#import "NUIAppDelegate.h"
#import "Common/NUIAppData.h"
#import "NUIMainViewController.h"
#import "Utils/NUIMessageKeys.h"
#import "Pages/NUITestViewController.h"
#import "NUICommandLineParser.h"

@interface NUIAppDelegate()

@property (strong, nonatomic) NUICommandLineParser *cmdline;

@end

@implementation NUIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    try
    {
        self.cmdline = nil;

#if IS_CORPORATE
        if([[[NSProcessInfo processInfo] arguments] count] > 1) {
            [[self getCmdline] parse];
        }
#endif


        [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];

        _viewName = @"TheStoryboard";
    }
    catch(NSException *ex)
    {
        NSLog(@"-------- INIT ERROR ---------");
        NSLog(@"%@", ex.reason);
        NSLog(@"-----------------------------");
        exit(-1);
    }
    catch(...)
    {
        NSLog(@"-------- INIT ERROR ---------");
        exit(-1);
    }

    return YES;
}

- (void)showInWindowScene:(UIWindowScene *)scene
{
    try
    {
        if(self.cmdline != nil)
        {
            self.window = [[UIWindow alloc] initWithWindowScene:scene];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:_viewName bundle:nil];
            NUITestViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"NUITestViewController"];
            viewController.CommandLine = self.cmdline;
            self.window.rootViewController = (UIViewController *)viewController;
        }
        else
        {
            self.window = [[UIWindow alloc] initWithWindowScene:scene];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:_viewName bundle:nil];

            UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"RootNavigatorVC"];

            self.window.rootViewController = viewController;
        }

        [self.window makeKeyAndVisible];

        if(self.cmdline == nil) {
            dispatch_queue_t startupQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long)NULL);
            dispatch_async(startupQueue, ^(void) {
                [[NUIAppData sharedNUIAppData] Startup];
            });
        }
    }
    catch(NSException *ex)
    {
        NSLog(@"-------- INIT ERROR ---------");
        NSLog(@"%@", ex.reason);
        NSLog(@"-----------------------------");
        exit(-1);
    }
    catch(...)
    {
        NSLog(@"-------- INIT ERROR ---------");
        exit(-1);
    }
}

// With scenes adopted, the active and inactive callbacks go to the scene: NUISceneDelegate.

- (NUICommandLineParser *)getCmdline
{
    if(self.cmdline == nil)
        self.cmdline = [[NUICommandLineParser alloc] init];
    return self.cmdline;
}


@end
