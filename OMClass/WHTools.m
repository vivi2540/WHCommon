//
//  WHTools.m
//  LocationSay
//
//  Created by 何文虎 on 2019/7/27.
//  Copyright © 2019 何文虎. All rights reserved.
//

#import "WHTools.h"
#define PHOTOCACHEPATH [NSTemporaryDirectory() stringByAppendingPathComponent:@"photoCache"]
#define VIDEOCACHEPATH [NSTemporaryDirectory() stringByAppendingPathComponent:@"videoCache"]
@implementation WHTools

+ (double)scaleInView {
    const double wid = [[UIScreen mainScreen] bounds].size.width;
    const double hid = [[UIScreen mainScreen] bounds].size.height;
    
    if (hid < 568) {
        return 0.9;
    } else if ( wid <= 320 ) {
        return 0.95;
    } else if (wid <= 375){
        return 1;
    } else {
        return 1.05;
    }
}

+ (BOOL)isPhoneNumber:(NSString *)number {
    NSString *phoneRegex1=@"^1[0-9]{10}$";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return  [phoneTest1 evaluateWithObject:number];
}

/** 密码有效性 */
+ (BOOL)isValidPassword:(NSString *)str {
    NSString *pattern = @"^([a-zA-Z]|[a-zA-Z0-9]|[0-9]){6,18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

/** 验证码有效性 */
+ (BOOL)isValidCheckCode:(NSString *)str {
    NSString *pattern = @"^([0-9]){6}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}
/** 邮箱 */
+  (BOOL)isEmail:(NSString*)email{
    NSString*emailRegex =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate*emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return[emailTest evaluateWithObject:email];
}

/**
 *  身份证号验证(粗略验证)
 */
+ (BOOL)isValidateIdentityCard:(NSString *)identityCard
{
    //    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSString *pattern = @"([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:identityCard];
    
    return isMatch;
}

/**
 *判断字符串为空
 */
+ (BOOL)isEmpty:(NSString *)string {
    if (string == nil) {
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (!string || [string isEqualToString:@""]) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//四舍五入
+(float)roundFloat:(float)price{
    
    return roundf(price*1)/1;
    
}

+ (BOOL)isPositive:(NSString*)string {
    NSString *regex = @"^[1-9]\\d*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isPureInt:(NSString *)string {
    NSString *regex = @"^[0-9]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}


//判断字符串是否为浮点数
+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (NSString *)getConstellationWithMonth:(int )month day:(int)day {
    NSString *star = nil;
    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
        star = @"水瓶座";
    }
    if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
        star = @"双鱼座";
    }
    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
        star = @"白羊座";
    }
    if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
        star = @"金牛座";
    }
    if ((month == 5 && day >= 21) || (month == 6 && day <= 21)) {
        star = @"双子座";
    }
    if ((month == 6 && day >= 22) || (month == 7 && day <= 22)) {
        star = @"巨蟹座";
    }
    if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
        star = @"狮子座";
    }
    if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
        star = @"处女座";
    }
    if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
        star = @"天秤座";
    }
    if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
        star = @"天蝎座";
    }
    if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
        star = @"射手座";
    }
    if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) {
        star = @"摩羯座";
    }
    return star;
}

+ (int)convertStringLengthToInt:(NSString *)strtemp {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [strtemp dataUsingEncoding:enc];
    return (int)[da length];
}

+ (NSString *)substringOfLengthWithBytesLength:(int)bytes text:(NSString *)text {
    NSUInteger totalLength = 0;
    NSMutableString *m = [[NSMutableString alloc] initWithCapacity:0];
    for (int i = 0; i < text.length;) {
        NSRange charRange = [text rangeOfComposedCharacterSequenceAtIndex:i];
        NSString *s = [text substringWithRange:charRange];
        totalLength += [WHTools convertStringLengthToInt:s];
        i += charRange.length;
        if (totalLength > bytes) {
            return m;
        } else {
            [m appendString:s];
        }
    }
    return @"";
}

