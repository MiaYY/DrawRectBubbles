//
//  ViewController.m
//  DrawRectBubbles
//
//  Created by MOON on 2021/2/22.
//

#import "ViewController.h"
#import "GYBubblesView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view.
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 40)];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClicked:(UIButton *)sender
{
    NSLog(@"点击弹出气泡");
    GYBubblesView *bubblesView = [[GYBubblesView alloc] initWithFrame:CGRectMake(CGRectGetMinX(sender.frame), CGRectGetMinY(sender.frame)-5-121-6, 87, 121+6)];
    [self.view addSubview:bubblesView];
}

@end
