//
//  Review.h
//  GooDish
//
//  Created by Yas Abdolmaleki on 2017-06-21.
//  Copyright © 2017 Yas Abdolmaleki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject

@property (nonatomic, strong) NSString *ratings;
@property (nonatomic, strong) NSString *numberOfRewievs;

- (id)initWithReview:(NSDictionary *)review;

@end
