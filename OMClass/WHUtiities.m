//
//  WHUtiities.m
//  WKMaybell
//
//  Created by 何文虎 on 2018/12/5.
//  Copyright © 2018年 何文虎. All rights reserved.
//

#import "WHUtiities.h"
#define BLANKSTRING(str) ((str==nil||![str isKindOfClass:[NSString class]]||str.length<=0)?@"":str)

@implementation WHUtiities
//获取版本号
+(NSString*)getCFBundleVersion{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}

+ (NSString *)getUUID {
    
    return [[UIDevice currentDevice] identifierForVendor].UUIDString;
    
}

/*MD5加密*/
+ (NSString *)md5StrWithString:(NSString *)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}

+ (NSString*)getTimeStringWithDate:(NSDate*)date{
    NSDateFormatter*formatter =[[NSDateFormatter alloc]init];

    //设置日期格式
    [formatter setDateFormat:@"yyyy.MM.dd"];
    //当前日期
    NSString*currentDateString =[formatter stringFromDate:date];

    return currentDateString;
}

+ (NSString *)getLastYear:(NSInteger)year{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *nowDateStr = [formatter stringFromDate:currentDate];
   
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
        [lastMonthComps setYear:year]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
//    [lastMonthComps setMonth:n];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    NSString *beforeDateStr = [formatter stringFromDate:newdate];
    
    return beforeDateStr;
}

+ (NSString *)getNexMonth:(NSInteger)n{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *nowDateStr = [formatter stringFromDate:currentDate];
   
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:n];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    NSString *beforeDateStr = [formatter stringFromDate:newdate];
    
    return beforeDateStr;
}

/*获取当前时间戳*/
+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
}

//获取当前时间戳.毫秒
+(NSString *)getNowTimeTimestamp3{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
}



//获取本地资源包的文件夹个数
+(NSArray*)getNSFileArrayWithPath:(NSString*)path{
    
    BOOL isDir;
    if ([[NSFileManager defaultManager] fileExistsAtPath:BLANKSTRING(path) isDirectory:(&isDir)] ) {
        NSError *error;
        NSArray *filesArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:&error];
        return filesArray;
    }
    return nil;
}

+ (NSString*)getTimeStrWithTimeInterval:(NSString*)time{
    NSTimeInterval interval = [time doubleValue] / 1000.0;

    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:interval];
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm"]; // HH:mm:ss
    NSString *currentDateStr = [dateFormatter stringFromDate: timeData];
    
    return currentDateStr;
}

//根据时间戳获取日期
+(NSString*)getTimeWithDate:(NSString*)date{
    //   double da = [date doubleValue];
    //    NSDate *newdate = [NSDate dateWithTimeIntervalSince1970:da/1000.0];
    //    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    //    [inputFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    //    NSString *timeos = [inputFormatter stringFromDate:newdate];
    //    return timeos;
    
    NSTimeInterval time = [date doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"]; // HH:mm:ss
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
    
    
}

//该日期是周几
+(NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

//该日期是不是周六日
+(BOOL)isweekendFromDate:(NSDate*)inputDate {
    if (inputDate !=nil) {
        NSString *str = [self weekdayStringFromDate:inputDate];
        if ([str isEqualToString:@"星期六"] || [str isEqualToString:@"星期天"]) {
            return YES;
        }
    }

    return NO;;
    
}


//当月第一天和最后一天
+ (NSArray *)getMonthFirstAndLastDay{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
//    NSDate *newDate=[format dateFromString:dateStr];
    NSDate *newDate = [NSDate date];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];

    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @[@"",@""];
    }

    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstString = [myDateFormatter stringFromDate: firstDate];
    NSString *lastString = [myDateFormatter stringFromDate: lastDate];
    return @[firstString, lastString];
}

/*根据日期格式获取时间戳*/
+(NSDate*)getdateWithTimeStr:(NSString*)timeStr{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // NSString * -> NSDate *
    NSDate *date = [fmt dateFromString:timeStr];
    
    return date;
    
}

/*根据日期格式获取时间戳*/
+(NSDate*)getDateWithTimeStr2:(NSString*)timeStr2{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy.MM.dd";
    [fmt setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
    // NSString * -> NSDate *
    NSDate *date = [fmt dateFromString:timeStr2];
    
    return date;
    
}

//是否为同一天
+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    return [comp1 day] == [comp2 day] && [comp1 month] == [comp2 month] && [comp1 year]  == [comp2 year];
}

