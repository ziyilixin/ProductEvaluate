//
//  ProductEvaluateCell.m
//  ProductEvaluate
//
//  Created by Mac on 2021/3/29.
//

#import "ProductEvaluateCell.h"
#import "Evaluate.h"
#import "EvaluateUser.h"

@interface ProductEvaluateCell ()
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *pictureView;
@end

@implementation ProductEvaluateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *photoImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:photoImageView];
        self.photoImageView = photoImageView;
        [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.top.equalTo(self.contentView).offset(10);
            make.width.height.mas_equalTo(40);
        }];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = RGB_COLOR(@"#333333", 1.0);
        nameLabel.font = SYS_Font(14);
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.photoImageView);
            make.left.equalTo(self.photoImageView.mas_right).offset(6);
        }];
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.textColor = RGB_COLOR(@"#666666", 1.0);
        contentLabel.font = SYS_Font(14);
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.top.equalTo(self.photoImageView.mas_bottom).offset(10);
            make.right.equalTo(self.contentView).offset(-20);
        }];
        
        UIView *pictureView = [[UIView alloc] init];
        [self.contentView addSubview:pictureView];
        self.pictureView = pictureView;
        [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = RGB_COLOR(@"#EAEAEA", 1.0);
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.top.equalTo(self.pictureView.mas_bottom);
            make.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(1.0);
        }];
    }
    return self;
}

- (void)setEvaluate:(Evaluate *)evaluate {
    _evaluate = evaluate;
    
    [self.photoImageView xf_setCircleHeaderWithUrl:minstr(_evaluate.user.avatar) placeholder:nil];
    self.nameLabel.text = minstr(_evaluate.user.nicename);
    self.contentLabel.text = minstr(_evaluate.content);
    
    for (UIView *view in self.pictureView.subviews) {
        [view removeFromSuperview];
    }
    
    if (_evaluate.thumbs.count > 0) {
        
        CGFloat lineSpacing = 10;
        CGFloat columnSpacing = 10;
        CGFloat width = (SCREEN_WIDTH - 20 - 4 * columnSpacing) / 3;
        CGFloat height = width;
        
        if (_evaluate.thumbs.count % 3 == 0) {
            CGFloat picH = (height + lineSpacing) * (_evaluate.thumbs.count / 3);
            [self.pictureView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(picH);
            }];
        }
        else {
            CGFloat picH = (height + lineSpacing) * (_evaluate.thumbs.count / 3 + 1);
            [self.pictureView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(picH);
            }];
        }
        
        [self layoutIfNeeded];
        
        for (int i = 0; i < _evaluate.thumbs.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.width = width;
            imageView.height = height;
            imageView.x = columnSpacing + (i % 3) * (width + columnSpacing);
            imageView.y = (i / 3) * (height + lineSpacing);
            [imageView sd_setImageWithURL:[NSURL URLWithString:minstr(_evaluate.thumbs[i])] completed:nil];
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            imageView.tag = i;
            [imageView addGestureRecognizer:tap];
            [self.pictureView addSubview:imageView];
        }
    }
    else {
        [self.pictureView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.0);
        }];
        [self layoutIfNeeded];
    }
}

- (void)tap:(UITapGestureRecognizer *)recognizer {
    UIView *view = recognizer.view;
    if (self.evaluateBlock) {
        self.evaluateBlock(_evaluate.thumbs, view.tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
