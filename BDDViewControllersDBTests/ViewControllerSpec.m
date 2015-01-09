//
//  ViewControllerSpec.m
//  BDDViewControllersDB

#import "ViewController_Extensions.h"
#import "LoginService.h"

/*  Scratchpad
 
 
*/

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
            // vc => login service
            it(@"should verify username & password with the login service", ^{
                id mockLoginService = [OCMockObject mockForClass:[LoginService class]];
                [[mockLoginService expect] loginWithUsername:@"username" password:@"password" completion:[OCMArg any]];
                
                vc.usernameTextField.text = @"username";
                vc.passwordTextField.text = @"password";
                
                [vc loginButtonTapped:vc.loginButton];
                
                [mockLoginService verify];
            });
            
            it(@"should move to the welcome view controller for correct username and password", ^{
                
            });
            
            it(@"should show alert for incorrect username or password", ^{
                
            });
        });
    });
SpecEnd