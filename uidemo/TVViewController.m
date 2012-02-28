//
//  TVViewController.m
//  uidemo
//
//  Created by Bryce Redd on 2/28/12.
//  Copyright (c) 2012 Itv. All rights reserved.
//

#import "TVViewController.h"
#import "ARLPuffLayer.h"
#import "TVMacros.h"
#import "ASIHTTPRequest.h"
#import "NSTimer+Block.h"
#import "NSString+MD5.h"



@interface TVViewController () {
    BOOL demo1inProgress;
}
@property(nonatomic, strong) NSMutableArray* images;
@end

@implementation TVViewController
@synthesize scroll;
@synthesize rob, images;

- (void)viewDidLoad {
    [super viewDidLoad];
	
    for(NSString* email in [NSArray arrayWithObjects:@"bryce@i.tv", @"sean@i.tv", @"addison@i.tv", @"rob@i.tv", @"robmerrell@i.tv", @"cody@i.tv", nil]) {

        NSString* urlString = [NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@", [email MD5]];
        
        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
        request.requestMethod = @"GET";
        
        __block int left = 0;
        __block int top = 0;
        [request setCompletionBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage* face = [UIImage imageWithData:request.responseData];
                UIImageView* imageView = [[UIImageView alloc] initWithImage:face];
                
                [self.scroll addSubview:imageView];
                setFrameX(imageView, left);
                setFrameY(imageView, top);
                
                left += 30;
                top += 30;
            });
        }];
        
        [request startAsynchronous];
    }
    
    self.scroll.contentSize = CGSizeMake(400, 0);
}

- (void)viewDidUnload {
    [self setRob:nil];
    [self setScroll:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)demo1:(id)sender {
    if(demo1inProgress) {
        demo1inProgress = NO;
        return;
    }
    
    demo1inProgress = YES;
    
    
    CAShapeLayer* mask = [CAShapeLayer layer];
    mask.frame = (CGRect){CGPointZero, rob.frame.size};
    [rob.layer addSublayer:mask];
    
    rob.layer.mask = mask;
    rob.layer.masksToBounds = YES;
    
    
    __block int rotatePercent = 0;
    [NSTimer scheduledTimerWithTimeInterval:.01 block:^(NSTimer* timer) {
        if(!demo1inProgress) {
            [timer invalidate];
            return;
        }
        
        rotatePercent++;
        rotatePercent %= 200;
        
        BOOL isWaxing = rotatePercent < 100;
        
        CGPoint center = CGPointMake(mask.frame.size.width/2.f, mask.frame.size.height/2.f);
        float angle = M_PI*2* (((float)rotatePercent)/100.f);
        
        
        UIBezierPath* path = [UIBezierPath bezierPath];
        [path moveToPoint:center];
        [path addLineToPoint:CGPointMake(center.x, 0)];
        [path addArcWithCenter:center radius:center.x startAngle:-M_PI_2 endAngle:angle-M_PI_2 clockwise:isWaxing];
        [path addLineToPoint:center];
        
        mask.path = path.CGPath;
        
    } repeats:YES];
}

- (IBAction)demo2:(id)sender {
    float bounciness = .2; // between 0-1, lower = less bouncy

    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    view.backgroundColor = [UIColor blackColor];
    view.layer.cornerRadius = 30.f;    
    [self.view addSubview:view];
    
    
    centerView(view);

    void(^remove)() = ^{
        [UIView animateWithDuration:.5 animations:^{
            view.alpha = 0.f;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    };

    
    __block float currentScale = .1f;
    __block CGRect frame = view.frame;
    __block void(^bounce)();
    
    view.frame = scaleRect(view.frame, .1);
    
    bounce = ^{
        [UIView animateWithDuration:.25 animations:^{
            float scale = 1 + (1 - currentScale) * bounciness;
            
            if(currentScale > .95 && currentScale < 1.05) { scale = 1; }
                    
            view.frame = scaleRect(frame, scale);
            
            currentScale = scale;
            
            NSLog(@"setting scale to %f", scale);
        } completion:^(BOOL completed) {
            if(currentScale == 1) { remove(); return; }
            
            bounce();
        }];
    };
    
    bounce();
    
    
}

- (IBAction)demo3:(id)sender {
    ARLPuffLayer* puff = [ARLPuffLayer layer];
    puff.position = [(UIButton*)sender center];
    [self.view.layer addSublayer:puff];
    
    [self.view bringSubviewToFront:sender];
    
    [NSTimer scheduledTimerWithTimeInterval:.01 block:^(NSTimer* timer) {
        [puff setBirthRate:0];
        //[puff removeFromSuperlayer];
     } repeats:NO];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    float parallax = 1.2f;
    
    int i = 1;
    for(UIImageView* imageView in scrollView.subviews) {
        setFrameX(imageView, scrollView.contentOffset.x * parallax * i);
        setFrameY(imageView, scrollView.contentOffset.y * parallax * i);
        i++;
    }
}

@end
