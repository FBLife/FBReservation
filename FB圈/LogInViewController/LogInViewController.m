//
//  LogInViewController.m
//  FbLife
//
//  Created by szk on 13-2-26.
//  Copyright (c) 2013年 szk. All rights reserved.
//

#import "LogInViewController.h"
#import "JSONKit.h"
@interface LogInViewController ()
{
    downloadtool *tool1;
    downloadtool *tool2;
    downloadtool *tool3;
}

@end

@implementation LogInViewController
@synthesize myTableView = _myTableView;
@synthesize TextField1 = _TextField1;
@synthesize TextField2 = _TextField2;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"LogInViewController"];
}


-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [MobClick beginEvent:@"LogInViewController"];
    
    
    if (isShow && logoImageView)
    {
        [self loadDown];
    }
    
}


-(void)loadDown
{
    logoImageView.center = CGPointMake(160,42 + 49.5/2 + (IOS_VERSION>=7.0?64:44));
    
    denglu_imageView.frame = CGRectMake(23.5/2,logoImageView.center.y+25+10,296.5,185);
    
    isShow = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isShow = NO;
        
    dictionary = [[NSDictionary alloc] init];
    
    self.view.backgroundColor = RGBCOLOR(245,245,245);
    ///////////////////////////////////
    //[self kaitongfb];
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    //创建navbar
    UINavigationBar *nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, aScreenRect.size.width,IOS_VERSION>=7.0?64:44)];
    //创建navbaritem
    UINavigationItem * NavTitle = [[UINavigationItem alloc] initWithTitle:@"登录账号"];
    nav.barStyle = UIBarStyleBlackOpaque;
    [nav pushNavigationItem:NavTitle animated:YES];
    
    //    nav.translucent = NO;
    
    if([nav respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] )
    {
        [nav setBackgroundImage:[UIImage imageNamed:IOS_VERSION>=7.0?IOS7DAOHANGLANBEIJING:IOS6DAOHANGLANBEIJING] forBarMetrics: UIBarMetricsDefault];
    }
    
    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,44)];
    
    title_label.text = @"登录";
    
    title_label.textColor = [UIColor blackColor];
    
    title_label.backgroundColor = [UIColor clearColor];
    
    title_label.textAlignment = NSTextAlignmentCenter;
    
    title_label.font =TITLEFONT;
    
    NavTitle.titleView = title_label;
    
    
    UIBarButtonItem * spaceBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    spaceBar.width = MY_MACRO_NAME?-5:5;
    
    
    UIButton *button_back=[[UIButton alloc]initWithFrame:CGRectMake(10,8,31/2,32/2)];
    
    [button_back addTarget:self action:@selector(backH) forControlEvents:UIControlEventTouchUpInside];
    
    [button_back setBackgroundImage:[UIImage imageNamed:@"logIn_close.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:button_back];
    
    NavTitle.rightBarButtonItems=@[spaceBar,back_item];
    
    
    //设置barbutton
    [nav setItems:[NSArray arrayWithObject:NavTitle]];
    ///////////////////////////////////
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    UIImage * logo_image = [UIImage imageNamed:@"logoInLogo.png"];
    
    logoImageView = [[UIImageView alloc] initWithImage:logo_image];
    
    logoImageView.center = CGPointMake(160,42 + 49.5/2 + (IOS_VERSION>=7.0?64:44));
    
    [self.view addSubview:logoImageView];
    
    
    
    denglu_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(23.5/2,logoImageView.center.y+25+10,296.5,185)];
    
    denglu_imageView.userInteractionEnabled = YES;
    
    denglu_imageView.image = [UIImage imageNamed:@"llongInBackImage.png"];
    
    [self.view addSubview:denglu_imageView];
    
    
    userNameField=[[UITextField alloc] initWithFrame:CGRectMake(70,18,[UIScreen mainScreen].applicationFrame.size.width-110,42)];
    userNameField.backgroundColor=[UIColor clearColor];
    userNameField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//垂直居中
    userNameField.placeholder = @"用户名";                          //默认显示的字
    userNameField.textColor = [UIColor blackColor];                     //设置字体的颜色
    userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;  //清空功能x
    userNameField.returnKeyType = UIReturnKeyDone;                    //键盘有done
    userNameField.delegate=self;
    userNameField.font = [UIFont systemFontOfSize:16];
    [denglu_imageView addSubview:userNameField];
    
    pwNameField=[[UITextField alloc] initWithFrame:CGRectMake(70,74,[UIScreen mainScreen].applicationFrame.size.width-110,42)];
    pwNameField.delegate = self;
    pwNameField.backgroundColor=[UIColor clearColor];
    pwNameField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//垂直居中
    pwNameField.secureTextEntry = YES;                              //密码输入时
    pwNameField.placeholder = @"密码";                          //默认显示的字
    pwNameField.textColor = [UIColor blackColor];                     //设置字体的颜色
    pwNameField.clearButtonMode = UITextFieldViewModeWhileEditing;  //清空功能x
    pwNameField.returnKeyType = UIReturnKeyDone;
    pwNameField.font = [UIFont systemFontOfSize:16];
    [denglu_imageView addSubview:pwNameField];
    
    
    
    UIButton * logIn_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    logIn_button.frame = CGRectMake(13,130,272,43);
    
    logIn_button.backgroundColor = [UIColor clearColor];
    
    [logIn_button setTitle:@"登 录" forState:UIControlStateNormal];
    
    [logIn_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [logIn_button addTarget:self action:@selector(loginH) forControlEvents:UIControlEventTouchUpInside];
    
    [denglu_imageView addSubview:logIn_button];
    
    
    
    
    
    
    /*老版界面
     loginboxImageView=[[UIImageView alloc] initWithImage: [UIImage imageNamed: @"denglu.png"]];
     [loginboxImageView setFrame:CGRectMake(([UIScreen mainScreen].applicationFrame.size.width-304)/2, 20+44+(IOS_VERSION>=7.0?20:0),304,91)];
     [self.view addSubview:loginboxImageView];
     
     userNameField=[[UITextField alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].applicationFrame.size.width-304)/2+95,24+44+(IOS_VERSION>=7.0?20:0), [UIScreen mainScreen].applicationFrame.size.width-110,40)];
     
     userNameField.backgroundColor=[UIColor clearColor];
     userNameField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//垂直居中
     userNameField.placeholder = @"用户名";                          //默认显示的字
     userNameField.textColor = [UIColor blackColor];                     //设置字体的颜色
     userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;  //清空功能x
     userNameField.returnKeyType = UIReturnKeyDone;                    //键盘有done
     userNameField.delegate=self;    [self.view addSubview:userNameField];
     
     pwNameField=[[UITextField alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].applicationFrame.size.width-304)/2+95,44+68+(IOS_VERSION>=7.0?20:0), [UIScreen mainScreen].applicationFrame.size.width-110, 40)];
     pwNameField.backgroundColor=[UIColor clearColor];
     pwNameField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//垂直居中
     pwNameField.secureTextEntry = YES;                              //密码输入时
     pwNameField.placeholder = @"密码";                          //默认显示的字
     pwNameField.textColor = [UIColor blackColor];                     //设置字体的颜色
     pwNameField.clearButtonMode = UITextFieldViewModeWhileEditing;  //清空功能x
     // pwNameField.returnKeyType = UIReturnKeyDone;                    //键盘有done
     // pwNameField.delegate=self;
     [self.view addSubview:pwNameField];
     
     
     UILabel *  powerText = [[UILabel alloc] initWithFrame:CGRectMake(30,44+125+(IOS_VERSION>=7.0?20:0),[UIScreen mainScreen].applicationFrame.size.width, 10)];
     powerText.text = @"注册越野e族会员,请登录FBLIFE.COM";
     powerText.font = [UIFont boldSystemFontOfSize:15];
     powerText.textColor=[UIColor blackColor];
     powerText.backgroundColor = [UIColor clearColor];
     [powerText sizeToFit];
     [self.view addSubview:powerText];
     
     */
    
    
    UIButton * zhuce_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    zhuce_button.frame = CGRectMake(82,[UIScreen mainScreen].bounds.size.height-60,65,20);
    
    [zhuce_button setTitle:@"注册账号" forState:UIControlStateNormal];
    
    zhuce_button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    zhuce_button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    zhuce_button.backgroundColor = [UIColor clearColor];
    
    [zhuce_button setTitleColor:RGBCOLOR(82,82,82) forState:UIControlStateNormal];
    
    [zhuce_button addTarget:self action:@selector(zhuceButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:zhuce_button];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(159.5,[UIScreen mainScreen].bounds.size.height-58,0.5,16)];
    
    lineView.backgroundColor = RGBCOLOR(65,65,65);
    
    [self.view addSubview:lineView];
    
    UIButton * zhaohui_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    zhaohui_button.frame = CGRectMake(174,[UIScreen mainScreen].bounds.size.height-60,65,20);
    
    zhaohui_button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [zhaohui_button setTitleColor:RGBCOLOR(82,82,82) forState:UIControlStateNormal];
    
    [zhaohui_button setTitle:@"忘记密码" forState:UIControlStateNormal];
    
    [zhaohui_button addTarget:self action:@selector(zhaohuiButton:) forControlEvents:UIControlEventTouchUpInside];
    
    zhaohui_button.backgroundColor = [UIColor clearColor];
    
    zhaohui_button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:zhaohui_button];
    
    [self.view addSubview:nav];
    
    
    if (!hud)
    {
        hud = [[ATMHud alloc] initWithDelegate:self];
        [self.view addSubview:hud.view];
    }
}


