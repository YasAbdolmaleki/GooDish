//
//  SingupViewController.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-08-05.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "SingupViewController.h"
#import <Google/SignIn.h>
#import "NewReviewFormCollectionViewController.h"
@interface SingupViewController () <GIDSignInUIDelegate, GIDSignInDelegate>

@property (weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;
@property (weak, nonatomic) IBOutlet UILabel *statusText;

@end

@implementation SingupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GIDSignIn *signin = [GIDSignIn sharedInstance];
    [signin signOut];
    signin.delegate = self;
    signin.uiDelegate = self;
    
    //[[GIDSignIn sharedInstance] signInSilently];
    //[GIDSignIn sharedInstance].currentUser.authentication == nil
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(receiveToggleAuthUINotification:)
     name:@"ToggleAuthUINotification"
     object:nil];
    
    self.statusText.text = @"Google Sign in\niOS Demo";
}

- (void)viewDidAppear:(BOOL)animated {
    if (!([GIDSignIn sharedInstance].currentUser.authentication == nil)) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)didTapSignOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    NSString *userId = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *name = user.profile.name;
    NSString *email = user.profile.email;
    NSLog(@"Customer details: %@ \n%@ \n%@ \n%@", userId, idToken, name, email);
    [self.delegate userSignedIn:YES withController:self];
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

- (void)receiveToggleAuthUINotification:(NSNotification *) notification {
    if ([notification.name isEqualToString:@"ToggleAuthUINotification"]) {
        self.statusText.text = notification.userInfo[@"statusText"];
    }
}

@end
