/*
 * Copyright (c) 2005-2025, Kishonti Ltd
 * SPDX-License-Identifier: BSD-3-Clause
 * This file is part of GFXBench. See the top-level LICENSE file for details.
 */


#import <UIKit/UIKit.h>

// The app's one window scene (UIApplicationSceneManifest in Info.plist). An app built with the iOS 27 SDK must adopt the
// scene life cycle or it fails to launch; once it does, UIKit sends the active and inactive callbacks to the scene, not to
// the application delegate, which still makes the window (NUIAppDelegate showInWindowScene:).
@interface NUISceneDelegate : UIResponder <UIWindowSceneDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
