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
      
  } completion:^(BOOL finished) {
        }];


}
- (void)counterDistanceEnded:(NSInteger)distance
{
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
     {
         [self.titleLabel setFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMinY(self.titleLabel.frame)-100, CGRectGetWidth(self.titleLabel.frame), CGRectGetHeight(self.titleLabel.frame))];
         [self.pullLabel setFrame:CGRectMake(CGRectGetMinX(self.pullLabel.frame), CGRectGetMinY(self.pullLabel.frame)-100, CGRectGetWidth(self.pullLabel.frame), CGRectGetHeight(self.pullLabel.frame))];
         
     } completion:^(BOOL finished) {
     }];
    
    self.count += (distance/25);
    NSInteger passOne = (INITAL_POINT-CGRectGetWidth(self.labelView.frame))/10.0f;
    NSInteger passTwo = passOne/2.0f;
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
     {
         [self.labelView setFrame:CGRectMake(0, 0, INITAL_POINT+passOne, CGRectGetHeight(self.frame))];
         [self.counterView setFrame:CGRectMake(INITAL_POINT+passOne, 0, CGRectGetWidth(self.frame)-INITAL_POINT-passOne, CGRectGetHeight(self.frame))];
     } completion:^(BOOL finished) {
         [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^
          {
              [self.labelView setFrame:CGRectMake(0, 0, INITAL_POINT-passTwo, CGRectGetHeight(self.frame))];
              [self.counterView setFrame:CGRectMake(INITAL_POINT-passTwo, 0, CGRectGetWidth(self.frame)-INITAL_POINT+passTwo, CGRectGetHeight(self.frame))];
          } completion:^(BOOL finished) {
              [UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^
               {
                   [self.labelView setFrame:CGRectMake(0, 0, INITAL_POINT, CGRectGetHeight(self.frame))];
                   [self.counterView setFrame:CGRectMake(INITAL_POINT, 0, CGRectGetWidth(self.frame)-INITAL_POINT, CGRectGetHeight(self.frame))];
               } completion:^(BOOL finished) {
                   
               }];
          }];
     }];
}

@end
