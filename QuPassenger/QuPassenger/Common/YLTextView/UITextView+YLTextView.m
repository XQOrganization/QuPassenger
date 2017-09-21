//
//  UITextView+YLTextVIew.m
// QQ:896525689
// Email:zhangyuluios@163.com
//                 _
// /\   /\        | |
// \ \_/ / _   _  | |     _   _
//  \_ _/ | | | | | |    | | | |
//   / \  | |_| | | |__/\| |_| |
//   \_/   \__,_| |_|__,/ \__,_|
//
//  Created by 张雨露 on 16/9/9.
//  Copyright © 2016年 Raindew. All rights reserved.
//

#import "UITextView+YLTextView.h"
#import <objc/runtime.h>
@interface UITextView ()
@property (nonatomic,strong) UILabel *placeholderLabel;//占位符
@end
@implementation UITextView (YLTextView)

static NSString *PLACEHOLDLABEL = @"placelabel";
static NSString *PLACEHOLD = @"placehold";
static NSString *WORDCOUNTLABEL = @"wordcount";
static const void *limitLengthKey = &limitLengthKey;

static NSString *WORDCHANGEBLOCK = @"wordblock";


#pragma mark -- set/get...

-(void)setPlaceholderLabel:(UILabel *)placeholderLabel {

    objc_setAssociatedObject(self, &PLACEHOLDLABEL, placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)placeholderLabel {

    return objc_getAssociatedObject(self, &PLACEHOLDLABEL);

}

- (void)setPlaceholder:(NSString *)placeholder {
    
   
    objc_setAssociatedObject(self, &PLACEHOLD, placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setPlaceHolderLabel:placeholder];
}

- (NSString *)placeholder {

    return objc_getAssociatedObject(self, &PLACEHOLD);
}


- (UILabel *)wordCountLabel {

    return objc_getAssociatedObject(self, &WORDCOUNTLABEL);

}
- (void)setWordCountLabel:(UILabel *)wordCountLabel {

    objc_setAssociatedObject(self, &WORDCOUNTLABEL, wordCountLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}


- (NSNumber *)limitLength {

    return objc_getAssociatedObject(self, limitLengthKey);
}

- (void)setLimitLength:(NSNumber *)limitLength {
    objc_setAssociatedObject(self, limitLengthKey, limitLength, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addLimitLengthObserver:[limitLength intValue]];

    [self setWordcountLable:limitLength];
    
}

- (TextViewWordsChanged)wordChanged
{
    return objc_getAssociatedObject(self, &WORDCHANGEBLOCK);
}

- (void)setWordChanged:(TextViewWordsChanged)wordChanged
{
    objc_setAssociatedObject(self, &WORDCHANGEBLOCK, wordChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark -- 配置占位符标签

- (void)setPlaceHolderLabel:(NSString *)placeholder {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextViewTextDidChangeNotification object:self];
    /*
     *  占位字符
     */
    
    if (!self.placeholderLabel) {
        self.placeholderLabel = [[UILabel alloc] init];
        self.placeholderLabel.font = [UIFont systemFontOfSize:13.];
        self.placeholderLabel.numberOfLines = 0;
        self.placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.placeholderLabel.textColor = HEXCOLOR(@"cccccc");
        [self addSubview:self.placeholderLabel];
    }
    self.placeholderLabel.text = placeholder;
    CGRect rect = [placeholder boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame)-7, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13.]} context:nil];
    self.placeholderLabel.frame = CGRectMake(7, 7, rect.size.width, rect.size.height);
    self.placeholderLabel.hidden = self.text.length > 0 ? YES : NO;
    
}

- (void)reloadPlaceHolderWithWidth:(CGFloat)width
{
    CGRect rect = [self.placeholderLabel.text boundingRectWithSize:CGSizeMake(width-7, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13.]} context:nil];
    self.placeholderLabel.frame = CGRectMake(7, 7, width-7, rect.size.height);
}

#pragma mark -- 配置字数限制标签

- (void)setWordcountLable:(NSNumber *)limitLength {
    
    /*
     *  字数限制
     */
    self.wordCountLabel = [UILabel new];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    self.wordCountLabel.textColor = [UIColor lightGrayColor];
    self.wordCountLabel.font = [UIFont systemFontOfSize:13.];
    if (self.text.length > [limitLength integerValue]) {
        self.text = [self.text substringToIndex:[self.limitLength intValue]];
    }
    self.wordCountLabel.text = [NSString stringWithFormat:@"%lu/%@",(unsigned long)self.text.length,limitLength];
    [self addSubview:self.wordCountLabel];
    
    [self.wordCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.right.equalTo(self).offset(5);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
}


#pragma mark -- 增加限制位数的通知
- (void)addLimitLengthObserver:(int)length {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitLengthEvent) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark -- 限制输入的位数
- (void)limitLengthEvent {

    if ([self.text length] > [self.limitLength intValue]) {

        self.text = [self.text substringToIndex:[self.limitLength intValue]];
    }
}


#pragma mark -- NSNotification

- (void)textFieldChanged:(NSNotification *)notification {
    if (self.placeholder) {
        self.placeholderLabel.hidden = YES;
        
        if (self.text.length == 0) {
            
            self.placeholderLabel.hidden = NO;
        }
    }
    if (self.limitLength) {
        
        NSInteger wordCount = self.text.length;
        if (wordCount > [self.limitLength integerValue]) {
            wordCount = [self.limitLength integerValue];
        }
        self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/%@",wordCount,self.limitLength];
        if (self.wordChanged) {
            self.wordChanged(self);
        }
    }

}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];
}


@end
