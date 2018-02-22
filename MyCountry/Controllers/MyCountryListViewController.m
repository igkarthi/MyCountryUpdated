//

//  MyCountry
//
//  Created by Lexicon on 15/02/18.
//  Copyright © 2018 Lexicon. All rights reserved.
//

#import "MyCountryListViewController.h"
#import "MyCountryListTableViewCell.h"



@interface MyCountryListViewController ()

@end

@implementation MyCountryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor whiteColor];
    [self createControls];
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:activityView];
    [activityView startAnimating];
    
    NSLayoutConstraint *Height = [NSLayoutConstraint constraintWithItem:activityView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:50];

    NSLayoutConstraint *Width = [NSLayoutConstraint constraintWithItem:activityView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:50];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:activityView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    
     NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:activityView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];


    [self.view addConstraints:@[Width, Height, centerX, centerY]];
    
    [self callWebService];
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    // Do view manipulation here.
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [tblMapList reloadData];
}


//MARK:local methods

-(void)reloadTableView
{
    [activityView stopAnimating];
    [tblMapList reloadData];
}

-(void)refreshData
{
    [refreshControl endRefreshing];
    [activityView startAnimating];
    [self callWebService];
}

-(void)createControls
{
    tblMapList = [[UITableView alloc]init];
    tblMapList.separatorStyle = UITableViewCellSeparatorStyleNone;
    tblMapList.delegate = self;
    tblMapList.dataSource = self;
    tblMapList.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tblMapList];
    
    //[tblMapList registerClass:[MyCountryListTableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    refreshControl.translatesAutoresizingMaskIntoConstraints = NO;
    [tblMapList addSubview:refreshControl];
   
    
   
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:tblMapList attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:tblMapList attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:tblMapList attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:tblMapList attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    [self.view addConstraints:@[trailing, leading, top, bottom]];
}

-(void)callWebService
{

    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"]];
    
    //create the Method "GET"
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSString *strResponse = [[NSString alloc] initWithData:data encoding:NSMacOSRomanStringEncoding];
            
                    NSData *dataResponse = [strResponse dataUsingEncoding:NSUTF8StringEncoding];
            
                    NSError *err = nil;
                    NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:dataResponse options:NSJSONReadingAllowFragments error:&err];
            
                    arrList = [[NSMutableArray alloc]init];
                    arrList = [dicResult objectForKey:@"rows"];
            
                    dispatch_async(dispatch_get_main_queue(),  ^(void) {
                         self.navigationItem.title = [dicResult objectForKey:@"title"];
                        [self reloadTableView];
                    });
           
        }
        else
        {
            NSLog(@"Error");
            [activityView stopAnimating];
        }
    }];
    [dataTask resume];
    
}



#pragma mark - local Methods
-(float) getHeightForText:(NSString*) text withFont:(UIFont*) font andWidth:(float) width{
    CGSize constraint = CGSizeMake(width , 20000.0f);
    CGSize title_size;
    float totalHeight;
    
    SEL selector = @selector(boundingRectWithSize:options:attributes:context:);
    if ([text respondsToSelector:selector]) {
        title_size = [text boundingRectWithSize:constraint
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{ NSFontAttributeName : font }
                                        context:nil].size;
        
        totalHeight = ceil(title_size.height);
    } else {
//        title_size = [text sizeWithFont:font
//                      constrainedToSize:constraint
//                          lineBreakMode:NSLineBreakByWordWrapping];
        
        title_size = [text boundingRectWithSize:constraint
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{ NSFontAttributeName : font }
                                        context:nil].size;
        
        totalHeight = title_size.height ;
    }
    
    CGFloat height = MAX(totalHeight, 40.0f);
    return height;
}


#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrList.count  ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = 0;
    
    NSDictionary *dicList = [arrList objectAtIndex:indexPath.row];
    NSString *strDescription =  [dicList objectForKey:@"description"];
    
    if ([strDescription isKindOfClass:[NSString class]])
    {
        height = [self getHeightForText:strDescription withFont:[UIFont systemFontOfSize:12.0] andWidth:tblMapList.frame.size.width];
        
        return height + 150;
    }
    else
    {
        return 150;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    MyCountryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    CGFloat height = 50;
    
    NSDictionary *dicList = [arrList objectAtIndex:indexPath.row];
    NSString *strDescription =  [dicList objectForKey:@"description"];
    
    if ([strDescription isKindOfClass:[NSString class]])
    {
        height = [self getHeightForText:strDescription withFont:[UIFont systemFontOfSize:12.0] andWidth:tblMapList.frame.size.width ];
    }

    cell = [[MyCountryListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withLabelHeight:(height)];

    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setContraints:height withWidth:tblMapList.frame.size.width - 10];
    
    NSString *strImgURL =  [dicList objectForKey:@"imageHref"];
    
     if ([strImgURL isKindOfClass:[NSString class]])
     {
         [cell.imgImageView sd_setImageWithURL:[NSURL URLWithString:strImgURL]
                              placeholderImage:[UIImage imageNamed:@"placeholder"]];
     }
    else
    {
        cell.imgImageView.image = [UIImage imageNamed:@"placeholder"];
    }
    
    if ([strDescription isKindOfClass:[NSString class]])
    {
        cell.lblDescription.text = strDescription;
    }
   
    NSString *strTitle =  [dicList objectForKey:@"title"];
    if ([strTitle isKindOfClass:[NSString class]])
    {
        cell.lblTitle.text = strTitle;
    }
    
    
   
    
    return cell;
}

//MARK:unit test method
-(void)updateString
{
    self.stringUpdate = @"mycountry";
}
-(void)reverseString
{
    self.stringReverse = @"canda";
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
