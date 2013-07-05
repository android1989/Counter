//
//  CLMCounterCell.m
//  Counter
//
//  Created by Andrew Hulsizer on 7/1/13.
//  Copyright (c) 2013 Classy Monsters. All rights reserved.
//

#import "CLMCounterCell.h"
#import "CLMSlideCountGesture.h"
#import "MathHelpers.h"
#import "UIColor+CLMColors.h"

#define INITAL_POINT 266

@interface CLMCounterCell () <CLMSlideCountGestureDelegate>

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) IBOutlet UILabel *pullLabel;
@property (nonatomic, strong) IBOutlet UILabel *pushLabel;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *counterLabel;
@property (nonatomic, strong) IBOutlet UIView *labelView;
@property (nonatomic, strong) IBOutlet UIView *counterView;
@property (nonatomic, strong) CLMSlideCountGesture *slideCountGesture;
@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, strong) CAShapeLayer *pullLayer;
@end

@implementation CLMCounterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        [self.contentView addSubview:view];
        self.contentView.frame = view.frame;
        
        [self setBackgroundColor:[UIColor clearColor]];
		
		self.slideCountGesture = [[CLMSlideCountGesture alloc] initWithView:self];
		self.slideCountGesture.delegate = self;
		
		///COMMENT THIS OUT
        //self.counterLabel.layer.anchorPoint = CGPointMake(0, 0);
		//self.counterLabel.transform = CGAffineTransformMakeScale(.75, .75);
		
		
    }
    return self;
}

- (CAShapeLayer *)pullLayer
{
	if (!_pullLayer)
	{
		_pullLayer = [[CAShapeLayer alloc] init];
		_pullLayer.fillColor = [UIColor colorWithRed:239/255.0f green:80/255.0f blue:105/255.0f alpha:1].CGColor;
		CGPathRef path = [self makePullPathForDistance:0];
		_pullLayer.path = path;
	}
	return _pullLayer;
}

- (void)layoutSubviews
{
	if (![self.pullLayer superlayer]) {
		[self.layer insertSublayer:self.pullLayer atIndex:0];
		[self bringSubviewToFront:self.counterLabel];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)counterDistanceUpdated:(NSInteger)distance
{
	self.distance = distance;
	self.pullLayer.path = [self makePullPathForDistance:distance];
	
    CGFloat uidistance = distance;
    if (uidistance>0)
    {
        uidistance *= 0.5;
    }else{
        uidistance *=0.1;
    }
    [self.labelView setFrame:CGRectMake(0, 0, INITAL_POINT-uidistance, CGRectGetHeight(self.frame))];
    [self.counterView setFrame:CGRectMake(INITAL_POINT-uidistance, 0, CGRectGetWidth(self.frame)-INITAL_POINT+uidistance, CGRectGetHeight(self.frame))];
    
    NSString *newText = [NSString stringWithFormat:@"%d",self.count+distance/25];
    if (![newText isEqualToString:self.counterLabel.text])
    {
        
        self.counterLabel.text = [NSString stringWithFormat:@"%d",self.count+(distance/25)];
        
               
//        [UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            self.counterLabel.transform = CGAffineTransformIdentity;
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                self.counterLabel.transform = CGAffineTransformMakeScale(.65, .65);
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:.1 animations:^{
//                    self.counterLabel.transform = CGAffineTransformMakeScale(.75, .75);
//                }];
//            }];
//
//        }];

    }
}

- (void)counterDistanceBegan
{
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
  {
      [self.titleLabel setFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMinY(self.titleLabel.frame)+100, CGRectGetWidth(self.titleLabel.frame), CGRectGetHeight(self.titleLabel.frame))];
      [self.pullLabel setFrame:CGRectMake(CGRectGetMinX(self.pullLabel.frame), CGRectGetMinY(self.pullLabel.frame)+100, CGRectGetWidth(self.pullLabel.frame), CGRectGetHeight(self.pullLabel.frame))];
	  
	  [self.pushLabel setFrame:CGRectMake(CGRectGetMinX(self.pullLabel.frame), CGRectGetMinY(self.pullLabel.frame)+100, CGRectGetWidth(self.pullLabel.frame), CGRectGetHeight(self.pullLabel.frame))];
      
  } completion:^(BOOL finished) {
        }];


}
- (void)counterDistanceEnded:(NSInteger)distance
{
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
     {
         [self.titleLabel setFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMinY(self.titleLabel.frame)-100, CGRectGetWidth(self.titleLabel.frame), CGRectGetHeight(self.titleLabel.frame))];
         [self.pullLabel setFrame:CGRectMake(CGRectGetMinX(self.pullLabel.frame), CGRectGetMinY(self.pullLabel.frame)-100, CGRectGetWidth(self.pullLabel.frame), CGRectGetHeight(self.pullLabel.frame))];
		 
		 [self.pushLabel setFrame:CGRectMake(CGRectGetMinX(self.pullLabel.frame), CGRectGetMinY(self.pullLabel.frame)-100, CGRectGetWidth(self.pullLabel.frame), CGRectGetHeight(self.pullLabel.frame))];
         
     } completion:^(BOOL finished) {
     }];
    
    self.count += (distance/25);
    NSInteger passOne = (INITAL_POINT-CGRectGetWidth(self.labelView.frame))/10.0f;
    NSInteger passTwo = passOne/2.0f;
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
     {
         [self.labelView setFrame:CGRectMake(0, 0, INITAL_POINT+passOne, CGRectGetHeight(self.frame))];
         [self.counterView setFrame:CGRectMake(INITAL_POINT+passOne, 0, CGRectGetWidth(self.frame)-INITAL_POINT-passOne, CGRectGetHeight(self.frame))];
		 
		 [self animatePullEnded:-passOne duration:.3];
		 
     } completion:^(BOOL finished) {
         [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^
          {
              [self.labelView setFrame:CGRectMake(0, 0, INITAL_POINT-passTwo, CGRectGetHeight(self.frame))];
              [self.counterView setFrame:CGRectMake(INITAL_POINT-passTwo, 0, CGRectGetWidth(self.frame)-INITAL_POINT+passTwo, CGRectGetHeight(self.frame))];
			  
			  [self animatePullEnded:passTwo duration:.2];
          } completion:^(BOOL finished) {
              [UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^
               {
                   [self.labelView setFrame:CGRectMake(0, 0, INITAL_POINT, CGRectGetHeight(self.frame))];
                   [self.counterView setFrame:CGRectMake(INITAL_POINT, 0, CGRectGetWidth(self.frame)-INITAL_POINT, CGRectGetHeight(self.frame))];
				   
				   [self animatePullEnded:0 duration:.1];
               } completion:^(BOOL finished) {
                   
               }];
          }];
     }];
}

