//
//  CLMCounterCell.m
//  Counter
//
//  Created by Andrew Hulsizer on 7/1/13.
//  Copyright (c) 2013 Classy Monsters. All rights reserved.
//

#import "CLMCounterCell.h"
#import "CLMSlideCountGesture.h"

#define INITAL_POINT 266

@interface CLMCounterCell () <CLMSlideCountGestureDelegate>

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) IBOutlet UILabel *pullLabel;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *counterLabel;
@property (nonatomic, strong) IBOutlet UIView *labelView;
@property (nonatomic, strong) IBOutlet UIView *counterView;
@property (nonatomic, strong) CLMSlideCountGesture *slideCountGesture;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *horizontalConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *counterConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *pullLabelConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *titleLabelonstraint;
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
		self.counterLabel.transform = CGAffineTransformMakeScale(.75, .75);
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
    if (distance < 0)
    {
        self.horizontalConstraint.constant = INITAL_POINT-(distance*0.09);
        self.counterConstraint.constant = (distance*0.09);
    }else{
        self.horizontalConstraint.constant = INITAL_POINT-(distance*0.5);
        self.counterConstraint.constant = (distance*0.5);
    }
    
    [self layoutIfNeeded];

    
    NSString *newText = [NSString stringWithFormat:@"%d",self.count+distance/25];
    if (![newText isEqualToString:self.counterLabel.text])
    {
        
        self.counterLabel.text = [NSString stringWithFormat:@"%d",self.count+(distance/25)];
        
               
        [UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.counterLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.counterLabel.transform = CGAffineTransformMakeScale(.65, .65);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:.1 animations:^{
                    self.counterLabel.transform = CGAffineTransformMakeScale(.75, .75);
                }];
            }];

        }];

    }
}

- (void)counterDistanceBegan
{

}
- (void)counterDistanceEnded:(NSInteger)distance
{
    self.count += (distance/25);
    NSInteger passOne = (INITAL_POINT-self.horizontalConstraint.constant)/10.0f;
    NSInteger passTwo = passOne/2.0f;
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
     {
         self.horizontalConstraint.constant = INITAL_POINT+passOne;
         self.counterConstraint.constant = -passOne;
         [self layoutIfNeeded];
     } completion:^(BOOL finished) {
         [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
          {
              self.horizontalConstraint.constant = INITAL_POINT-passTwo;
              self.counterConstraint.constant = +passTwo;
              [self layoutIfNeeded];
          } completion:^(BOOL finished) {
              [UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
               {
                   self.horizontalConstraint.constant = INITAL_POINT;
                   self.counterConstraint.constant = 0;
                   [self layoutIfNeeded];
               } completion:^(BOOL finished) {
                   
               }];
          }];
     }];
}

@end
