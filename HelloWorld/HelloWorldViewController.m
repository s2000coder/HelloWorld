//
//  HelloWorldViewController.m
//  HelloWorld
//
//  Created by Tam Ma on 3/20/11.
//

#import "HelloWorldViewController.h"
#import "GAHelloWorld.h"
#import "GAChromosome.h"


@implementation HelloWorldViewController
@synthesize displayFittest=_displayFittest;

BOOL notFound = YES;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateLabel:(NSString *)str
{
    self.displayFittest.text = str;
    
    if(notFound){
        [self performSelector:@selector(updateLabel:) withObject:str afterDelay:2.0];
    }
}

- (void)startGA
{
    GAHelloWorld *gaHelloWorld = [[GAHelloWorld alloc] init];
    [gaHelloWorld evolve];

    for (int i=0; i<10000; i++) {
        [gaHelloWorld calculateFitness];
        [gaHelloWorld sortByFitness];
        [gaHelloWorld printFittest];
        
        NSString *fittest = [[gaHelloWorld.currentPopulation objectAtIndex:0] string];
        [self updateLabel:fittest];
        self.displayFittest.text = fittest; 
        
		if ([[gaHelloWorld.currentPopulation objectAtIndex:0] fitness] == 0) {
            notFound = NO;
            break;
        }
        
        [gaHelloWorld mate];
        [gaHelloWorld swap];
	}
    
    [gaHelloWorld release];
} 

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _displayFittest = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 380)];
    self.displayFittest.backgroundColor = [UIColor lightGrayColor];
    self.displayFittest.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:self.displayFittest];
    [_displayFittest release];
    
    UIButton *evolveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    evolveButton.frame = CGRectMake(60, 390, 200, 60);
    [evolveButton setTitle:@"Evolve!" forState:UIControlStateNormal];
    [evolveButton addTarget:self action:@selector(startGA) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:evolveButton];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [_displayFittest release];
    [super dealloc];
}

@end
