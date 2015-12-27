//
//  ShowImageViewController.m
//  gjdryz
//
//  Created by AllPepole on 15/12/9.
//
//

#import "ShowImageViewController.h"
#import "UIImageView+ImageViewExtension.h"
@interface ShowImageViewController ()<UIScrollViewDelegate>
{
    CGFloat offset;
}
@property (assign,nonatomic)float scale;


@end

@implementation ShowImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.scrollView.contentSize = CGSizeMake(ScreenWidth*_imageArray.count,ScreenHeight_NoNavigat);
    
    if (_imageArray.count) {
        self.pageLable.text = [NSString stringWithFormat:@"%ld/%ld",_imageIndex+1,_imageArray.count];
    }
    else
        self.pageLable.text = @"0/0";
    
    for (int i =0; i<_imageArray.count; i++) {
        
        UIScrollView* scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenHeight_NoNavigat)];
        scroll.backgroundColor = [UIColor clearColor];
        scroll.contentSize = CGSizeMake(ScreenWidth,ScreenHeight_NoNavigat);
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        scroll.bounces = NO;
        scroll.delegate = self;
        scroll.minimumZoomScale = 1.0;
        scroll.maximumZoomScale = 2.0;
        scroll.tag = i+1;
        [scroll setZoomScale:1.0];
        
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight_NoNavigat)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pinchImage:)];
        [tap setNumberOfTouchesRequired:2];
        [imageView addGestureRecognizer:tap];
        imageView.tag = i+1;
        
        [scroll addSubview:imageView];
        [self.scrollView addSubview:scroll];
        
        NSString*url = [NSString stringWithFormat:@"%@%@",DOWNIMAGE_URL,_imageArray[i]];
        [imageView loadImageWithUrl:url plcaeHodel:nil blcok:nil];
    }
    
    
    [self.scrollView setContentOffset:CGPointMake(self.imageIndex*ScreenWidth, 0)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pinchImage:(UITapGestureRecognizer*)gesture
{
    float newScale = [(UIScrollView*)gesture.view.superview zoomScale] * 1.5;
    CGRect zoomRect = [self zoomRectForScale:newScale  inView:(UIScrollView*)gesture.view.superview withCenter:[gesture locationInView:gesture.view]];
    UIView *view = gesture.view.superview;
    if ([view isKindOfClass:[UIScrollView class]]){
        UIScrollView *s = (UIScrollView *)view;
        [s zoomToRect:zoomRect animated:YES];
    }
}

- (IBAction)goBack:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -----scrollView Delegate-------

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    for (UIView*view in scrollView.subviews) {
        return view;
    }
    return nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        CGFloat x = scrollView.contentOffset.x;
        _imageIndex = x/ScreenWidth;
        self.pageLable.text = [NSString stringWithFormat:@"%ld/%ld",_imageIndex+1,(unsigned long)_imageArray.count];
        if (x == offset) {
            
        }
        else
        {
            offset = x;
            for (UIScrollView* scroll in self.scrollView.subviews) {
                if ([scroll isKindOfClass:[UIScrollView class]]) {
                    [scroll setZoomScale:1.0];
                }
                UIImageView* imageView = [[scroll subviews] objectAtIndex:0];
                imageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight_NoNavigat);
            }
        }
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    UIView* view = [scrollView.subviews objectAtIndex:0];
    if ([view isKindOfClass:[UIImageView class]]) {
        if (scrollView.zoomScale<1.0) {
//            view.center = CGPointMake(scrollView.frame.size.width/2.0, scrollView.frame.size.height/2.0);
        }
    }
}

#pragma mark - Utility methods

-(CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    zoomRect.size.height = [scrollView frame].size.height / scale;
    zoomRect.size.width  = [scrollView frame].size.width  / scale;
    
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

-(CGRect)resizeImageSize:(CGRect)rect{
    //    NSLog(@"x:%f y:%f width:%f height:%f ", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    CGRect newRect;
    
    CGSize newSize;
    CGPoint newOri;
    
    CGSize oldSize = rect.size;
    if (oldSize.width>=320.0 || oldSize.height>=460.0){
        float scale = (oldSize.width/320.0>oldSize.height/460.0?oldSize.width/320.0:oldSize.height/460.0);
        newSize.width = oldSize.width/scale;
        newSize.height = oldSize.height/scale;
    }
    else {
        newSize = oldSize;
    }
    newOri.x = (320.0-newSize.width)/2.0;
    newOri.y = (460.0-newSize.height)/2.0;
    
    newRect.size = newSize;
    newRect.origin = newOri;
    
    return newRect;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    _imageIndex = scrollView.contentOffset.x/ScreenWidth;
//    
//    self.pageLable.text = [NSString stringWithFormat:@"%ld/%ld",_imageIndex+1,_imageArray.count];
//}

@end
