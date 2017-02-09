//
//  MainViewController.h
//  Words
//
//  Created by Macbook on 2/8/17.
//  Copyright © 2017 Raihana A. Souleymane. All rights reserved.
//

#import "MainViewController.h"
#import "WordModel.h"
#import "WebServiceTableViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>

MBProgressHUD *hud;

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UILabel *listTitleLbl;
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (readwrite, nonatomic, strong) NSArray *results;


- (IBAction)SearchCliked:(id)sender;

@end

@implementation MainViewController
- (void) viewWillAppear:(BOOL)animated{
    self.listView.layer.cornerRadius = 10;
    self.listView.clipsToBounds = true;
    self.automaticallyAdjustsScrollViewInsets = false;
    self.listView.hidden = true;
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bc.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
   // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bc.jpg"]];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.searchTextField.delegate = self;
    self.listTableView.rowHeight = 70.0f;
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)reload:(__unused id)sender {
    
    NSString *text = (@"%@",self.searchTextField.text);
   [WordModel passedParams:(@{
                           @"sf" : text})];
    NSURLSessionTask *task = [WordModel globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (!error) {
            [hud hideAnimated:YES];
            self.results = posts;
            if (self.results.count == 0){
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Not Found"
                                                                               message:@"This word was not found"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
              
            }
            else{
                [self.listTableView reloadData];
                self.listView.hidden = false;
            }
        }
        else{
            NSLog(@"%@", error.description);
        }
    }];
}




- (IBAction)SearchCliked:(id)sender {
    [self.searchTextField resignFirstResponder];
    hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.contentColor = [UIColor colorWithRed:118/255.f green:72/255.f blue:64/255.f alpha:1.f];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    
    // Set the label text.
    hud.label.text = (@"Loading...");
    hud.detailsLabel.text = (@"Parsing data\n(1/1)");
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self doSomeWork];
    });
 }

        
        

- (void)doSomeWork {

     [self reload:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(__unused UITableView *)tableView
 numberOfRowsInSection:(__unused NSInteger)section
{
    return (NSInteger)[self.results count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    WebServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[WebServiceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.post = self.results[(NSUInteger)indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(__unused UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WebServiceTableViewCell heightForCellWithPost:self.results[(NSUInteger)indexPath.row]];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark Text Field Delegate

 - (void)textFieldDidBeginEditing:(UITextField *)textField  {
     self.listView.hidden = true;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField canResignFirstResponder]) {
        [textField resignFirstResponder];
    }
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    // add your method here
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

@end




