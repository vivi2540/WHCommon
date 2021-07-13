//
//  NSDate+TUIKIT.m
//  TXIMSDK_TUIKit_iOS
//
//  Created by annidyfeng on 2019/5/20.
//

#import "NSDate+TUIKIT.h"

@implementation NSDate (TUIKIT)

- (NSString *)tk_messageString
{
    

    NSTimeInterval interval = [self timeIntervalSince1970];
//    long long interval = interval1*000 ;
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
//            [df setDateFormat:@"yyyy.MM.dd HH:mm"];
            [df setDateFormat:@"MM.dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
        return distanceStr;
    
    
    
    /*
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear ;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[ NSDate date ]];
    NSDateComponents *myCmps = [calendar components:unit fromDate:self];
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init ];
    
    NSDateComponents *comp =  [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:self];
    
    if (nowCmps.year != myCmps.year) {
        dateFmt.dateFormat = @"yyyy/MM/dd";
    }
    else{
        if (nowCmps.day==myCmps.day) {
            dateFmt.dateFormat = @"HH:mm";
        } else if((nowCmps.day-myCmps.day)==1) {
            dateFmt.AMSymbol = @"上午";
            dateFmt.PMSymbol = @"下午";
            dateFmt.dateFormat = @"昨天";
        } else {
            if ((nowCmps.day-myCmps.day) <=7) {
                switch (comp.weekday) {
                    case 1:
                        dateFmt.dateFormat = @"星期日";
                        break;
                    case 2:
                        dateFmt.dateFormat = @"星期一";
                        break;
                    case 3:
                        dateFmt.dateFormat = @"星期二";
                        break;
                    case 4:
                        dateFmt.dateFormat = @"星期三";
                        break;
                    case 5:
                        dateFmt.dateFormat = @"星期四";
                        break;
                    case 6:
                        dateFmt.dateFormat = @"星期五";
                        break;
                    case 7:
                        dateFmt.dateFormat = @"星期六";
                        break;
                    default:
                        break;
                }
            }else {
                dateFmt.dateFormat = @"yyyy/MM/dd";
            }
        }
    }
    return [dateFmt stringFromDate:self];
     */
}

- (NSString *)news_messageString
{
    

    NSTimeInterval interval = [self timeIntervalSince1970];
//    long long interval = interval1*000 ;
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
        
       if(distanceTime <24*60*60*365){
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }else{
            [df setDateFormat:@"yyyy-MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
        return distanceStr;
    
    
    
    /*
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear ;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[ NSDate date ]];
    NSDateComponents *myCmps = [calendar components:unit fromDate:self];
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init ];
    
    NSDateComponents *comp =  [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:self];
    
    if (nowCmps.year != myCmps.year) {
        dateFmt.dateFormat = @"yyyy/MM/dd";
    }
    else{
        if (nowCmps.day==myCmps.day) {
            dateFmt.dateFormat = @"HH:mm";
        } else if((nowCmps.day-myCmps.day)==1) {
            dateFmt.AMSymbol = @"上午";
            dateFmt.PMSymbol = @"下午";
            dateFmt.dateFormat = @"昨天";
        } else {
            if ((nowCmps.day-myCmps.day) <=7) {
                switch (comp.weekday) {
                    case 1:
                        dateFmt.dateFormat = @"星期日";
                        break;
                    case 2:
                        dateFmt.dateFormat = @"星期一";
                        break;
                    case 3:
                        dateFmt.dateFormat = @"星期二";
                        break;
                    case 4:
                        dateFmt.dateFormat = @"星期三";
                        break;
                    case 5:
                        dateFmt.dateFormat = @"星期四";
                        break;
                    case 6:
                        dateFmt.dateFormat = @"星期五";
                        break;
                    case 7:
                        dateFmt.dateFormat = @"星期六";
                        break;
                    default:
                        break;
                }
            }else {
                dateFmt.dateFormat = @"yyyy/MM/dd";
            }
        }
    }
    return [dateFmt stringFromDate:self];
     */
}


@end
