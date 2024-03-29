//
//  UITextView+Placeholder.m
//  com.westar.pdzw
//
//  Created by Fan on 2018/1/2.
//  Copyright © 2018年 Fan. All rights reserved.
//

#import "UITextView+Placeholder.h"
#import <objc/runtime.h>

@interface UITextView ()
@property (nonatomic,strong) UILabel *placeholderLabel;//占位符
@property (nonatomic,strong) UILabel *wordCountLabel;//计算字数
@property (nonatomic,strong) NSValue *oldFrame;//记录初始frame

@end
@implementation UITextView (YLTextView)

static NSString *PLACEHOLDLABEL = @"placelabel";
static NSString *PLACEHOLD = @"placehold";
static NSString *WORDCOUNTLABEL = @"wordcount";
static NSString *PLACEHOLDFONT = @"placeholdfont";
static NSString *LIMITFONT = @"limitfont";
static NSString *PLACEHOLDCOLOR = @"placeholdcolor";
static NSString *LIMITCOLOR = @"limitcolor";
static NSString *AUTOHEIGHT = @"autoheight";
static NSString *OLDFRAME = @"oldframe";
static const void *limitLengthKey = &limitLengthKey;
static const void *limitLinesKey = &limitLinesKey;


#pragma mark -- set/get...