-(void)zhuceButton:(UIButton *)sender
{
    MyPhoneNumViewController * zhuce = [[MyPhoneNumViewController alloc] init];
    
    UINavigationController * naVC = [[UINavigationController alloc] initWithRootViewController:zhuce];
    
    [self presentModalViewController:naVC animated:YES];
}

-(void)zhaohuiButton:(UIButton *)sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请登录网站找回密码" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
    
    [alert show];
}



-(void)backH
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        [_delegate failToLogIn];
    }];
}

-(void)loginH
{
    [tool1 stop];
    [tool2 stop];
    [tool3 stop];
    
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    [hud setShowSound:[[NSBundle mainBundle] pathForResource:@"pop" ofType:@"wav"]];
    [hud setCaption:NS_LOGINING];
    [hud setActivity:YES];
    //    [hud setImage:[UIImage imageNamed:@"19-check"]];
    [hud show];
    //    [hud hideAfter:3];
    
    
    [userNameField resignFirstResponder];
    [pwNameField resignFirstResponder];
    
    
    tool1=[[downloadtool alloc]init];
    [tool1 setUrl_string:[NSString stringWithFormat:LOGIN_URL,[userNameField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[pwNameField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:DEVICETOKEN]]];
    tool1.tag=101;
    
    NSLog(@"登录请求的url:%@",[NSString stringWithFormat:LOGIN_URL,[userNameField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[pwNameField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[NSUserDefaults standardUserDefaults]objectForKey:DEVICETOKEN]]);
    
    tool1.delegate=self;
    [tool1 start];
    
}


//开通fb
-(void)kaitong:(NSString *)sender
{
    NSLog(@"sender -=-   %@",sender);
    NSString *striingktfb=   [NSString stringWithFormat:ACTIVE_FBUSER_URL,sender];
    NSLog(@"开通时候的key==%@",striingktfb);
    tool3=[[downloadtool alloc]init];
    tool3.tag=103;
    [tool3 setUrl_string:striingktfb];
    tool3.delegate=self;
    [tool3 start];
}



//验证是否开通fb
-(void)kaitongfb:(NSString *)sender
{
    //验证用户是否开通FB
#define CHECK_FBUSER_URL @"http://fb.fblife.com/openapi/index.php?mod=account&code=checkfbuser&authkey=%@&fbtype=json"
    //    //激活Fb账号
#define ACTIVE_FBUSER_URL @"http://fb.fblife.com/openapi/index.php?mod=account&code=activeuser&authkey=%@&fbtype=json"
    
    
    NSString *striingktfb=   [NSString stringWithFormat:CHECK_FBUSER_URL,sender];
    tool2=[[downloadtool alloc]init];
    tool2.tag=102;
    [tool2 setUrl_string:striingktfb];
    tool2.delegate=self;
    [tool2 start];
}


-(void)downloadtoolError
{
    [hud hide];
    [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"登录失败,请重新登录" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil] show];
}

-(void)downloadtool:(downloadtool *)tool didfinishdownloadwithdata:(NSData *)data
{
    
    @try {
        if (tool.tag==101)
        {
            dictionary= [data objectFromJSONData];
            NSLog(@"登录论坛 -=-=  %@",dictionary);
            
            
            if ([[dictionary objectForKey:@"errcode"] integerValue]==0)
            {
                [self kaitongfb:[dictionary objectForKey:@"bbsinfo"]];
                
            }else
            {
                [hud hide];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USER_IN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码不正确" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert_ show];
            }
            
        }else if(tool.tag == 102)
        {
            NSDictionary *dic_=[data objectFromJSONData];
            NSLog(@"验证是否开通fb账号");
            NSLog(@"啦啦啦啦啦 -=-  %@,,,errcode -=  %@",[dic_ objectForKey:@"data"],[dic_ objectForKey:@"errcode"]);
            
            if ([[dic_ objectForKey:@"errcode"] intValue] == 1)
            {
                [hud hide];
                //登陆成功保存用户信息
                [[NSUserDefaults standardUserDefaults] setObject:userNameField.text forKey:USER_NAME] ;
                [[NSUserDefaults standardUserDefaults] setObject:pwNameField.text forKey:USER_PW] ;
                [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"bbsinfo"] forKey:USER_AUTHOD] ;
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_IN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:USER_AUTHOD object:[dictionary objectForKey:@"bbsinfo"]];
                
                
                [self.delegate successToLogIn];
                pwNameField.text = @"";
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LogIn" object:nil];
                
                
                [self dismissModalViewControllerAnimated:YES];
                
            }else
            {
                NSLog(@"没有开通");
                NSLog(@"---yaochuande-==%@",[dictionary objectForKey:@"bbsinfo"]);
                [self kaitong:[dictionary objectForKey:@"bbsinfo"]];
            }
            
        }else
        {
            NSLog(@"正在开通");
            
            [hud hide];
            
            NSDictionary * dic = [data objectFromJSONData];
            
            if ([[dic objectForKey:@"errcode"] intValue] == 1)
            {
                NSLog(@"开通成功");
                
                //激活成功保存用户信息
                [[NSUserDefaults standardUserDefaults] setObject:userNameField.text forKey:USER_NAME] ;
                [[NSUserDefaults standardUserDefaults] setObject:pwNameField.text forKey:USER_PW] ;
                [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"bbsinfo"] forKey:USER_AUTHOD] ;
                // [[NSUserDefaults standardUserDefaults]setObject:[dictionary objectForKey:@""] forKey:<#(NSString *)#>];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_IN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.delegate successToLogIn];
                pwNameField.text = @"";
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LogIn" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:USER_AUTHOD object:[dictionary objectForKey:@"bbsinfo"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"clearolddata" object:nil];
                
                [self dismissModalViewControllerAnimated:YES];
            }else
            {
                NSLog(@"开通时候的dic=%@",dic);
                NSLog(@"开通失败");
                UIAlertView * alert = [[UIAlertView alloc ]initWithTitle:@"提示" message:@"登录失败" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
}



#pragma mark-开通fb
- (void)requestFinished:(ASIHTTPRequest *)request
{
    @try {
        if (request.tag==101) {
            NSLog(@"requeststring==%@",[request responseString]);
            NSData *data=[request responseData];
            NSDictionary *dic_=[data objectFromJSONData];
            NSLog(@"dic==%@",dic_);
            if ([[dic_ objectForKey:@"errcode"] integerValue]==0)
            {
                //登陆成功保存用户信息
                [[NSUserDefaults standardUserDefaults] setObject:userNameField.text forKey:USER_NAME] ;
                [[NSUserDefaults standardUserDefaults] setObject:pwNameField.text forKey:USER_PW] ;
                [[NSUserDefaults standardUserDefaults] setObject:[dic_ objectForKey:@"bbsinfo"] forKey:USER_AUTHOD] ;
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_IN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:USER_AUTHOD object:[dic_ objectForKey:@"bbsinfo"]];
                
            }else
            {
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USER_IN];
                [[NSUserDefaults standardUserDefaults] synchronize];
                UIAlertView *alert_=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码不正确" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert_ show];
            }
        }else{
            NSLog(@"requeststring==%@",[request responseString]);
            NSData *data=[request responseData];
            NSDictionary *dic_=[data objectFromJSONData];
            NSLog(@"dic==%@",dic_);
            UILabel *labeltest=[[UILabel alloc]initWithFrame:CGRectMake(0,300 ,320 , 100)];
            // labeltest.backgroundColor=[UIColor redColor];
            labeltest.text=(NSString *)[dic_ objectForKey:@"data"];
            [self.view addSubview:labeltest];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    [hud hide];
    NSLog(@"error");
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //    [self loginH];
    
    [pwNameField resignFirstResponder];
    
    [userNameField resignFirstResponder];
    
    [UIView animateWithDuration:0.4 animations:^{
        logoImageView.center = CGPointMake(160,42 + 49.5/2 + (IOS_VERSION>=7.0?64:44));
        
        denglu_imageView.frame = CGRectMake(23.5/2,logoImageView.center.y+25+10,296.5,185);
        
        
    } completion:^(BOOL finished) {
        isShow = NO;
    }];
    
    return YES;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!iPhone5)
    {
        if (!isShow)
        {
            isShow = YES;
            
            [UIView animateWithDuration:0.4 animations:^{
                logoImageView.center = CGPointMake(160,-49.5/2);
                
                denglu_imageView.center = CGPointMake(160,(IOS_VERSION>=7.0?64:44)+185/2);
                
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end







