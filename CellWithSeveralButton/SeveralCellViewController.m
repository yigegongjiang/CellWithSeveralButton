//
//  SeveralCellViewController.m
//  CellWithSeveralButton
//
//  Created by yangfan on 15/8/7.
//  Copyright (c) 2015年 Adron. All rights reserved.
//

#import "SeveralCellViewController.h"
#import "TableViewCell.h"

@interface SeveralCellViewController ()

@end

@implementation SeveralCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell setUserInteractionEnabled:YES];
    [cell.mainBackView setUserInteractionEnabled:YES];
    [self addDragView:cell.mainBackView];
    
    
    [cell setIndexPath:indexPath];
    WeakSelf;// 这里在block里面会用到，我这里没有使用到，写给大家了
    [cell setDeleteCell:^(NSIndexPath *path){// 这里是删除活动的cell
        NSLog(@"----------%@", path);
    }];
    [cell setUpdateCell:^(NSIndexPath *path){// 这里是修改活动的cell
        NSLog(@"**********%@", path);
    }];
    
    return cell;
}

- (void)addDragView:(UIView *)cell {
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [cell addGestureRecognizer:recognizer];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    // 上面的代码，就是让我们的mainBackground这个view，随着我们的手持进行左右的滚动

    
    if(recognizer.state == UIGestureRecognizerStateBegan) {
        // 这个方法我现在不说用处，大家做到最后可能会用到，因为我没有用到，我就写在这里，大家做完了功能，我想肯定会用到这个（就是滑动第二个cell的时候，上一个cell需要归位，大家可以不写，但是如果可能的话，应该会用到）
    }
    
    //这里就是关键咯，在我们的手指拖动结束的时候，我们需要使用pop引擎动画了，是的cell有一种抽屉拖动的效果
    if(recognizer.state == UIGestureRecognizerStateEnded) {
        POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
        CGPoint velocity = [recognizer velocityInView:self.view];
        if (velocity.x < 0) {// cell分为左右拖动，如果想又拖动，直接回到原位，如果像左拖动，分下面两种情况
            if (velocity.x < -100) {//如果拖动的速度很快，那么直接到达显示出delete和update两个按钮的位置
                [self toLeftAnimation:positionAnimation];
            } else {//如果拖动的速度很慢，分下面两种情况
                if (recognizer.view.frame.origin.x < -100) {//如果拖动的速度很慢，但是拖动的距离已经超过了指定的拖动距离，那么直接到达显示出delete和update两个按钮的位置
                    [self toLeftAnimation:positionAnimation];
                } else {// 如果拖动的速度很慢，又紧紧拖动的一点点距离，那么等于没有拖动，还是原位置
                    [self toCenterAnimation:positionAnimation];
                }
            }
        } else {
            [self toCenterAnimation:positionAnimation];
        }
        
        [positionAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        }];
        [recognizer.view.layer pop_addAnimation:positionAnimation forKey:@"kkkk"];
    }
}

- (void)toLeftAnimation:(POPSpringAnimation *)positionAnimation {
    float num = (self.view.frame.size.width - 180) - self.view.frame.size.width / 2.0;
    positionAnimation.toValue = @(num);
    positionAnimation.springBounciness = 10;
    positionAnimation.springSpeed = 4;
}

- (void)toCenterAnimation:(POPSpringAnimation *)positionAnimation {
    positionAnimation.toValue = @(self.view.frame.size.width / 2.0);
    positionAnimation.springBounciness = 10;
    positionAnimation.springSpeed = 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
