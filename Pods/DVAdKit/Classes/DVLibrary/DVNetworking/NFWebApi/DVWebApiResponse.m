//
//  NFWebApiResponse.m
//  Pods
//
//  Created by William Locke on 3/21/13.
//
//

#import "DVWebApiResponse.h"
#import "DVDataStore.h"

@implementation DVWebApiResponse

-(id)initWithUrlResponse:(NSURLResponse *)response
                    data:(NSData *)data
                   error:(NSError *)error{

    self = [super init];
    
    if(self){
        
        _response = response;
        
        NSDictionary *jsonObject = [DVDataStore jsonObjectFromData:data];
        if([jsonObject isKindOfClass:[NSDictionary class]]){
            NSDictionary *errorDictionary;
            NSDictionary *dataDictionary;

            if((errorDictionary = [jsonObject objectForKey:@"error"])){
                
                NSNumber *codeNumber;
                NSString *domain = @"";
                if([errorDictionary isKindOfClass:[NSDictionary class]]){
                    codeNumber = [errorDictionary objectForKey:@"code"];
                    if([errorDictionary objectForKey:@"domain"]){
                        domain = [errorDictionary objectForKey:@"domain"];
                    }
                }
                int code;
                if(codeNumber){
                    code = [codeNumber intValue];
                }

                self.error = [[NSError alloc] initWithDomain:domain code:code userInfo:errorDictionary];
                self.errorDictionary = errorDictionary;
            }
            
            if((dataDictionary = [jsonObject objectForKey:@"data"])){
                if([dataDictionary isKindOfClass:[NSDictionary class]]){
                    self.data = [DVWebApiResponseData instanceFromDictionary:dataDictionary];

                }else if([dataDictionary isKindOfClass:[NSArray class]]){
                    self.data = [[DVWebApiResponseData alloc] init];
                    [self.data setItems:(NSArray *)dataDictionary];
                }

            }else{
                self.data = [DVWebApiResponseData instanceFromDictionary:dataDictionary];
            }
            
            
        }else if([jsonObject isKindOfClass:[NSArray class]]){
            
            self.data = [[DVWebApiResponseData alloc] init];
            [self.data setItems:(NSArray *)jsonObject];
        }else{
            self.data = [[DVWebApiResponseData alloc] init];
            [self.data setData:data];
        }
    }
    
    return self;
}


@end
