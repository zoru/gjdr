//
//  OrderCell.m
//  gjdryz
//
//  Created by AllPepole on 15/12/5.
//
//

#import "OrderCell.h"

@implementation OrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setValueWithModel:(OrderModel *)model
{
    if (model.orderNub&&model.orderNub.length) {
        self.orderNubLable.text = model.orderNub;
    }
    if (model.createTime&&model.createTime.length) {
        self.createTimeLable.text = model.createTime;
    }
    switch (model.status) {
        case OrderStatus_processed:
        {
            self.processTitleLable.hidden = NO;
            self.processTimeLable.hidden = NO;
            self.statusImageView.image = [UIImage imageNamed:@"通用_完成图标.png"];
            self.statusLable.textColor = [UIColor lightGrayColor];
            self.statusLable.text = @"完成";
            
            self.processTimeLable.text = model.processTime;
            
            self.processTypeImage.hidden = NO;
            self.processTypeLable.hidden = NO;
            self.processTypeLable.text = model.processType;
            if ([model.processType isEqualToString:@"投诉"]) {
                self.processTypeImage.image = [UIImage imageNamed:@"物管-已处理分类_1.png"];
            }
            else if([model.processType isEqualToString:@"建议"])
            {
                self.processTypeImage.image = [UIImage imageNamed:@"物管-已处理分类_4.png"];
            }
            else if([model.processType isEqualToString:@"报修"])
            {
                self.processTypeImage.image = [UIImage imageNamed:@"物管-已处理分类_3.png"];
            }
            else if([model.processType isEqualToString:@"咨询"])
            {
                self.processTypeImage.image = [UIImage imageNamed:@"物管-已处理分类_2.png"];
            }
            else
            {
                self.processTypeImage.image = [UIImage imageNamed:@"物管-已处理分类_5.png"];
                self.processTypeLable.text = @"其他";
            }
        }
            break;
        case OrderStatus_unProcess:
        {
            self.processTimeLable.hidden = YES;
            self.processTitleLable.hidden = YES;
            self.topConstrsint.constant  = 20;
            self.statusImageView.image = [UIImage imageNamed:@"通用_待处理.png"];
            self.statusLable.textColor = [UIColor redColor];
            self.statusLable.text = @"待处理";
            self.processTypeImage.hidden = YES;
            self.processTypeLable.hidden = YES;
        }
            break;
        default:
            break;
    }
    
    [self updateConstraints];
}

@end
