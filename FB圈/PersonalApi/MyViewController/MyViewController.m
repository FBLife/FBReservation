//
//  MyViewController.m
//  越野e族
//
//  Created by soulnear on 14-3-27.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController
@synthesize leftButtonType = _leftButtonType;
@synthesize rightString = _rightString;
@synthesize leftImageName = _leftImageName;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButton.width = MY_MACRO_NAME?-4:5;
    
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    self.navigationController.navigationBarHidden=NO;
    
    [self.navigationController.parentViewController.view.window makeKeyAndVisible];
    
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
    {
        //iOS 5 new UINavigationBar custom background
        
        [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7eva320_44.png"] forBarMetrics: UIBarMetricsDefault];
    }
    
    
    UIColor * cc = [UIColor blackColor];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
}

-(void)setMyViewControllerLeftButtonType:(MyViewControllerLeftbuttonType)theType WithRightButtonType:(MyViewControllerRightbuttonType)rightType
{
    if (theType == MyViewControllerLeftbuttonTypeBack)
    {
        UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10,8,12,21.5)];
        [button_back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [button_back setBackgroundImage:[UIImage imageNamed:@"ios7_back@2x.png"] forState:UIControlStateNormal];
        UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
        self.navigationItem.leftBarButtonItems=@[spaceButton,back_item];
    }else if (theType == MyViewControllerLeftbuttonTypelogo)
    {
        UIImageView * leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ios7logo"]];
        leftImageView.center = CGPointMake(MY_MACRO_NAME? 18:30,22);
        UIView *lefttttview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
        [lefttttview addSubview:leftImageView];
        UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:lefttttview];
        
        self.navigationItem.leftBarButtonItem = leftButton;
    }else if(theType == MyViewControllerLeftbuttonTypeOther)
    {
        UIImage * leftImage = [UIImage imageNamed:_leftImageName];
        
        UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [leftButton setImage:[UIImage imageNamed:self.leftImageName] forState:UIControlStateNormal];
        
        leftButton.frame = CGRectMake(0,0,leftImage.size.width,leftImage.size.height);
        
        UIBarButtonItem * leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
        self.navigationItem.leftBarButtonItem = leftBarButton;
        
    }else
    {
        
    }
    
    
    
    if (rightType == MyViewControllerRightbuttonTypeRefresh)
    {
        UIButton * refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [refreshButton setImage:[UIImage imageNamed:@"ios7_refresh4139.png"] forState:UIControlStateNormal];
        refreshButton.frame = CGRectMake(0,0,41/2,39/2);
        refreshButton.center = CGPointMake(300,20);
        [refreshButton addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.rightBarButtonItems= @[spaceButton,[[UIBarButtonItem alloc] initWithCustomView:refreshButton]];

    }else if (rightType == MyViewControllerRightbuttonTypeSearch)
    {
        UIButton *rightview=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 37, 37/2)];
        rightview.backgroundColor=[UIColor clearColor];
        [rightview addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *    refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [refreshButton setImage:[UIImage imageNamed:@"ios7_newssearch.png"] forState:UIControlStateNormal];
        refreshButton.frame = CGRectMake(MY_MACRO_NAME? 25:10, 0, 37/2, 37/2);
        //    refreshButton.center = CGPointMake(300,20);
        [rightview addSubview:refreshButton];
        [refreshButton addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *_rightitem=[[UIBarButtonItem alloc]initWithCustomView:rightview];
        self.navigationItem.rightBarButtonItem=_rightitem;

    }else if(rightType == MyViewControllerRightbuttonTypeText)
    {
        UIButton * send_button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        send_button.frame = CGRectMake(0,0,30,44);
        
        send_button.titleLabel.textAlignment = NSTextAlignmentRight;
        
        [send_button setTitle:_rightString forState:UIControlStateNormal];
        
        send_button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [send_button setTitleColor:RGBCOLOR(89,89,89) forState:UIControlStateNormal];
        
        [send_button addTarget:self action:@selector(submitData:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.rightBarButtonItems = @[spaceButton,[[UIBarButtonItem alloc] initWithCustomView:send_button]];
        
    }else if (rightType == MyViewControllerRightbuttonTypeDelete)
    {
        
    }else if (rightType == MyViewControllerRightbuttonTypePerson)
    {
        UIButton * peopleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        peopleButton.frame = CGRectMake(0,0,36/2,33/2);
        
        [peopleButton setImage:[UIImage imageNamed:@"chat_people.png"] forState:UIControlStateNormal];
        
        [peopleButton addTarget:self action:@selector(PeopleView:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem * People_button = [[UIBarButtonItem alloc] initWithCustomView:peopleButton];
        
        self.navigationItem.rightBarButtonItems = @[spaceButton,People_button];

        
    }else
    {
        
    }
}

-(void)PeopleView:(UIButton *)sender
{
    
}


-(void)submitData:(UIButton *)sender
{
    
}


-(void)refresh:(UIButton *)sender
{
    
}

-(void)refreshData:(UIButton *)sender
{
//    [self nextResponder];
}


-(void)back:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
