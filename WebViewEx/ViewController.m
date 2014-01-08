//
//  ViewController.m
//  WebViewEx
//
//  Created by yg on 14. 1. 9..
//  Copyright (c) 2014년 yg. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if(UIWebViewNavigationTypeLinkClicked == navigationType) {
		NSLog(@"링크 클릭 금지!");
		return NO;
	}
	return YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	NSString *msg = [error localizedDescription];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"에러" message:msg delegate:nil cancelButtonTitle:@"확인" otherButtonTitles: nil];
	[alert show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self go:nil];
	return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)go:(id)sender {
	NSString *address = self.textField.text;
	if([address length] > 3) {
		if(![address hasPrefix:@"http://"]) {
			address = [NSString stringWithFormat:@"http://%@",self.textField.text];
		}
		
		NSURL *url = [NSURL URLWithString:address];
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		[self.webView loadRequest:request];
		[self.textField resignFirstResponder];
		
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
