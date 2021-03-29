//
//  Evaluate.m
//  ProductEvaluate
//
//  Created by Mac on 2021/3/29.
//

#import "Evaluate.h"
#import "EvaluateUser.h"

@implementation Evaluate
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"user":[EvaluateUser class]};
}
@end