- (void)setPlaceholderLabel:(UILabel *)placeholderLabel {
    objc_setAssociatedObject(self, &PLACEHOLDLABEL, placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UILabel *)placeholderLabel {
    return objc_getAssociatedObject(self, &PLACEHOLDLABEL);
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)setPlaceholder:(NSString *)placeholder {
    objc_setAssociatedObject(self, &PLACEHOLD, placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setPlaceHolderLabel:placeholder];
}
- (NSString *)placeholder {
    return objc_getAssociatedObject(self, &PLACEHOLD);
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (UILabel *)wordCountLabel {
    return objc_getAssociatedObject(self, &WORDCOUNTLABEL);
}
- (void)setWordCountLabel:(UILabel *)wordCountLabel {
    objc_setAssociatedObject(self, &WORDCOUNTLABEL, wordCountLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (NSNumber *)limitLength {
    return objc_getAssociatedObject(self, limitLengthKey);
}
- (void)setLimitLength:(NSNumber *)limitLength {
    objc_setAssociatedObject(self, limitLengthKey, limitLength, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addLimitLengthObserver:[limitLength intValue]];
    [self setWordcountLable:limitLength];
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (NSNumber *)limitLines {
    return objc_getAssociatedObject(self, limitLinesKey);
}
- (void)setLimitLines:(NSNumber *)limitLines {
    objc_setAssociatedObject(self, limitLinesKey, limitLines, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addLimitLengthObserver:[limitLines intValue]];
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)setLimitPlaceFont:(UIFont *)limitPlaceFont {
    if (self.wordCountLabel) {
        self.wordCountLabel.font = limitPlaceFont;
    }
    objc_setAssociatedObject(self, &LIMITFONT, limitPlaceFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIFont *)limitPlaceFont {
    return objc_getAssociatedObject(self, &LIMITFONT) == nil ? [UIFont systemFontOfSize:13.] : objc_getAssociatedObject(self, &LIMITFONT);
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)setPlaceholdFont:(UIFont *)placeholdFont {
    if (self.placeholderLabel) {
        self.placeholderLabel.font = placeholdFont;
    }
    objc_setAssociatedObject(self, &PLACEHOLDFONT, placeholdFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIFont *)placeholdFont {
    return objc_getAssociatedObject(self, &PLACEHOLDFONT) == nil ? [UIFont systemFontOfSize:13.] : objc_getAssociatedObject(self, &PLACEHOLDFONT);
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)setPlaceholdColor:(UIColor *)placeholdColor {
    if (self.placeholderLabel) {
        self.placeholderLabel.textColor = placeholdColor;
    }
    objc_setAssociatedObject(self, &PLACEHOLDCOLOR, placeholdColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)placeholdColor {
    return objc_getAssociatedObject(self, &PLACEHOLDCOLOR) == nil ? [UIColor lightGrayColor] : objc_getAssociatedObject(self, &PLACEHOLDCOLOR);
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)setLimitPlaceColor:(UIColor *)limitPlaceColor {
    if (self.wordCountLabel) {
        self.wordCountLabel.textColor = limitPlaceColor;
    }
    objc_setAssociatedObject(self, &LIMITCOLOR, limitPlaceColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)limitPlaceColor {
    return objc_getAssociatedObject(self, &LIMITCOLOR) == nil ? [UIColor lightGrayColor] : objc_getAssociatedObject(self, &LIMITCOLOR);
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)setAutoHeight:(NSNumber *)autoHeight {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidChangeNotification object:self];
    objc_setAssociatedObject(self, &AUTOHEIGHT, autoHeight, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSNumber *)autoHeight {
    return objc_getAssociatedObject(self, &AUTOHEIGHT);
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)setOldFrame:(NSValue *)oldFrame {
    objc_setAssociatedObject(self, &OLDFRAME, oldFrame, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSValue *)oldFrame {
    return objc_getAssociatedObject(self, &OLDFRAME);
}

- (BOOL)isEmpty{
    if (self.text == nil || [self.text isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

#pragma mark -- 配置占位符标签

- (void)setPlaceHolderLabel:(NSString *)placeholder {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidChangeNotification object:self];
    if (self.placeholderLabel) {
        [self.placeholderLabel removeFromSuperview];
    }
    /*
     *  占位字符
     */
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.font = self.placeholdFont;
    self.placeholderLabel.text = placeholder;
    self.placeholderLabel.numberOfLines = 0;
    self.placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.placeholderLabel.textColor = self.placeholdColor;
    CGRect rect = [placeholder boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame)-7, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.placeholdFont} context:nil];
    self.placeholderLabel.frame = CGRectMake(7, 7, rect.size.width, rect.size.height);
    [self addSubview:self.placeholderLabel];
    self.placeholderLabel.hidden = self.text.length > 0 ? YES : NO;
    self.wordCountLabel.text = [NSString stringWithFormat:@"%lu/%@",(unsigned long)self.text.length,self.limitLength];
    
}

#pragma mark -- 配置字数限制标签

- (void)setWordcountLable:(NSNumber *)limitLength {
    if (self.wordCountLabel) {
        [self.wordCountLabel removeFromSuperview];
    }
    /*
     *  字数限制
     */
    CGFloat height = CGRectGetHeight(self.frame);
    if (self.contentSize.height > height) {
        height = self.contentSize.height;
    }
    self.wordCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height - 20, CGRectGetWidth(self.frame) - 10, 20)];
    
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    self.wordCountLabel.textColor = self.limitPlaceColor;
    self.wordCountLabel.font = self.limitPlaceFont;
    if (self.text.length > [limitLength integerValue]) {
        self.text = [self.text substringToIndex:[self.limitLength intValue]];
    }
    self.wordCountLabel.text = [NSString stringWithFormat:@"%lu/%@",(unsigned long)self.text.length,limitLength];
    [self addSubview:self.wordCountLabel];
}

#pragma mark -- 增加限制位数的通知
- (void)addLimitLengthObserver:(int)length {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitLengthEvent) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark -- 限制输入的位数
- (void)limitLengthEvent {
    
    if (self.limitLength) {//字数限制
        NSString *keyboardType = self.textInputMode.primaryLanguage;
        if ([keyboardType isEqualToString:@"zh-Hans"]) {//对简体中文做特殊处理>>>>高亮拼写问题
            UITextRange *range = [self markedTextRange];
            if (!range) {
                if (self.text.length > [self.limitLength intValue]) {
                    self.text = [self.text substringToIndex:[self.limitLength intValue]];
                    NSLog(@"Maximum number of words");
                }else {/*有高亮不做限制*/}
            }
        }else {
            if ([self.text length] > [self.limitLength intValue]) {
                self.text = [self.text substringToIndex:[self.limitLength intValue]];
                NSLog(@"Maximum number of words");
            }
        }
    }else {
        if (self.limitLines) {//行数限制
            CGSize size = [self getStringPlaceSize:self.text textFont:self.font bundingSize:CGSizeMake(self.contentSize.width-10, CGFLOAT_MAX)];
            if (size.height > self.font.lineHeight * [self.limitLines intValue]) {
                self.text = [self.text substringToIndex:self.text.length - 1];
                NSLog(@"Maximum number of lines");
            }
        }
    }
    
}


#pragma mark -- NSNotification

- (void)textViewChanged:(NSNotification *)notification {
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
    }
    if (self.autoHeight) {
        CGSize size = [self getStringPlaceSize:self.text textFont:self.font bundingSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT)];
        CGRect oldRect = self.oldFrame.CGRectValue;
        [UIView animateWithDuration:0.15 animations:^{
            self.frame = CGRectMake(oldRect.origin.x, oldRect.origin.y, oldRect.size.width, size.height + 25 <= oldRect.size.height ? oldRect.size.height : size.height + 25);
        }];
    }
    
}

- (CGSize)getStringPlaceSize:(NSString *)string textFont:(UIFont *)font bundingSize:(CGSize)boundSize {
    ///计算文本高度
    NSDictionary *attribute = @{NSFontAttributeName:font};
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [string boundingRectWithSize:boundSize options:option attributes:attribute context:nil].size;
    return size;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.limitLength && self.wordCountLabel) {
        /*
         *  避免外部使用了约束 这里再次更新frame
         */
        CGFloat height = CGRectGetHeight(self.frame);
        if (self.contentSize.height > height) {
            height = self.contentSize.height;
        }
        self.wordCountLabel.frame = CGRectMake(0, height - 20, CGRectGetWidth(self.frame) - 10, 20);
    }
    if (self.placeholder && self.placeholderLabel) {
        CGRect rect = [self.placeholder boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame)-7, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.placeholdFont} context:nil];
        self.placeholderLabel.frame = CGRectMake(7, 7, rect.size.width, rect.size.height);
    }
    if ([self.autoHeight isEqual:@1]) {
        CGRect currentFrame = self.frame;
        self.oldFrame = [NSValue valueWithCGRect:currentFrame];
    }
    
}

@end
