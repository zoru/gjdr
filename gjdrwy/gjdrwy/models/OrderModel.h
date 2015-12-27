//
//  OrderModel.h
//  gjdryz
//
//  Created by AllPepole on 15/12/5.
//
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, OrderStatus) {
    
    OrderStatus_all = -1,
    OrderStatus_unProcess = 0,
    OrderStatus_processed = 1,
};

@interface OrderModel : NSObject

@property (nonatomic,copy)NSString* helpId;
@property (nonatomic,copy)NSString* orderNub;
@property (nonatomic,copy)NSString* createTime;
@property (nonatomic,copy)NSString* processTime;
@property (nonatomic,assign)OrderStatus status;
@property (nonatomic,copy)NSString* orderContent;
@property (nonatomic,copy)NSString* remark;
@property (nonatomic,copy)NSString* processContent;
@property (nonatomic,copy)NSString* evaluat;
@property (nonatomic,copy)NSString* evaluatTime;
@property (nonatomic,assign)NSInteger evaluatPercent;
@property (nonatomic,strong)NSArray* images;
@property (nonatomic,copy)NSString* processType;

- (instancetype)initWithJson:(id)data;

- (void)setValueWithJson:(id)data;
@end
