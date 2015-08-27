//
//  MySiteTableViewController.m
//  zuimeigeci
//
//  Created by Mee Leo on 27/8/2015.
//  Copyright © 2015 YCompany. All rights reserved.
//

#import "MySiteTableViewController.h"

@interface MySiteTableViewController ()

@end

@implementation MySiteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib* cellNib = [UINib nibWithNibName:@"MySiteTableViewCell" bundle:nil];

    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"myCell"];

    self.tableView.estimatedRowHeight = 100.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    MySiteHeaderViewController* headerController = [[MySiteHeaderViewController alloc]initWithNibName:@"MySiteHeaderViewController" bundle:nil];
    headerController.view.frame = CGRectMake(0, 0, 0, 300);

    self.tableView.tableHeaderView = headerController.view;
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MySiteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    cell.contents.text = @"现在台湾媒体给出的最新消息称，小米的自主处理器一切顺利，而他们依然是借助联芯，同时处理器会有2个主频版本，首先会用在红米系列上，定位比较低端，但性价比超高。如果真是这样的话，那么给小米带来最大的好处莫过于中低端智能手机，售价可以做的更诱人，这对于其它厂商来说，无疑是不好的消息，毕竟在这个领域，消费者对售价是超级敏感的。PS：价格杀手本色依旧...此外，报道中还提到，小米与联芯的合作的处理器还会扩大到更高端的八核版本，不过即使是这样，未来小米在高端上还是会以高通为主。明年年初，大家就能看到小米自研处理器了，除了速度快外，小米似乎还不是玩票性质，已经布好了一个大局，大家期待吗";
    
    // Configure the cell...
    
    return cell;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//
//    
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
