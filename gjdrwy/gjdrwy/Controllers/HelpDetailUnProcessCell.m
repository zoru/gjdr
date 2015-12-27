//
//  HelpDetailUnProcessCell.m
//  gjdrwy
//
//  Created by AllPepole on 15/12/10.
//  Copyright (c) 2015年 AllPepole. All rights reserved.
//

#import "HelpDetailUnProcessCell.h"
#import "UIImageView+ImageViewExtension.h"

@implementation HelpDetailUnProcessCell

- (void)awakeFromNib {
    for(UIView *view in [self.imageScrollerView subviews])
    {
        [view removeFromSuperview];
    }
    

    self.orderNubLable.text = @" ";
    
    self.creatTimeLable.text = @" ";
    
    self.helpContentLable.text = @" ";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setdataWithModel:(OrderModel*)modle
{
    
    if (![NSString isNullOrEmpty:modle.orderNub]) {
        self.orderNubLable.text = modle.orderNub;
    }
    else
        self.orderNubLable.text = @" ";
    
    if (![NSString isNullOrEmpty:modle.createTime]) {
        self.creatTimeLable.text = modle.createTime;
    }
    else
        self.creatTimeLable.text = @" ";
    
    if (![NSString isNullOrEmpty:modle.orderContent]) {
        self.helpContentLable.text = modle.orderContent;
    }
    else
        self.helpContentLable.text = @" ";
    
    if (modle.images.count) {
        self.pageControl.hidden = NO;
        self.pageControl.numberOfPages = modle.images.count;
        self.pageControl.currentPage = 0;
        self.pageControl.hidesForSinglePage = YES;
        
        self.imageScrollerView.hidden = NO;
        self.imageScrollerView.delegate = self;
        self.imageScrollerView.contentSize = CGSizeMake(self.imageScrollerView.frame.size.width*modle.images.count, self.imageScrollerView.frame.size.height);
        self.imageScrollerView.pagingEnabled = YES;
        self.imageScrollerView.showsHorizontalScrollIndicator = NO;
        self.imageScrollerView.showsVerticalScrollIndicator = NO;
        self.imageScrollerView.bounces = NO;
        
        for (int i = 0; i<modle.images.count; i++) {
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.imageScrollerView.frame.size.width, 0, self.imageScrollerView.frame.size.width, self.imageScrollerView.frame.size.height)];
            imageView.tag = 100+i;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
            [imageView addGestureRecognizer:tap];
             [self.imageScrollerView addSubview:imageView];
            
            NSString*url = [NSString stringWithFormat:@"%@%@&&imgwidth=%f&imgheight=%f",DOWNIMAGE_URL,modle.images[i],imageView.bounds.size.width,imageView.bounds.size.height];
            [imageView loadImageWithUrl:url];
        }
        
    }
    else
    {
        self.pageControl.hidden = YES;
        self.imageScrollerView.hidden = YES;
    }
    [self.contentView updateConstraints];
}

- (void)imageViewTap:(UITapGestureRecognizer*)tap
{
    NSInteger imageindex = tap.view.tag - 100;
    
    if ([self.delegate respondsToSelector:@selector(showImageWithIndex:)]) {
        [self.delegate showImageWithIndex:imageindex];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    
    int index = point.x/scrollView.frame.size.width;
    self.pageControl.currentPage = index;
}

@end