#pragma mark - Bezier Paths
- (void)animatePullEnded:(NSInteger)offset duration:(CGFloat)duration
{
	CGPathRef oldPath = self.pullLayer.path;
	CGPathRef newPath = [self makePullPathForDistance:offset];
	CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath: @"path"];
	animation.duration = duration;
	animation.delegate = self;
	animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
	animation.repeatCount = 1;
	animation.autoreverses = NO;
	animation.fromValue = (__bridge id) oldPath;
	animation.toValue = (__bridge id) newPath;
	self.pullLayer.path = newPath;
	[self.pullLayer addAnimation: animation forKey: @"animatePath"];
	
	CGPathRelease(newPath);
}

- (CGMutablePathRef)makePullPathForDistance:(NSInteger)distance
{
	CGPoint topLeft = CGPointMake(CGRectGetMinX(self.counterView.frame), CGRectGetMinY(self.counterView.frame));
	CGPoint topMid = CGPointMake(CGRectGetMidX(self.counterView.frame), CGRectGetMinY(self.counterView.frame)+distance/5);
	CGPoint topRight = CGPointMake(CGRectGetMaxX(self.counterView.frame), CGRectGetMinY(self.counterView.frame));
	CGPoint bottomLeft = CGPointMake(CGRectGetMinX(self.counterView.frame), CGRectGetMaxY(self.counterView.frame));
	CGPoint bottomMid = CGPointMake(CGRectGetMidX(self.counterView.frame), CGRectGetMaxY(self.counterView.frame)-distance/5);
	CGPoint bottomRight = CGPointMake(CGRectGetMaxX(self.counterView.frame), CGRectGetMaxY(self.counterView.frame));
	
	CGMutablePathRef pathRef = CGPathCreateMutable();
	CGPathMoveToPoint(pathRef, nil, bottomLeft.x, bottomLeft.y);
	CGPathAddLineToPoint(pathRef, nil, topLeft.x, topLeft.y);
	
	//Left top curve
    CGPoint leftCp1 = CGPointMake(lerp(topLeft.x, topMid.x, 1), lerp(topLeft.y, topMid.y, 0.5));
    CGPoint leftCp2 = CGPointMake(lerp(topLeft.x, topMid.x, 1), lerp(topLeft.y, topMid.y, 0.5));
    CGPoint leftDestination = topRight;
    
    CGPathAddCurveToPoint(pathRef, NULL, leftCp1.x, leftCp1.y, leftCp2.x, leftCp2.y, leftDestination.x, leftDestination.y);
	
	CGPathAddLineToPoint(pathRef, nil, bottomRight.x, bottomRight.y);
	

	//Right top curve
	CGPoint rightTopCp2 = CGPointMake(lerp(bottomRight.x, bottomMid.x, 1), lerp(bottomRight.y, bottomMid.y, 0.5));
	CGPoint rightTopCp1 = CGPointMake(lerp(bottomRight.x, bottomMid.x, 1), lerp(bottomRight.y, bottomMid.y, 0.5));
	CGPoint rightTopDestination = bottomLeft;
	
	CGPathAddCurveToPoint(pathRef, NULL, rightTopCp1.x, rightTopCp1.y, rightTopCp2.x, rightTopCp2.y, rightTopDestination.x, rightTopDestination.y);
	
	CGPathCloseSubpath(pathRef);
	
	return pathRef;
}

@end
