//
//  ReviewUser.m
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-21.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import "ReviewUser.h"

@implementation ReviewUser

- (id)initWithReviewUser:(NSDictionary *)user {
    
    self = [self init];
    
    if (self) {
        self.id = [user objectForKey:@"id"];
        self.name = [user objectForKey:@"name"];
        self.profileImageUrl = [user objectForKey:@"profileImageUrl"];
    }
    
    return self;
    
}

@end
