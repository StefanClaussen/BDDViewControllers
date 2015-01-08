//
//  Test.m
//  BDDViewControllersDB

#import "ViewController.h"

SpecBegin(ViewController)
    describe(@"ViewController", ^{
        
        __block ViewController *vc;
        
        // Will be run before each enclosed it
        beforeEach(^{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"main" bundle:nil];
            vc = [storyboard instantiateInitialViewController];
            UIView *view = vc.view;
            expect(view).toNot.beNil();
        });
        
        it(@"should be instantiated from the storyboard", ^{
            expect(vc).toNot.beNil();
            expect(vc).to.beInstanceOf([ViewController class]);
        });
        
        it(@"should have an outlet for the username field", ^{
            
        });
        
        it(@"should have an outlet for the password field", ^{
            
        });
        
        it(@"should wire up the login button action", ^{
            
        });
        
        describe(@"logging in", ^{
            // vc => login service
            it(@"should verify username & password with the login service", ^{
                
            });
        });
    });
SpecEnd