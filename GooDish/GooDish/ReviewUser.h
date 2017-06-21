//
//  ReviewUser.h
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-21.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReviewUser : NSObject

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *profileImageUrl;

- (id)initWithReviewUser:(NSDictionary *)user;

@end
