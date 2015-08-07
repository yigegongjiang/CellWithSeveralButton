//
//  QKLiveTableViewCell.m
//  QukanTool
//
//  Created by yang on 15/6/12.
//  Copyright (c) 2015年 yang. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected statesf
}

- (IBAction)deleteCellAction:(id)sender {
    if (_deleteCell != nil) {
        _deleteCell(_indexPath);
    }
}

- (IBAction)updateCellAction:(id)sender {
    if (_updateCell != nil) {
        _updateCell(_indexPath);
    }
}
@end
