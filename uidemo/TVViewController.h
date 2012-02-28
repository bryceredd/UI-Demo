//
//  TVViewController.h
//  uidemo
//
//  Created by Bryce Redd on 2/28/12.
//  Copyright (c) 2012 Itv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *rob;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

- (IBAction)demo1:(id)sender;
- (IBAction)demo2:(id)sender;
- (IBAction)demo3:(id)sender;

@end
