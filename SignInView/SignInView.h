//
//  SignInView.h
//  SignInView
//
//  Created by joshuali on 16/6/15.
//  Copyright © 2016年 joshuali. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignInViewDelegate <NSObject>

- (void) onSignInComplete;

@end

@interface SignInView : UIView
@property (nonatomic, weak) id<SignInViewDelegate> delegate;
- (void) reset;
- (void) setHasSigned;
@end
