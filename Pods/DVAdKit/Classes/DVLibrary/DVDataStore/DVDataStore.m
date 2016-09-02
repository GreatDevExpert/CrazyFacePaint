//
//  NFData.m
//  NinjafishStudiosApp
//
//  Created by William Locke on 9/17/12.
//  Copyright (c) 2012 William Locke. All rights reserved.
//


#import "DVDataStore.h"
//#import "NFCategories.h"
#import "SBJsonParser.h"

@implementation DVDataStore

+(BOOL)archiveObject:(id)object forKey:(NSString *)key{
    return [NSKeyedArchiver archiveObject:object forKey:key];
}

+(id)objectForKey:(NSString *)key{
    return [NSKeyedUnarchiver objectForKey:key];
}

+(id)objectFromFile:(NSString *)resource{
    NSString *ext = [resource pathExtension];
    NSString *base = [resource stringByDeletingPathExtension];
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:base ofType:ext]];
    return [self jsonObjectFromData:data];
}


// TODO: Make this function all json object from string.
+(id)jsonObjectFromData:(NSData *)data{
    if (!data) {
        return nil;
    }
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    id object =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if (object) {
        return object;
    }
    return [parser objectWithString:string];
}




@end
