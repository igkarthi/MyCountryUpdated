//
//  RBSavedSearchTableViewCell.m
//  RentersBlock
//
//  Created by 53 on 24/04/15.
//  Copyright (c) 2015 smaat. All rights reserved.
//

#import "MyCountryListTableViewCell.h"

@implementation MyCountryListTableViewCell
@synthesize imgImageView, lblTitle, lblDescription;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withLabelHeight:(CGFloat)lblHeight{
    
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
      
        [self createCellControl];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setContraints:(CGFloat)lblHeight withWidth:(CGFloat)lblWidth{
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:lblTitle attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:lblTitle attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:lblTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:lblTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:20];
    
    [self addConstraints:@[trailing, leading, top, height]];
    
    
    
    NSLayoutConstraint *leadingImg = [NSLayoutConstraint constraintWithItem:imgImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:5.0];
    
    NSLayoutConstraint *topImg = [NSLayoutConstraint constraintWithItem:imgImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:lblTitle attribute:NSLayoutAttributeTop multiplier:1.0 constant:25];
    
    NSLayoutConstraint *widthImg = [NSLayoutConstraint constraintWithItem:imgImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:50];
    
    NSLayoutConstraint *heightImg = [NSLayoutConstraint constraintWithItem:imgImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:50];
    
    [self addConstraints:@[topImg, leadingImg, widthImg, heightImg]];
    
    
    //label desc
    NSLayoutConstraint *lblLeading = [NSLayoutConstraint constraintWithItem:lblDescription attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:5];
    
    NSLayoutConstraint *lblTop = [NSLayoutConstraint constraintWithItem:lblDescription attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imgImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:55];
    
    NSLayoutConstraint *lblHeightConstraint = [NSLayoutConstraint constraintWithItem:lblDescription attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:lblHeight];
    
    NSLayoutConstraint *lblWidthConstraint = [NSLayoutConstraint constraintWithItem:lblDescription attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:lblWidth];
    
    
    
    [self addConstraints:@[lblLeading,lblWidthConstraint, lblTop, lblHeightConstraint]];
}

-(void)createCellControl{
   
    lblTitle = [[UILabel alloc]init];
    lblTitle.font = [UIFont systemFontOfSize:12];
    lblTitle.backgroundColor = [UIColor lightGrayColor];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    lblTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:lblTitle];
    
    
    //image constraint
    
    imgImageView = [[UIImageView alloc]init];
    imgImageView.backgroundColor = [UIColor lightGrayColor];
    imgImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:imgImageView];
    
    
    lblDescription = [[UILabel alloc]init];
    lblDescription.font = [UIFont systemFontOfSize:12];
    lblDescription.numberOfLines = 0;
    [lblDescription setLineBreakMode:NSLineBreakByWordWrapping];
    [lblDescription setTextAlignment:NSTextAlignmentLeft];
    lblDescription.translatesAutoresizingMaskIntoConstraints = NO;
    [lblDescription setMinimumScaleFactor:0.5];
    [lblDescription setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
    [self addSubview:lblDescription];
    
    
    
}

@end
