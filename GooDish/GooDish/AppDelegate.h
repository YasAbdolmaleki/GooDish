//
//  AppDelegate.h
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-20.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

