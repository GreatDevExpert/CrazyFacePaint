//
//  DVAdKitWebViewBlockDelegate.m
//  Pods
//
//  Created by William Locke on 10/7/14.
//
//

#import "DVAdKitWebViewBlockDelegate.h"

@implementation DVAdKitWebViewBlockDelegate

- (instancetype)initWithDidFailLoadWithError:(DVAdKitWebViewBlockDelegateDidFailLoadWithError)didFailLoadWithError didStartLoad:(DVAdKitWebViewBlockDelegateDidStartLoad)didStartLoad didFinishLoad:(DVAdKitWebViewBlockDelegateDidFinishLoad)didFinishLoad shouldStartLoadWithRequest:(DVAdKitWebViewBlockDelegateShouldStartLoadWithRequest)shouldStartLoadWithRequest
{
    self = [super init];
    if (self) {
        _didFailLoadWithError = [didFailLoadWithError copy];
        _didFinishLoad = [didFinishLoad copy];
        _didStartLoad = [didStartLoad copy];
        _shouldStartLoadWithRequest = [shouldStartLoadWithRequest copy];
    }
    return self;
}


+ (DVAdKitWebViewBlockDelegate *)blockDelegateWithDidFailLoadWithError:(DVAdKitWebViewBlockDelegateDidFailLoadWithError)didFailLoadWithError didStartLoad:(DVAdKitWebViewBlockDelegateDidStartLoad)didStartLoad didFinishLoad:(DVAdKitWebViewBlockDelegateDidFinishLoad)didFinishLoad shouldStartLoadWithRequest:(DVAdKitWebViewBlockDelegateShouldStartLoadWithRequest)shouldStartLoadWithRequest{
    return [[DVAdKitWebViewBlockDelegate alloc] initWithDidFailLoadWithError:didFailLoadWithError didStartLoad:didStartLoad didFinishLoad:didFinishLoad shouldStartLoadWithRequest:shouldStartLoadWithRequest];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if(_didFailLoadWithError){
        _didFailLoadWithError(webView, error);
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    if(_didFinishLoad){
        _didFinishLoad(webView);
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    if(_didStartLoad){
        _didStartLoad(webView);
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request  navigationType:(UIWebViewNavigationType)navigationType{
    if(_shouldStartLoadWithRequest){
        _shouldStartLoadWithRequest(webView, request, navigationType);
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]){
        return [self.delegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    return YES;
}

@end
