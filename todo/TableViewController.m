//
//  TableViewController.m
//  todo
//
//  Created by Utkarsh Sengar on 1/23/14.
//  Copyright (c) 2014 area42. All rights reserved.
//

#import "TableViewController.h"
#import "EditableCell.h"

@interface TableViewController ()

@end

@implementation TableViewController

NSMutableArray *items;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Remove keyboard from UITableViewCell on tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    tap.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tap];
    
    
    items = [[NSMutableArray alloc] initWithObjects:@"Learn iOS", @"Unlearn a lot of crap", nil];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"+"
                                  style:UIBarButtonItemStyleBordered
                                  target: self
                                  action:@selector(addItemToArray)];
    [addButton setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"Helvetica" size:25.0],NSFontAttributeName,
                                        nil]forState:UIControlStateNormal];

    self.navigationItem.rightBarButtonItem = addButton;
    
    UINib *customNib = [UINib nibWithNibName:@"EditableCell" bundle:nil];
    [self.tableView registerNib:customNib forCellReuseIdentifier:@"EditableCell"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Remove keyboard when tapped elsewhere
-(void)dismissKeyboard:(UIGestureRecognizer*)tapGestureRecognizer
{
    if (!CGRectContainsPoint([self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]].frame, [tapGestureRecognizer locationInView:self.tableView]))
    {
        [self.view endEditing:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

#pragma mark - Reorder list
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}


#pragma mark - Others
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EditableCell";
    EditableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.taskText.text = [items objectAtIndex:indexPath.row];
    
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self delItemToArray];
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    self.tableView.allowsMultipleSelectionDuringEditing = editing;
    [super setEditing:editing animated:animated];
}


//Add Item To Array
- (void)addItemToArray {
    [items addObject:[NSString stringWithFormat:@"Wat?"]];
    [self.tableView reloadData];
}
     

//Delete Item To Array
- (void)delItemToArray {
    [items removeLastObject];
    [self.tableView reloadData];
}

     
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
