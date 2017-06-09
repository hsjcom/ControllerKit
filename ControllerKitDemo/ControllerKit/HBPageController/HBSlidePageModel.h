//
//  HBSlidePageModel.h
//  TaQu
//
//  Created by Soldier on 16/3/30.
//  Copyright © 2016年 厦门海豹信息技术. All rights reserved.
//

#import "HBModel.h"

@interface HBSlidePageModel : HBModel

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) CGFloat contentOffsetY;

//扩展，用来处理二层slider的情况 - QDFish （不影响之前写好的sliderPage）

//两层时needIndex置为YES,启用index来作为该model身为子model的下标。而pageIndex则仍然为该model的子model的当前下标
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL needIndex;

@end
