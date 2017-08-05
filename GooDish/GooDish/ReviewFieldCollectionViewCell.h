//
//  ReviewFieldCollectionViewCell.h
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-08-05.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewFieldCollectionViewCell : UICollectionViewCell <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *reviewTextField;
@end
