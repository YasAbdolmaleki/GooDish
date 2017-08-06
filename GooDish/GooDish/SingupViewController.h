//
//  SingupViewController.h
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-08-05.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingupViewController.h"

@protocol SingupViewControllerDelegate <NSObject>
- (void)userSignedIn:(BOOL)signedIn withController:(UIViewController *)controller;
@end

@interface SingupViewController : UIViewController
@property (nonatomic, weak) id <SingupViewControllerDelegate> delegate;
@end
