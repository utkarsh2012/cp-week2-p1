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
@property (nonatomic, strong) NSMutableArray* items;
@end

@implementation TableViewController

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
    [self loadTodoItems];
    
    //Remove keyboard from UITableViewCell on tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    tap.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tap];
    
    
    //items = [[NSMutableArray alloc] initWithObjects:@"Learn iOS", nil];
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
}

#pragma mark - Remove keyboard when tapped elsewhere
-(void)dismissKeyboard:(UIGestureRecognizer*)tapGestureRecognizer
{
    if (!CGRectContainsPoint([self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]].frame, [tapGestureRecognizer locationInView:self.tableView]))
    {
        [self.view endEditing:YES];
    }
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

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    [self.items exchangeObjectAtIndex:[sourceIndexPath row] withObjectAtIndex:[destinationIndexPath row]];
    [self saveToDoItems];
}


#pragma mark - Others
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EditableCell";
    EditableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.taskText.text = [self.items objectAtIndex:indexPath.row];
    cell.taskText.delegate = self;
    
    cell.taskText.tag = indexPath.row;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *theText = [self.items objectAtIndex: indexPath.row];
    
    // adjust the textView width base on screen size and orientation
	// the only constant width in the cells is the checkbox (64)
	CGRect screenRect = [[UIScreen mainScreen] bounds];
	CGFloat width = screenRect.size.width;
	width -= 50;
    
	CGRect textRect = [theText boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
												  options:NSStringDrawingUsesLineFragmentOrigin
											   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
												  context:nil];
    
    return textRect.size.height + 15;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.items removeObjectAtIndex:indexPath.row];
        [self saveToDoItems];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void) textViewDidEndEditing:(UITextView *)textView{
    NSInteger indexRow = textView.tag;
    [self updateItemInArray:indexRow value:textView.text];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    self.tableView.allowsMultipleSelectionDuringEditing = editing;
    [super setEditing:editing animated:animated];
}

- (void)addItemToArray {
    [self.items addObject:[NSString stringWithFormat:@"Wat?"]];
    [self saveToDoItems];
    [self.tableView reloadData];
}

- (void)updateItemInArray:(NSInteger)indexPath value:(NSString*)value {
    [self.items replaceObjectAtIndex:indexPath withObject:value];
    [self saveToDoItems];
    [self.tableView reloadData];
}

- (void)saveToDoItems
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.items forKey:@"todo"];
    [defaults synchronize];
}

- (void)loadTodoItems
{
    if (!self.items || !self.items.count) {
        self.items = [[NSMutableArray alloc] init];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *arr = [defaults objectForKey:@"todo"];
    
    for(NSString *str in arr)
    {
        [self.items addObject:str];
    }
    
}

@end
