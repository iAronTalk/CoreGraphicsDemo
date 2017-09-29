//
//  ViewController.m
//  CoreGraphicsDemos
//
//  Created by Qi Xin on 28/9/2017.
//  Copyright © 2017 Qi Xin. All rights reserved.
//

#import "ViewController.h"

#import "CGTransformsView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CGTransformsView *displayView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setNeedsDisplay];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
