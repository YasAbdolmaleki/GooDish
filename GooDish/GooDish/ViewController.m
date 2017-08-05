//
//  ViewController.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-20.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SearchDishes_iPhone" bundle:nil];
    UICollectionViewController *dishesCVC = [storyboard instantiateViewControllerWithIdentifier:@"DishesCollectionViewController"];
    [self.navigationController pushViewController:dishesCVC animated:YES];
}

@end
