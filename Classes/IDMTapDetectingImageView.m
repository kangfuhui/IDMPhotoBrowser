//
//  IDMTapDetectingImageView.m
//  IDMPhotoBrowser
//
//  Created by Michael Waterfall on 04/11/2009.
//  Copyright 2009 d3i. All rights reserved.
//

#import "IDMTapDetectingImageView.h"

@interface IDMTapDetectingImageView ()<UIActionSheetDelegate>
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
@end

@implementation IDMTapDetectingImageView

@synthesize tapDelegate;

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.userInteractionEnabled = YES;
        [self addGestureRecognizer:self.longPressGesture];
	}
	return self;
}

- (id)initWithImage:(UIImage *)image {
	if ((self = [super initWithImage:image])) {
		self.userInteractionEnabled = YES;
        [self addGestureRecognizer:self.longPressGesture];
	}
	return self;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
	if ((self = [super initWithImage:image highlightedImage:highlightedImage])) {
		self.userInteractionEnabled = YES;
        [self addGestureRecognizer:self.longPressGesture];
	}
	return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	NSUInteger tapCount = touch.tapCount;
	switch (tapCount) {
		case 1:
			[self handleSingleTap:touch];
			break;
		case 2:
			[self handleDoubleTap:touch];
			break;
		case 3:
			[self handleTripleTap:touch];
			break;
		default:
			break;
	}
	[[self nextResponder] touchesEnded:touches withEvent:event];
}

- (void)handleSingleTap:(UITouch *)touch {
	if ([tapDelegate respondsToSelector:@selector(imageView:singleTapDetected:)])
		[tapDelegate imageView:self singleTapDetected:touch];
}

- (void)handleDoubleTap:(UITouch *)touch {
	if ([tapDelegate respondsToSelector:@selector(imageView:doubleTapDetected:)])
		[tapDelegate imageView:self doubleTapDetected:touch];
}

- (void)handleTripleTap:(UITouch *)touch {
	if ([tapDelegate respondsToSelector:@selector(imageView:tripleTapDetected:)])
		[tapDelegate imageView:self tripleTapDetected:touch];
}

- (void)handleLongPress:(UILongPressGestureRecognizer*)longPressGesture{
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
        if ([tapDelegate respondsToSelector:@selector(imageView:longPressed:)]) {
            [tapDelegate imageView:self longPressed:longPressGesture];
        }
    }
}

#pragma -mark getters & setters
- (UILongPressGestureRecognizer*)longPressGesture
{
    if (!_longPressGesture) {
        _longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
        self.userInteractionEnabled = YES;
    }
    return _longPressGesture;
}
@end
