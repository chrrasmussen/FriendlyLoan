//
//  FriendTableViewCell.m
//  FriendlyLoan
//
//  Created by Christian Rasmussen on 24.10.11.
//  Copyright (c) 2011 Rasmussen I/O. All rights reserved.
//

#import "FriendTableViewCell.h"

@implementation FriendTableViewCell

@synthesize lastImage;

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

//- (void)willTransitionToState:(UITableViewCellStateMask)state
//{
//    [super willTransitionToState:state];
//    
//    if (state & UITableViewCellStateShowingDeleteConfirmationMask)
//    {
//        self.detailTextLabel.alpha = 0.0;
//    }
//    
//    if (state & UITableViewCellStateShowingEditControlMask)
//    {
//        self.lastImage = self.imageView.image;
//        self.imageView.image = nil;
//    }
//    else
//    {
//        self.imageView.image = self.lastImage;
//        self.lastImage = nil;
//    }
//    
////    NSLog(@"%s %d", _cmd, state);
//}
//
//- (void)didTransitionToState:(UITableViewCellStateMask)state
//{
////    NSLog(@"%s %d", _cmd, state);
//    
//    if (!(state & UITableViewCellStateShowingDeleteConfirmationMask))
//        self.detailTextLabel.alpha = 1.0;
//    
////    if (!(state & UITableViewCellStateShowingEditControlMask))
////    {
////        self.imageView.image = self.lastImage;
////        self.lastImage = nil;
////    }
//    
//    [super didTransitionToState:state];
//}

//- (void)layoutSubviews
//{
//    NSLog(@"%s", (char *)_cmd);
//    CGRect bounds = [self bounds];
//    bounds.size.height -= 1; // leave room for the separator line
//    bounds.size.width += 30; // allow extra width to slide for editing
//    bounds.origin.x -= (self.editing) ? 0 : 30; // start 30px left unless editing
//    [self.contentView setFrame:bounds];
//    
//    [super layoutSubviews];
//}

@end
