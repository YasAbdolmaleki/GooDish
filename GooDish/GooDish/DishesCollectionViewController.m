//
//  DishesCollectionViewController.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-20.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "DishesCollectionViewController.h"

#import "DishCollectionViewCell.h"

@interface DishesCollectionViewController ()

@end

@implementation DishesCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DishCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([DishCollectionViewCell class])];
    
    
    # warning testing
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"dishes" ofType:@"json"];
//    NSData *data = [NSData dataWithContentsOfFile:filePath];
//    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//
//    if(NSClassFromString(@"NSJSONSerialization"))
//    {
//        NSError *error = nil;
//        id object = [NSJSONSerialization
//                     JSONObjectWithData:data
//                     options:0
//                     error:&error];
//        
//        if(error) { /* JSON was malformed, act appropriately here */ }
//
//        if([object isKindOfClass:[NSDictionary class]])
//        {
//            NSDictionary *results = object;
//        }
//    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DishCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DishCollectionViewCell class]) forIndexPath:indexPath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(375, 250);
}

#pragma mark <UICollectionViewDelegate>


/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/


@end
