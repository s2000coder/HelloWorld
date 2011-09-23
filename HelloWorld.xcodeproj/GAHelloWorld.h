//
//  GAHelloWorld.h
//  HelloWorld
//
//  Created by Tam Ma on 3/21/11.
//

#import <Foundation/Foundation.h>


@interface GAHelloWorld : NSObject {
    NSMutableArray *_currentPopulation;
    NSMutableArray *_nextPopulation;
}
    
@property (nonatomic, retain) NSMutableArray *currentPopulation;
@property (nonatomic, retain) NSMutableArray *nextPopulation;

- (void)evolve;
- (void)initializePopulation;
- (void)calculateFitness;
- (void)sortByFitness;
- (void)Elitism: (int)eSize;
- (void)mutate: (id)chromosome;
- (void)mate;
- (void)printFittest;
- (void)swap;

@end
