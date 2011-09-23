//
//  GAChromosome.m
//  HelloWorld
//
//  Created by Tam Ma on 3/21/11.
//

#import "GAChromosome.h"


@implementation GAChromosome
@synthesize string=_string;
@synthesize fitness=_fitness;

- (id)mutableCopyWithZone:(NSZone *) zone
{
    GAChromosome *copyGAChromosome = [[[self class] allocWithZone:zone] init];
    [copyGAChromosome setString:self.string];
    [copyGAChromosome setFitness:self.fitness];
    
    return copyGAChromosome;
}

- (void)setString:(NSString *)string
{
    _string = string;
}

- (void)setFitness:(unsigned int)fitness
{
    _fitness = fitness;
}

@end
