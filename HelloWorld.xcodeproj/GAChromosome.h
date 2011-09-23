//
//  GAChromosome.h
//  HelloWorld
//
//  Created by Tam Ma on 3/21/11.
//

#import <Foundation/Foundation.h>


@interface GAChromosome : NSObject <NSMutableCopying> {
    NSString *_string;
    unsigned int _fitness;
}

@property (nonatomic, copy) NSString *string;
@property (nonatomic, assign) unsigned int fitness;

- (id)mutableCopyWithZone:(NSZone *) zone;

@end
