//
//  UIViewController+TDSemiModalExtension.m
//  TDSemiModal
//
//  Created by Nathan Reed on 18/10/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import "UIViewController+TDSemiModalExtension.h"

@implementation UIViewController (TDSemiModalExtension)

// Use this to show the modal view (pops-up from the bottom)
- (void) presentSemiModalViewController:(TDSemiModalViewController*)vc {
	UIView *modalView = vc.view;
	UIView *coverView = vc.coverView;

	CGPoint center = self.view.center;
	CGSize offSize = [UIScreen mainScreen].bounds.size;
	CGPoint offScreenCenter = CGPointZero;
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];

	if (UIInterfaceOrientationIsLandscape(orientation)) {
		offScreenCenter = CGPointMake(offSize.height / 2.0, offSize.width * 1.2);
		center = CGPointMake(center.y, center.x);
		[modalView setBounds:CGRectMake(0, 0, 480, 300)];
	} else {
		offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.2);
		[modalView setBounds:CGRectMake(0, 0, 320, 460)];
		[coverView setFrame:CGRectMake(0, 0, 320, 460)];
	}
	
	// we start off-screen
	modalView.center = offScreenCenter;
	coverView.alpha = 0.0f;
	
	[self.view addSubview:coverView];
	[self.view addSubview:modalView];
	
	// Show it with a transition effect
    [UIView animateWithDuration:0.6 animations:^(void) {
        modalView.center = center;
        coverView.alpha = 0.5;
    }];
}

// Use this to slide the semi-modal view back down.
-(void) dismissSemiModalViewController:(TDSemiModalViewController*)vc {
	double animationDelay = 0.7;
	UIView *modalView = vc.view;
	UIView *coverView = vc.coverView;

	CGSize screen = [UIScreen mainScreen].bounds.size;
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];

	CGPoint offScreenCenter = UIInterfaceOrientationIsLandscape(orientation) ? CGPointMake(screen.height / 2.0, screen.width * 1.5) : CGPointMake(screen.width / 2.0, screen.height * 1.5);
    
    [UIView animateWithDuration:animationDelay animations:^(void) {
        modalView.center = offScreenCenter;
        coverView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [modalView removeFromSuperview];
        [coverView removeFromSuperview];
    }];
}

@end