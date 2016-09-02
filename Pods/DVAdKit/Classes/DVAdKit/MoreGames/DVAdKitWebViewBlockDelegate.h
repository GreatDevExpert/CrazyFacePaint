//
//  DVAdKitWebViewBlockDelegate.h
//  Pods
//
//  Created by William Locke on 10/7/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^DVAdKitWebViewBlockDelegateShouldStartLoadWithRequest)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType);
typedef void (^DVAdKitWebViewBlockDelegateDidStartLoad)(UIWebView *webView);
typedef void (^DVAdKitWebViewBlockDelegateDidFinishLoad)(UIWebView *webView);
typedef void (^DVAdKitWebViewBlockDelegateDidFailLoadWithError)(UIWebView *webView, NSError *error);



@interface DVAdKitWebViewBlockDelegate : NSObject<UIWebViewDelegate>
{
    DVAdKitWebViewBlockDelegateShouldStartLoadWithRequest _shouldStartLoadWithRequest;
    DVAdKitWebViewBlockDelegateDidFailLoadWithError _didFailLoadWithError;
    DVAdKitWebViewBlockDelegateDidStartLoad _didStartLoad;
    DVAdKitWebViewBlockDelegateDidFinishLoad _didFinishLoad;
}

@property (nonatomic, unsafe_unretained) id<UIWebViewDelegate> delegate;


+ (DVAdKitWebViewBlockDelegate *)blockDelegateWithDidFailLoadWithError:(DVAdKitWebViewBlockDelegateDidFailLoadWithError)didFailLoadWithError didStartLoad:(DVAdKitWebViewBlockDelegateDidStartLoad)didStartLoad didFinishLoad:(DVAdKitWebViewBlockDelegateDidFinishLoad)didFinishLoad shouldStartLoadWithRequest:(DVAdKitWebViewBlockDelegateShouldStartLoadWithRequest)shouldStartLoadWithRequest;


@end
