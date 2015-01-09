//
//  EditorCellsViewController.m
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/8.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#import "EditorCellsViewController.h"
#import "IBTTableViewInfo.h"

@interface EditorCellsViewController ()
<
    UITextFieldDelegate
>
{
    IBTTableView *m_tableview;
}
@property (strong, nonatomic) IBTTableViewInfo *m_tableViewInfo;
@end

@implementation EditorCellsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Editor Cells";
    
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addKeyboardNotification];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self removeKeyboardNotification];
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

#pragma mark - Private Method
- (void)initTableView {
    self.m_tableViewInfo = [[IBTTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
    // Section 3
    IBTTableViewSectionInfo *sec3Info = [IBTTableViewSectionInfo sectionInfoDefaut];
    IBTTableViewCellInfo *editCellInfo =
    [IBTTableViewCellInfo editorCellForSel:nil target:nil tip:@"User Name" focus:NO text:nil];
    [editCellInfo addUserInfoValue:@( UIKeyboardTypeNamePhonePad )
                            forKey:CInfoEditorKeyboardTypeKey];
    [sec3Info addCell:editCellInfo];
    
    IBTTableViewCellInfo *edit1CellInfo =
    [IBTTableViewCellInfo editorCellForSel:nil target:nil title:@"Password" margin:0 tip:@"Please Input" autoCorrect:NO focus:YES text:@"2333"];
    [edit1CellInfo addUserInfoValue:@( UIKeyboardTypeASCIICapable )
                             forKey:CInfoEditorKeyboardTypeKey];
    [sec3Info addCell:edit1CellInfo];
    UITextField *textF = [edit1CellInfo getUserInfoValueForKey:CInfoEditorKey];
    textF.delegate = self;
    
    [_m_tableViewInfo addSection:sec3Info];
    
    m_tableview = [_m_tableViewInfo getTableView];
    [self.view addSubview:m_tableview];
}

#pragma mark - Keyboard Notification

- (void)addKeyboardNotification {
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self
                   selector:@selector(keyboardWillShow:)
                       name:UIKeyboardWillShowNotification
                     object:nil];
    [notiCenter addObserver:self
                   selector:@selector(keyboardWillHide:)
                       name:UIKeyboardWillHideNotification
                     object:nil];
}

- (void)removeKeyboardNotification {
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter removeObserver:self
                          name:UIKeyboardWillShowNotification
                        object:nil];
    [notiCenter removeObserver:self
                          name:UIKeyboardWillHideNotification
                        object:nil];
}

#pragma mark -
- (void)keyboardWillShow:(NSNotification *)keyboard {
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[keyboard.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [keyboard.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [keyboard.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    [m_tableview setContentInsetTop:m_tableview.contentInset.top andBottom:CGRectGetHeight(keyboardBounds)];
    
    // commit animations
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)keyboard {
    NSNumber *duration = [keyboard.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [keyboard.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    [m_tableview setContentInsetTop:m_tableview.contentInset.top andBottom:0];
    
    
    // commit animations
    [UIView commitAnimations];
}
@end
