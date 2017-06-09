//
//  HBCollectionViewController.m
//  ControllerKitDemo
//
//  Created by Soldier on 2017/6/9.
//  Copyright © 2017年 Shaojie Hong. All rights reserved.
//

#import "HBCollectionViewController.h"

@interface HBCollectionViewController ()

@end




@implementation HBCollectionViewController

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    
    _dataSource = nil;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.page = 1;
        self.items = [NSMutableArray arrayWithCapacity:0];
        self.pullLoadType = PullDefault;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
