//
//  SeveralCellViewController.h
//  CellWithSeveralButton
//
//  Created by yangfan on 15/8/7.
//  Copyright (c) 2015年 Adron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>

#define WeakSelf __weak typeof(self) weakSelf = self;

@interface SeveralCellViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTable;

@end
