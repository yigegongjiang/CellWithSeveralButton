//
//  QKLiveTableViewCell.h
//  QukanTool
//
//  Created by yang on 15/6/12.
//  Copyright (c) 2015年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^deleteCellBlock)(NSIndexPath *indexPath);
typedef void (^updateCellBlock)(NSIndexPath *indexPath);

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *mainBackView;

@property (strong, nonatomic) deleteCellBlock deleteCell;
@property (strong, nonatomic) updateCellBlock updateCell;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end
