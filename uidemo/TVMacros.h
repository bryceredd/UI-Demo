/*
 *  TVMacros.h
 *  tvclient
 *
 *  Created by Bryce Redd on 7/1/10.
 *  Copyright 2010 i.TV LLC. All rights reserved.
 *
 */

#define centerView(__viewA__) { __viewA__.frame = CGRectMake((int)(__viewA__.superview.frame.size.width/2.f - __viewA__.frame.size.width/2.f), (int)(__viewA__.superview.frame.size.height/2.f - __viewA__.frame.size.height/2.f), (int)(__viewA__.frame.size.width), (int)(__viewA__.frame.size.height)); }

#define scaleRect(_rect_, _scale_) CGRectMake((int)(_rect_.origin.x+(_rect_.size.width-(_rect_.size.width*_scale_))/2.f), (int)(_rect_.origin.y+(_rect_.size.height-(_rect_.size.height*_scale_))/2.f), (int)(_rect_.size.width*_scale_), (int)(_rect_.size.height*_scale_));

#define setFrameX(_a_, _x_) { CGRect tempframe = _a_.frame; tempframe.origin.x = _x_; _a_.frame = tempframe; }
#define setFrameY(_a_, _y_) { CGRect tempframe = _a_.frame; tempframe.origin.y = _y_; _a_.frame = tempframe; }
