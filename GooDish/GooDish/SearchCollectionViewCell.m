//
//  SearchCollectionViewCell.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-24.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "SearchCollectionViewCell.h"

@implementation SearchCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.searchTextField];
}

- (void)textFieldDidChange:(NSNotification *)notification {
    if([self.delegate respondsToSelector:@selector(searchedText:)]) {
        [self.delegate searchedText:self.searchTextField.text];
    }
}

@end
