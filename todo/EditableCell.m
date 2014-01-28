//
//  CustomCell.m
//  todo
//
//  Created by Utkarsh Sengar on 1/23/14.
//  Copyright (c) 2014 area42. All rights reserved.
//

#import "EditableCell.h"

@implementation EditableCell
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"textFieldChanged" object:self];
    return NO;
}
@end
