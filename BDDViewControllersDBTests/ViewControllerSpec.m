//  ViewControllerSpec.m
//  BDDViewControllersDB

#import "ViewController_Extensions.h"
#import "LoginService.h"

typedef void (^LoginServiceCompletionBlock)(BOOL isValid);

SpecBegin(ViewController)
    describe(@"ViewController", ^{
        
        __block ViewController *vc;
        
        // Will be run before each enclosed it
        beforeEach(^{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UINavigationController *nc = [storyboard instantiateInitialViewController];
            vc = (ViewController *)nc.visibleViewController;

            expect(vc.view).toNot.beNil();
        });
        
        it(@"should be instantiated from the storyboard", ^{
            expect(vc).toNot.beNil();
            expect(vc).to.beInstanceOf([ViewController class]);
        });
        
        it(@"should have an outlet for the username field", ^{
            expect(vc.usernameTextField).toNot.beNil();
        });
        
        it(@"should have an outlet for the password field", ^{
            expect(vc.passwordTextField).toNot.beNil();
        });
        
        it(@"should wire up the login button action", ^{
            NSArray *actions = [vc.loginButton actionsForTarget:vc forControlEvent:UIControlEventTouchUpInside];
            expect(actions.firstObject).to.equal(@"loginButtonTapped:");
        });
        
        describe(@"logging in", ^{
            __block id mockLoginService;
            
            beforeEach(^{
                mockLoginService = [OCMockObject mockForClass:[LoginService class]];
            });
            
            afterEach(^{
                [mockLoginService verify];
            });

            it(@"should verify username & password with the login service", ^{
                id mockLoginService = [OCMockObject mockForClass:[LoginService class]];
                [[mockLoginService expect] loginWithUsername:@"username" password:@"password" completion:[OCMArg any]];
                
                vc.usernameTextField.text = @"username";
                vc.passwordTextField.text = @"password";
                
                [vc loginButtonTapped:vc.loginButton];
            });
            context(@"with invalid credentials", ^{
                beforeEach(^{
                    [[mockLoginService stub] loginWithUsername:[OCMArg any] password:[OCMArg any] completion:[OCMArg checkWithBlock:^BOOL(LoginServiceCompletionBlock obj) {
                        obj(NO);
                        return NO;
                    }]];
                });
                
                 it(@"should show an alert", ^{
                     UIAlertController *alertController = [UIAlertController new];
                     
                     id classMockAlertController = [OCMockObject mockForClass:[UIAlertController class]];
                     [[[classMockAlertController stub] andReturn:alertController] alertControllerWithTitle:[OCMArg any] message:[OCMArg any] preferredStyle:UIAlertControllerStyleAlert];
                     
                     id mockAlertController = [OCMockObject partialMockForObject:alertController];
                     [[mockAlertController expect] addAction:[OCMArg any]];
                     
                     id mockVC = [OCMockObject partialMockForObject:vc];
                     [[mockVC expect] presentViewController:alertController animated:YES completion:nil];
                     
                     [vc loginButtonTapped:vc.loginButton];
                     
                     [mockVC verify];
                     //[mockAlertController verify];
                 });
                
                // [mockLoginService loginWithUsername:[OCMArg any] password:[OCMArg any] compl]
//                
//                beforeEach(^{
//                    
//                    
////                    alertProvider = [OCMockObject mockForClass:[AlertViewProvider class]];
////                    vc.alertProvider = alertProvider;
////                    
////                    [[mockLoginService stub] verifyUsername:[OCMArg any]
////                                                    password:[OCMArg any]
////                                                  completion:[OCMArg checkWithBlock:^BOOL(LoginServiceCompletionBlock block) {
////                        block(NO);
////                        return YES;
////                    }]];
//                });
//                it(@"should show an alert", ^{
//                    id mockAlert = [OCMockObject mockForClass:[UIAlertView class]];
//                    [[[alertProvider expect] andReturn:mockAlert] alertViewWithTitle:[OCMArg any]
//                                                                              message:[OCMArg any]];
//                    [[mockAlert expect] show];
//                    
//                    [vc loginTapped:nil];
//                    
//                    [alertProvider verify];
//                    [mockAlert verify];
//                });
//            });
//            context(@"valid credentials", ^{
//                beforeEach(^{
//                    [[mockLoginService stub] verifyUsername:[OCMArg any]
//                                                    password:[OCMArg any]
//                                                  completion:[OCMArg checkWithBlock:^BOOL(LoginServiceCompletionBlock block) {
//                        block(YES);
//                        return YES;
//                    }]];
//                });
//                
//                it(@"should push the welcome view controller", ^{
//                    [vc loginTapped:nil];
//                    
//                    expect(vc.navigationController.visibleViewController).to.beInstanceOf([WelcomeViewController class]);
//                });
            });
        });
    });
SpecEnd