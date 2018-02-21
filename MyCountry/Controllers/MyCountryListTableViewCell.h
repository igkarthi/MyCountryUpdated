//
//  RBSavedSearchTableViewCell.h
//  RentersBlock
//
//  Created by 53 on 24/04/15.
//  Copyright (c) 2015 smaat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCountryListTableViewCell : UITableViewCell{
   
}


@property(nonatomic, strong)UIImageView *imgImageView;
@property(nonatomic, strong)UILabel *lblTitle;
@property(nonatomic, strong)UILabel *lblDescription;
@property(nonatomic, strong)UITextView *txtDescription;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withLabelHeight:(CGFloat)lblHeight;
-(void)setContraints:(CGFloat)lblHeight withWidth:(CGFloat)lblWidth;
@end
