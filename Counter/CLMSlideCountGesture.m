//
//  CLMSlideCountGesture.m
//  Counter
//
//  Created by Andrew Hulsizer on 7/1/13.
//  Copyright (c) 2013 Classy Monsters. All rights reserved.
//

#import "CLMSlideCountGesture.h"

@interface CLMSlideCountGesture ()

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, assign) NSInteger distance;
@end
@implementation CLMSlideCountGesture

- (instancetype)initWithView:(UIView *)view
{
	self = [super init];
	if (self)
	{
		_view = view;
		_panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
		[_view addGestureRecognizer:_panGestureRecognizer];
		_distance = 0;
	}
	return self;
}

- (void)setDistance:(NSInteger)distance
{
	if (_distance != distance)
	{
		_distance = distance;
		if ([self.delegate respondsToSelector:@selector(counterDistanceUpdated:)])
		{
			[self.delegate counterDistanceUpdated:_distance];
		}
	}
}
- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
	if (panGestureRecognizer.state == UIGestureRecognizerStateBegan)
	{
		
	}
	
	CGPoint translation = [panGestureRecognizer translationInView:self.view];

	self.distance += (-1*translation.x);
	
	[panGestureRecognizer setTranslation:CGPointZero inView:self.view];
	
}

@end
