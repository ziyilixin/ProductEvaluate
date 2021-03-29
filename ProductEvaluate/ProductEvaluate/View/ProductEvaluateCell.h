//
//  ProductEvaluateCell.h
//  ProductEvaluate
//
//  Created by Mac on 2021/3/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Evaluate;
typedef void(^EvaluateBlock)(NSArray *pictures, NSInteger index);
@interface ProductEvaluateCell : UITableViewCell
@property (nonatomic, strong) Evaluate *evaluate;
@property (nonatomic, copy) EvaluateBlock evaluateBlock;
@end

NS_ASSUME_NONNULL_END
