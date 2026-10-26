/*
 * Copyright (c) 2005-2025, Kishonti Ltd
 * SPDX-License-Identifier: BSD-3-Clause
 * This file is part of GFXBench. See the top-level LICENSE file for details.
 */


#import "NUISceneDelegate.h"
#import "NUIAppDelegate.h"
#import "Utils/NUIMessageKeys.h"

@implementation NUISceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions
{
    if(![scene isKindOfClass:[UIWindowScene class]])
        return;
    NUIAppDelegate *app = (NUIAppDelegate *)[[UIApplication sharedApplication] delegate];
    [app showInWindowScene:(UIWindowScene *)scene];
    self.window = app.window;
}

- (void)sceneWillResignActive:(UIScene *)scene
{
    // Pause: a running test is cancelled, as the application delegate did before scenes.
    [[NSNotificationCenter defaultCenter] postNotificationName:NUI_Request_CancelTest object:self];
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:NO];
}

- (void)sceneDidBecomeActive:(UIScene *)scene
{
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
}

@end