//判断一个字符是不是中文。
+ (BOOL)isChinese:(NSString*)str {
    int strlength = 0;
    char* p = (char*)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return ((strlength/2)==1)?YES:NO;
}



+ (BOOL)isStringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) { returnValue = YES;
            }
        } else {
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
}


+ (NSUInteger)utf8LengthWithText:(NSString *)string {
    size_t length = strlen([string UTF8String]);
    return length;
}

+ (NSString *)getStringInsideNumberWithString:(NSString *)string {
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number;
    [scanner scanInt:&number];
    NSString *num = [NSString stringWithFormat:@"%d",number];
    return num;
}


/**
 移除无效的空白字符，避免恶意输入
 */
+ (NSString *)removeInvalidWhitespaceWithText:(NSString *)text {
    if ([WHTools isEmpty:text]) {
        return nil;
    }
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\n{2,}" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *arr = [regex matchesInString:text options:NSMatchingReportCompletion range:NSMakeRange(0, [text length])];
    arr = [[arr reverseObjectEnumerator] allObjects];
    for (NSTextCheckingResult *str in arr) {
        text = [text stringByReplacingCharactersInRange:str.range withString:@"\n"];
    }
    
    if ([text isEqualToString:@"\n"]) {
        return @"";
    }
    
    
    NSError *error1 = nil;
    NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:@" {2,}" options:NSRegularExpressionCaseInsensitive error:&error1];
    NSArray *arr1 = [regex1 matchesInString:text options:NSMatchingReportCompletion range:NSMakeRange(0, [text length])];
    arr1 = [[arr1 reverseObjectEnumerator] allObjects];
    for (NSTextCheckingResult *str in arr1) {
        text = [text stringByReplacingCharactersInRange:[str range] withString:@"  "];
    }
    
    if ([text isEqualToString:@"  "]) {
        return @"";
    }
    
    NSError *error2 = nil;
    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"\\r{2,}" options:NSRegularExpressionCaseInsensitive error:&error2];
    NSArray *arr2 = [regex2 matchesInString:text options:NSMatchingReportCompletion range:NSMakeRange(0, [text length])];
    arr2 = [[arr2 reverseObjectEnumerator] allObjects];
    for (NSTextCheckingResult *str in arr2) {
        text = [text stringByReplacingCharactersInRange:str.range withString:@"\r"];
    }
    
    if ([text isEqualToString:@"\r"]) {
        return @"";
    }
    
    return text;
}


+ (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

+ (NSString*)saveImage:(UIImage *)image toCachePath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:PHOTOCACHEPATH]) {
        NSLog(@"路径不存在, 创建路径");
        [fileManager createDirectoryAtPath:PHOTOCACHEPATH
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    } else {
        NSLog(@"路径存在");
    }
    //[UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
    [UIImageJPEGRepresentation(image, 1) writeToFile:path atomically:YES];
    
    NSString * str = [NSString stringWithFormat:@"%@%@.jpg",PHOTOCACHEPATH,path];
    
    return str;
}

//从缓存路径获取照片
+ (UIImage *)getImageFromPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return [UIImage imageWithContentsOfFile:path];
    }
    return nil;
}

//以当前时间合成图片名称
+ (NSString *)getImageNameBaseCurrentTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    return [[dateFormatter stringFromDate:[NSDate date]] stringByAppendingString:@".png"];
}



/**
 json转字典
 
 @param jsonString json串
 @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


/**
 字典转json串
 
 @param dict 字典
 @return json串
 */
+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

