//
//  GAHelloWorld.m
//  HelloWorld
//
//  Created by Tam Ma on 3/21/11.
//

#import "GAHelloWorld.h"
#import "GAChromosome.h"
#import <stdlib.h>
#import <time.h>

#define GA_POPSIZE		2048		// ga population size
#define GA_MAXITER		16384		// maximum iterations
#define GA_ELITRATE		0.10f		// elitism rate
#define GA_MUTATIONRATE	0.25f		// mutation rate
#define GA_MUTATION		RAND_MAX * GA_MUTATIONRATE
#define GA_TARGET		@"Hello world!"


@implementation GAHelloWorld
@synthesize currentPopulation=_currentPopulation;
@synthesize nextPopulation=_nextPopulation;

- (void)initializePopulation
{
    NSString *target = @"Hello World!";
    int targetSize = [target length];

    _currentPopulation = [[NSMutableArray alloc] initWithCapacity:GA_POPSIZE];
    _nextPopulation = [[NSMutableArray alloc] initWithCapacity:GA_POPSIZE];
    
	for (int i=0; i<GA_POPSIZE; i++) {
        GAChromosome *gaChromosome = [[GAChromosome alloc] init];
        gaChromosome.string = @"";
		gaChromosome.fitness = 0;

		for (int j=0; j<targetSize; j++) {
            gaChromosome.string = [gaChromosome.string stringByAppendingFormat:@"%c", (rand() % 90) + 32];
        }
        
        [self.currentPopulation addObject:gaChromosome];
        [gaChromosome release];
	}
}

- (void)calculateFitness
{
    NSString *target = @"Hello World!";
    int targetSize = [target length];
	unsigned int fitness;

	for (int i=0; i<GA_POPSIZE; i++) {
		fitness = 0;
        
		for (int j=0; j<targetSize; j++) {
            fitness += abs((int)([[[self.currentPopulation objectAtIndex:i] string] characterAtIndex:j] - [target characterAtIndex:j])); 
		}
        
        GAChromosome *temp = [self.currentPopulation objectAtIndex:i]; // why can't I can do a dot after the ]?
        temp.fitness = fitness;
        temp = nil;
    }
}

- (void)sortByFitness
{
    NSSortDescriptor *fitnessSorter = [[NSSortDescriptor alloc] initWithKey:@"fitness" ascending:YES];
    [_currentPopulation sortUsingDescriptors:[NSArray arrayWithObject:fitnessSorter]];
    [fitnessSorter release];
}

- (void)Elitism: (int)esize
{
    for (int i=0; i<esize; i++) {
        [self.nextPopulation addObject:[[self.currentPopulation objectAtIndex:i] mutableCopy]];
	}
}

- (void)mutate: (GAChromosome *)chromosome
{
    int targetSize = [GA_TARGET length];
	int ipos = rand() % targetSize;
	int delta = (rand() % 90) + 32;

    NSString *randomChar = [NSString stringWithFormat:@"%c", delta];
    chromosome.string = [chromosome.string stringByReplacingCharactersInRange:NSMakeRange(ipos, 1) withString: randomChar];
}

- (void)mate
{
    int esize = GA_POPSIZE * GA_ELITRATE;
	int tsize = [GA_TARGET length];
    int spos, i1, i2;
    GAChromosome *temp;
    
	[self Elitism:esize];
    
	// Mate the rest
	for (int i=esize; i<GA_POPSIZE; i++) {
		i1 = rand() % (GA_POPSIZE / 2);
		i2 = rand() % (GA_POPSIZE / 2);
		spos = rand() % tsize;
        
        [self.nextPopulation addObject:[[self.currentPopulation objectAtIndex:i] mutableCopy]];
        temp = [self.nextPopulation objectAtIndex:i];
        temp.string = [[[[self.currentPopulation objectAtIndex:i1] string] substringWithRange: NSMakeRange(0, spos)] stringByAppendingString:
          [[[self.currentPopulation objectAtIndex:i2] string] substringWithRange: NSMakeRange(spos, tsize - spos)]];

        if (rand() < GA_MUTATION) {
            [self mutate:[self.nextPopulation objectAtIndex:i]];
        }
	}
}

- (void)printFittest
{
    NSLog(@"Best: %@ ( %d)", [[self.currentPopulation objectAtIndex:0] string], [[self.currentPopulation objectAtIndex:0] fitness]);
}

- (void)swap
{
    NSMutableArray *temp = self.currentPopulation;
    _currentPopulation = self.nextPopulation;
    _nextPopulation = temp;
}

- (void)evolve
{
    srand((unsigned)(time(NULL)));

    [self initializePopulation];
}

@end