//获取当年第一天时间
+(NSString*)getNowYearFirstTime{
        NSDateFormatter *format=[[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
    //    NSDate *newDate=[format dateFromString:dateStr];
        NSDate *newDate = [NSDate date];
        double interval = 0;
        NSDate *firstDate = nil;
        NSDate *lastDate = nil;
        NSCalendar *calendar = [NSCalendar currentCalendar];

        BOOL OK = [calendar rangeOfUnit:NSCalendarUnitYear startDate:& firstDate interval:&interval forDate:newDate];
        
        if (OK) {
            lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
        }else {
           return @[@""];
        }

        NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
        [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *firstString = [myDateFormatter stringFromDate: firstDate];
//        NSString *lastString = [myDateFormatter stringFromDate: lastDate];
    
    return firstString;
}

//获取当前月第一天时间
+(NSString*)getNowMonthFirstTime{
        NSDateFormatter *format=[[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
    //    NSDate *newDate=[format dateFromString:dateStr];
        NSDate *newDate = [NSDate date];
        double interval = 0;
        NSDate *firstDate = nil;
        NSDate *lastDate = nil;
        NSCalendar *calendar = [NSCalendar currentCalendar];

        BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
        
        if (OK) {
            lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
        }else {
           return @[@""];
        }

        NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
        [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *firstString = [myDateFormatter stringFromDate: firstDate];
//        NSString *lastString = [myDateFormatter stringFromDate: lastDate];
    
    return firstString;
}


//获取当前时间
+(NSString*)getNowTime{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

//获取当前时间
+(NSString*)getNowTimeP{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}


//获取当前时间HHMM
+(NSString*)getNowTimeHHmm{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

//获取当前时间指定格式
+(NSString*)getNowTime:(NSString *)formatStr {
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatStr];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

/*根据日期格式获取时间戳*/
+(NSDate*)getdateHHMMWithTimeStr:(NSString*)timeStr{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    
    // NSString * -> NSDate *
    NSDate *date = [fmt dateFromString:timeStr];
    
    return date;
    
}

/*比较两个时间的大小 比oneDay大返回1,比one小或相等返回-1*/
+ (BOOL)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        //        return 1;
        return YES;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        //        return -1;
        return NO;
        
    }
    //NSLog(@"Both dates are the same");
    //    return 0;
    return NO;
    
}


/**
 *  转换为Base64编码
 */
+(NSString *)base64EncodedStringWithStr:(NSString*)str
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}
/**
 *  将Base64编码还原
 */
+(NSString *)base64DecodedStringWithStr:(NSString*)str
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:str options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstCharactor:(NSString *)aString
{
    if (aString==nil||![aString isKindOfClass:[NSString class]]||aString.length<=0) {
        return @"#";
    }
    
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
    
    
    
}

+(NSMutableAttributedString*)setLableAttributedStringWithstr:(NSString*)str loc:(NSInteger)loc len:(NSInteger)len color:(UIColor*)color{
    NSMutableAttributedString *attributedstr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = NSMakeRange (loc, len);
    [attributedstr addAttribute:NSForegroundColorAttributeName
                          value:color
                          range:range];
    return attributedstr;
}


+ (NSAttributedString *)insertString:(NSString *)insertStr
                      InsertStrColor:(UIColor *)insertStrColor
                    intoTargetString:(NSString *)targetStr
                      TargetStrColor:(UIColor *)targetStrColor
                          OnLocation:(NSInteger)location // OriginalString
{
    NSMutableAttributedString *tarAStr = [[NSMutableAttributedString alloc]initWithString:targetStr];
    NSRange tarARange = NSMakeRange(0, tarAStr.length);
    [tarAStr addAttribute:NSForegroundColorAttributeName value:targetStrColor range:tarARange];
    
    if (insertStr == nil)
    {
        insertStr = @"";
    }
    NSMutableAttributedString *inserAStr = [[NSMutableAttributedString alloc]initWithString:insertStr];
    NSRange insertRange = NSMakeRange(0, inserAStr.length);
    [inserAStr addAttribute:NSForegroundColorAttributeName value:insertStrColor range:insertRange];
    
    [tarAStr insertAttributedString:inserAStr atIndex:location];
    
    return [tarAStr copy];
}


//字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {

        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
}

//字典转字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

//视频转base64
+ (NSString *)video2DataPath:(NSString *)videoPath
{
    NSString *mimeType = [videoPath componentsSeparatedByString:@"."].lastObject;
    NSData *data = [NSData dataWithContentsOfFile:videoPath];
    NSString *base64String = [NSString stringWithFormat:@"data:video/%@;base64,%@", mimeType,
     [data base64EncodedStringWithOptions:0]];
  

    return base64String;
}

//图片转字符串
+ (NSString *)image2DataURL:(UIImage *)image
{
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    //图片要压缩的比例，后台要求是150的高度，这个150可以根据你的需求改动
//    CGFloat x= 150/image.size.height;
//    if (x>1) {
//        x=1.;
//    }
    
    //根据需要的格式把图片按比例，压缩成相应大小的文件。
    //如果是png格式则可用 UIImagePNGRepresentation
    //    imageData = UIImageJPEGRepresentation(image, x);
    //    imageData = UIImagePNGRepresentation(image);
    
    //    imageData = UIImageJPEGRepresentation(image, 1);
    
    //和服务器商量的格式，这个是标准格式，但是 data:%@ 这一块包括 base64, 都可以写在服务器
    //如果是png格式则 image/png
    //    mimeType = @"image/jpeg";
    
    
    if (UIImagePNGRepresentation(image) == nil) {
        
        imageData = UIImageJPEGRepresentation(image, 1);
        mimeType = @"image/jpeg";
        
    } else {
        
        imageData = UIImagePNGRepresentation(image);
        mimeType = @"image/png";
        
    }
    
    
    
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions: 0]];
}



//计算文字的宽高
+(CGSize)sizeWithString:(NSString* )string font:(UIFont* )font constraintSize:(CGSize)constraintSize
{
    CGSize stringSize = CGSizeZero;
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    NSInteger options = NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
    CGRect stringRect = [string boundingRectWithSize:constraintSize options:options attributes:attributes context:NULL];
    stringSize = stringRect.size;
    
    return CGSizeMake(ceil(stringSize.width), ceil(stringSize.height));;
}


+ (float) heightForString:(NSString *)value andWidth:(float)width{
    //获取当前文本的属性
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
    //    _text.attributedText = attrStr;
    NSRange range = NSMakeRange(0, attrStr.length);
    
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width - 16.0, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height + 16.0;
}


+(CGRect)getTextRectWith:(NSString *)str WithMaxWidth:(CGFloat)width  WithlineSpacing:(CGFloat)LineSpacing AddLabel:(UILabel *)label{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle * parageraphStyle = [[NSMutableParagraphStyle alloc]init];
    [parageraphStyle setLineSpacing:LineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:parageraphStyle range:NSMakeRange(0, [str length])];
    [attributedString addAttribute:NSFontAttributeName value:label.font range:NSMakeRange(0, str.length)];
    
    label.attributedText = attributedString;
    
    CGSize size = [self autoHeightOfLabel:label with:width];
    
    CGRect labelF = label.frame;
    labelF.size.height = size.height;
    label.frame = labelF;
    
    
    return labelF;
}

/**
 计算Label高度
 
 @param label 要计算的label，设置了值
 @param width label的最大宽度
 @param type 是否从新设置宽，1设置，0不设置
 */
+(CGSize )autoHeightOfLabel:(UILabel *)label with:(CGFloat )width{
    //Calculate the expected size based on the font and linebreak mode of your label
    // FLT_MAX here simply means no constraint in height
    CGSize maximumLabelSize = CGSizeMake(width, FLT_MAX);
    
    CGSize expectedLabelSize = [label sizeThatFits:maximumLabelSize];
    
    //adjust the label the the new height.
    CGRect newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    label.frame = newFrame;
    [label updateConstraintsIfNeeded];
    
    return expectedLabelSize;
}


+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}


+(void)poAppVersonWithAppId:(NSString*)appId Block:(void (^)(id  x))block{
    //    1296194716
//    [WHNetworking postWithUrl:[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@",appId] refreshCache:NO params:nil success:^(id response) {
//        NSArray *array = response[@"results"];
//        NSDictionary *dict = [array lastObject];
//        
//        if (block) {
//            
//            block( dict[@"version"]);
//        }
//    } fail:^(NSError *error) {
//        
//    }];
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController*)currentViewController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
    
}

+ (UIViewController *)getCurrentTopViewController {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    if ([window subviews].count >= 1) {
        UIView *frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]){
            result = nextResponder;
        } else {
            result = window.rootViewController;
        }
    }
    return result;
}
@end