+ (NSString *)distanceTimeWithBeforeTime:(double)beTime
{
    NSTimeInterval interval = beTime / 1000.0;
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    double distanceTime = now - interval;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];

    
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    }
    else if (distanceTime <60*60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }
    else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        //        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
        distanceStr = [NSString stringWithFormat:@"%ld小时前",(long)distanceTime/(60*60)];
    }
    else if(distanceTime<24*60*60*2 && [nowDay integerValue] != [lastDay integerValue]){
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
        else{
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
        
    }
    else if(distanceTime <24*60*60*365){
        [df setDateFormat:@"MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    else{
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}
#pragma mark - 判断字符串为空
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    NSString *str = [NSString stringWithFormat:@"%@",string];
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
        
    }
    return NO;
}
#pragma mark 判断数组为空
+(BOOL)isBlankArr:(NSArray *)array{
    // && array.count != 0
    if (array != nil && ![array isKindOfClass:[NSNull class]] ){
        
        return NO;
        
    }
    else{
        return YES;
    }
    
}

+ (BOOL)isBlankDictionary:(NSDictionary *)dic {
    
    if (!dic) {
        return YES;
    }
    if ([dic isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if (![dic isKindOfClass:[NSDictionary class]]){
        return YES;
        
    }
    if (!dic.count){
        return YES;
    }
    if (dic == nil){
        return YES;
        
    }
    
    if (dic == NULL){
        return YES;
        
    }
    
    return NO;
    
}

+ (UIViewController *)findVC:(UIView *)view{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+(void)removeSubViews:(UIView*)superView{
    for (UIView *view in superView.subviews) {
        [view removeFromSuperview];
    }
}
#pragma mark  找到cell 的tableview
+ (UITableView *)findTableView:(UITableViewCell *)cell
{
    UIView *tableView = cell.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
        
    }
    return (UITableView *)tableView;
    
}

+ (UICollectionView *)findCollectionView:(UICollectionViewCell *)cell
{
    UIView *collectionView = cell.superview;
    while (![collectionView isKindOfClass:[UICollectionView class]] && collectionView) {
        collectionView = collectionView.superview;
        
    }
    return (UICollectionView *)collectionView;
    
}
+(UIWindow *)getWindow{
    UIWindow* window = nil;
    
    if (@available(iOS 13.0, *))
    {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes)
        {
            if (windowScene.activationState == UISceneActivationStateForegroundActive)
            {
                window = windowScene.windows.firstObject;
                
                break;
            }
        }
    }else{
        window = [UIApplication sharedApplication].keyWindow;
    }
    
    return window;
}

+(void)makePhoneCall:(NSString*)mobile{
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",mobile];

    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];

    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];

    
}
#pragma mark - 两个nsdate差距几天
+ (NSInteger)getDifferenceByDate:(NSDate *)oldDate {
    //获得当前时间
    NSDate *now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:oldDate  toDate:now  options:0];
    return [comps day];
}

+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime];
    
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]*1000] integerValue];
    
    return timeSp;
    
}

/**
 设置特定文字的颜色

 @param color 搜索到的文字显示的颜色
 @param label 显示所有文字的控件
 @param font 搜索到的文字显示的大小
 @param text 搜索到的文字
 */
+(void)setColor:(UIColor *)color
          label:(UILabel *)label
           font:(UIFont *)font
           text:(NSString *)text
{
    NSRange range = [label.text rangeOfString:text];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    label.attributedText = str;
}



+(BOOL)isSimuLator
{
    if (TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1) {
        //模拟器
        return YES;
    }else{
        //真机
        return NO;
    }
}


/**
 *  从fromString中搜索是否包含searchString
 *
 *  @param searchString 要搜索的字串
 *  @param fromString   从哪个字符串搜索
 *
 *  @return 是否包含字串
 */
+ (BOOL)realtimeSearchString:(NSString *)searchString fromString:(NSString *)fromString
{
    if (!searchString || !fromString || (fromString.length == 0 && searchString.length != 0)) {
        return NO;
    }
    if (searchString.length == 0) {
        return YES;
    }
    
    NSUInteger location = [[fromString lowercaseString] rangeOfString:[searchString lowercaseString]].location;
    return (location == NSNotFound ? NO : YES);
}

@end
