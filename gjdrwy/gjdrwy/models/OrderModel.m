//
//  OrderModel.m
//  gjdryz
//
//  Created by AllPepole on 15/12/5.
//
//

#import "OrderModel.h"
#import "NSDictionary+dictionaryExtension.h"
#import "NSString+StringExtension.h"

@implementation OrderModel

- (instancetype)initWithJson:(id )data
{
    self = [super init];
    if (self) {
        [self setValueWithJson:data];
        self.processType = [data objectForNotNullKey:@"contenttypeName"];
        self.status = (OrderStatus)[[data objectForNotNullKey:@"status"] integerValue];
    }
    return self;
}

- (void)setValueWithJson:(id)data
{
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        
        self.helpId = [data objectForNotNullKey:@"id"];
        self.orderNub = [data objectForNotNullKey:@"ordernumber"];
        

        NSString* time = [data objectForNotNullKey:@"helptime"];
        if (time.length >= 19) {
             self.createTime = [time substringWithRange:NSMakeRange(0, 19)];
        }
       
        
        NSString* dotime = [data objectForNotNullKey:@"dotime"];
        if (dotime.length >= 19) {
             self.processTime = [dotime substringWithRange:NSMakeRange(0, 19)];
        }
       
        
        self.orderContent = [data objectForNotNullKey:@"helpcontent"];
        self.remark = [data objectForNotNullKey:@"remark"];
        self.processContent= [data objectForNotNullKey:@"tempcontent"];
        self.evaluat= [data objectForNotNullKey:@"content"];
        self.evaluatTime= [data objectForNotNullKey:@"commenttime"];
        self.evaluatPercent= [[data objectForNotNullKey:@"score"] integerValue];
        NSString* imageString = [data objectForNotNullKey:@"images"];
        if (![NSString isNullOrEmpty:imageString]) {
            NSArray* array = [imageString componentsSeparatedByString:@","];
            self.images = [NSArray arrayWithArray:array];
        }
    }

}
@end
