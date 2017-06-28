//
//  SearchCollectionViewCell.h
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-24.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchCollectionViewCellDelegate;

@protocol SearchCollectionViewCellDelegate <NSObject>

- (void)searchedText:(NSString *)searched;

@end

@interface SearchCollectionViewCell : UICollectionViewCell <UITextFieldDelegate>

@property (nonatomic, weak) id<SearchCollectionViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
- (void)textFieldDidChange:(NSNotification *)notification;

@end
