//
//  CLMSlideCountGesture.m
//  Counter
//
//  Created by Andrew Hulsizer on 7/1/13.
//  Copyright (c) 2013 Classy Monsters. All rights reserved.
//

#import "CLMSlideCountGesture.h"

@interface CLMSlideCountGesture () <UIGestureRecognizerDelegate>

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
        _panGestureRecognizer.delegate = self;
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
- (void)reset
{
    _distance = 0;
}
- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
	if (panGestureRecognizer.state == UIGestureRecognizerStateBegan)
	{
		[self.delegate counterDistanceBegan];
	}
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        [self.delegate counterDistanceEnded:self.distance];
        [self reset];
        return;
    }
	
	CGPoint translation = [panGestureRecognizer translationInView:self.view];

	self.distance += (-1*translation.x);
	
	[panGestureRecognizer setTranslation:CGPointZero inView:self.view];
	
}


-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    
    // Check for horizontal gesture
    if (fabsf(translation.x) > fabsf(translation.y))
    {
        return YES;
    }
    
    return NO;
}
@end
