//
//  MSPViewController.m
//  KVODemo
//
//  Created by msp on 13-12-2.
//  Copyright (c) 2013年 ___FULLUSERNAME___. All rights reserved.
//

#import "MSPViewController.h"

@interface MSPViewController ()

@end

@implementation MSPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    pKVO = [[KVOTest alloc] init];
    pKVO.m_strName = @"11";
    //添加观察对象(self)及被观察的属性(m_strName)
    [pKVO addObserver:self forKeyPath:@"m_strName" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"a"] ;
    
	UIButton * pBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    pBtn.frame = CGRectMake(0, 0, 50, 30);
    pBtn.center = CGPointMake(160, 240);
    [pBtn addTarget:self action:@selector(ButtonResponse:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pBtn];
}

- (void)ButtonResponse:(UIButton*)pBtn
{
    static int iNum = 0;
    
    //改变被观察的属性值
    pKVO.m_strName = [NSString stringWithFormat:@"%d",iNum];
    
    iNum++;
}
#pragma mark -KVO回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"m_strName"])
    {
        NSLog(@"dic->%@,context->%@",change,context);
        NSLog(@"value->%@",[pKVO valueForKey:@"m_strName"]);
    }
}


- (void)didReceiveMemoryWarning
{
    [pKVO removeObserver:self forKeyPath:@"m_strName"];
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
