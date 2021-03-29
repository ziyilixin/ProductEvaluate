//
//  Evaluate.h
//  ProductEvaluate
//
//  Created by Mac on 2021/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class EvaluateUser;
@interface Evaluate : NSObject
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray *thumbs;
@property (nonatomic, strong) EvaluateUser *user;
@end

NS_ASSUME_NONNULL_END
