//
//  CLMCounterCell.m
//  Counter
//
//  Created by Andrew Hulsizer on 7/1/13.
//  Copyright (c) 2013 Classy Monsters. All rights reserved.
//

#import "CLMCounterCell.h"
#import "CLMSlideCountGesture.h"

@interface CLMCounterCell () <CLMSlideCountGestureDelegate>

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *counterLabel;
@property (nonatomic, strong) IBOutlet UIView *labelView;
@property (nonatomic, strong) IBOutlet UIView *counterView;
@property (nonatomic, strong) CLMSlideCountGesture *slideCountGesture;
@end

@implementation CLMCounterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        [self.contentView addSubview:view];
        self.frame = view.frame;
        [self setBackgroundColor:[UIColor clearColor]];
		
		self.slideCountGesture = [[CLMSlideCountGesture alloc] initWithView:self.labelView];
		self.slideCountGesture.delegate = self;
		
		///COMMENT THIS OUT
		//self.counterLabel.transform = CGAffineTransformMakeScale(.75, .75);
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)counterDistanceUpdated:(NSInteger)distance
{
	self.counterLabel.text = [NSString stringWithFormat:@"%d",distance];
	CGFloat width = CGRectGetWidth(self.frame);
	
	self.labelView.frame = CGRectMake(CGRectGetMinX(self.labelView.frame), CGRectGetMinY(self.labelView.frame), 266-distance, CGRectGetHeight(self.labelView.frame));
	
	self.counterView.frame = CGRectMake(CGRectGetMaxX(self.labelView.frame), CGRectGetMinY(self.labelView.frame), width-CGRectGetMaxX(self.labelView.frame), CGRectGetHeight(self.counterView.frame));
	
	NSLog(@"%f %f : %f %f", CGRectGetMinX(self.labelView.frame),CGRectGetMinY(self.labelView.frame),CGRectGetWidth(self.labelView.frame),CGRectGetHeight(self.labelView.frame) );
	NSLog(@"%f %f : %f %f", CGRectGetMinX(self.counterView.frame),CGRectGetMinY(self.counterView.frame),CGRectGetWidth(self.counterView.frame),CGRectGetHeight(self.counterView.frame) );
	
//	[UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//		self.counterLabel.transform = CGAffineTransformIdentity;
//	} completion:^(BOOL finished) {
//		[UIView animateWithDuration:.25 animations:^{
//			self.counterLabel.transform = CGAffineTransformMakeScale(.49, .49);
//		}];
//	}];
}
@end
