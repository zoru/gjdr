//
//  HelpDetailCompleteCell.m
//  gjdryz
//
//  Created by AllPepole on 15/12/8.
//
//

#import "HelpDetailCompleteCell.h"
#import "NSString+StringExtension.h"
#import "UIImageView+ImageViewExtension.h"


@implementation HelpDetailCompleteCell

- (void)awakeFromNib {
    
    self.orderNubLable.text = @" ";
    self.createTimeLab.text = @" ";
    self.processTimeLab.text = @" ";
    self.orderContentLable.text = @" ";
    self.remarkLab.text = @" ";
    self.processInfoLab.text = @" ";
    self.evaluatTextLable.text = @" ";
    self.evaluatDateLable.text = @" ";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrderInfo:(OrderModel *)model
{
    if (![NSString isNullOrEmpty:model.orderNub]) {
        self.orderNubLable.text = model.orderNub;
    }
    else
        self.orderNubLable.text = @" ";
    
    if (![NSString isNullOrEmpty:model.createTime]) {
        self.createTimeLab.text = model.createTime;
    }
    else
        self.createTimeLab.text = @" ";
    
    if (![NSString isNullOrEmpty:model.processTime]) {
        self.processTimeLab.text = model.processTime;
    }
    else
        self.processTimeLab.text = @" ";
    
    
    if (![NSString isNullOrEmpty:model.orderContent]) {
        self.orderContentLable.text = model.orderContent;
    }
    else
         self.orderContentLable.text = @" ";
    
    if (model.images && model.images.count) {
        self.pageControl.hidden = NO;
        self.pageControl.numberOfPages = model.images.count;
        self.pageControl.currentPage = 0;
        self.pageControl.hidesForSinglePage = YES;
        
        self.imageScrollView.hidden = NO;
        self.imageScrollView.delegate = self;
        self.imageScrollView.contentSize = CGSizeMake(self.imageScrollView.frame.size.width*model.images.count,self.imageScrollView.frame.size.height);
        self.imageScrollView.pagingEnabled = YES;
        self.imageScrollView.showsHorizontalScrollIndicator = NO;
        self.imageScrollView.showsVerticalScrollIndicator = NO;
        self.imageScrollView.bounces = NO;
        
        for (int i = 0; i< model.images.count; i++) {
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.imageScrollView.frame.size.width, 0, self.imageScrollView.frame.size.width, self.imageScrollView.frame.size.height)];
            
            imageView.tag = 100+i;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
            [imageView addGestureRecognizer:tap];
            [self.imageScrollView addSubview:imageView];
            
            NSString*url = [NSString stringWithFormat:@"%@%@",DOWNIMAGE_URL,model.images[i]];
            [imageView loadImageWithUrl:url];
        }
        
    }
    else
    {
        self.pageControl.hidden = YES;
        self.imageScrollView.hidden = YES;
    }

    
    if (![NSString isNullOrEmpty:model.remark]) {
        self.remarkLab.text = model.remark;
    }
    else
        self.remarkLab.text = @" ";
    
    if (![NSString isNullOrEmpty:model.processContent]) {
        self.processInfoLab.text = model.processContent;
    }
    else
        self.processInfoLab.text = @" ";
    
    if (![NSString isNullOrEmpty:model.evaluat]) {
        self.evaluatTextLable.text = model.evaluat;
    }
    else
        self.evaluatTextLable.text = @" ";
    
    if (![NSString isNullOrEmpty:model.evaluatTime]) {
        self.evaluatDateLable.text = model.evaluatTime;
    }
    else
        self.evaluatDateLable.text = @" ";

    
    [self.contentView updateConstraints];
    CGRect frame = _percentView.frame;
    [_percentView removeFromSuperview];
    _percentView = nil;
    _percentView = [[CWStarRateView alloc] initWithFrame:frame numberOfStars:5 alloeTouch:NO];
    [_percentView setScorePercent:model.evaluatPercent/5.0f];
    [self.contentView addSubview:_percentView];
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
