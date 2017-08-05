//
//  SingupViewController.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-08-05.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "SingupViewController.h"
#import <Google/SignIn.h>

@interface SingupViewController () <GIDSignInUIDelegate>

@property (weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;
@property (weak, nonatomic) IBOutlet UILabel *statusText;

@end

@implementation SingupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TODO(developer) Configure the sign-in button look/feel
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    [[GIDSignIn sharedInstance] signInSilently];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(receiveToggleAuthUINotification:)
     name:@"ToggleAuthUINotification"
     object:nil];
    
    [self toggleAuthUI];
    self.statusText.text = @"Google Sign in\niOS Demo";
}

- (IBAction)didTapSignOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
    [self toggleAuthUI];
}

- (void)toggleAuthUI {
    if ([GIDSignIn sharedInstance].currentUser.authentication == nil) {
        // Not signed in
        self.statusText.text = @"Google Sign in\niOS Demo";
        self.signInButton.hidden = NO;
        self.signOutButton.hidden = YES;
    } else {
        // Signed in
        self.signInButton.hidden = YES;
        self.signOutButton.hidden = NO;
    }
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    NSString *userId = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *name = user.profile.name;
    NSString *email = user.profile.email;
    NSLog(@"Customer details: %@ %@ %@ %@", userId, idToken, name, email);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:@"ToggleAuthUINotification"
     object:nil];
    
}

- (void) receiveToggleAuthUINotification:(NSNotification *) notification {
    if ([notification.name isEqualToString:@"ToggleAuthUINotification"]) {
        [self toggleAuthUI];
        self.statusText.text = notification.userInfo[@"statusText"];
    }
}

@end
