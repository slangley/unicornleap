//
//  UnicornViewController.m
//  unicornleap
//
//  Created by Sean Langley on 2016-11-20.
//  Copyright © 2016 Joshua Davey. All rights reserved.
//

#import "UnicornViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>


@interface UnicornViewController ()
@property CGMutablePathRef path;

@end



@implementation UnicornViewController

-(CGMutablePathRef) pathInFrame:(CGRect) screen forSize:(CGSize) size {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint origin = CGPointMake(-size.width, -size.height);
    CGPoint destination = CGPointMake(screen.size.width + size.width, origin.y);
    CGFloat midpoint = (destination.x + origin.x) / 2.0;
    CGFloat peak = size.height + 50.0;
    CGPathMoveToPoint(path, NULL, origin.x, origin.y);

    CGPathAddCurveToPoint(path, NULL, midpoint, peak,
                          midpoint, peak,
                          destination.x, destination.y);

    
    return path;
};

-(void) animateLayerAlongPathForKeyLayer:(CALayer *)layer path:(CGMutablePathRef) path key:(NSString *)key {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:key];
    [animation setPath: path];
    [animation setDuration: 2.0];
    [animation setCalculationMode: kCAAnimationLinear];
    [animation setRotationMode: nil];
    [layer addAnimation:animation forKey:key];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    
    
}

-(void)viewWillAppear {
    [super viewWillAppear];
    
}

-(CALayer *) layerForImageWithSize:(CGImageRef) image size:(CGSize) size {
    CALayer *layer = [CALayer layer];
    
    [layer setContents: (id)(image)];
    [layer setBounds:CGRectMake(0.0, 0.0, size.width, size.height)];
    [layer setPosition:CGPointMake(-size.width, -size.height)];
    
    return layer;
}

-(CAEmitterLayer *) getEmitterForImageInFrame:(CGImageRef) sparkleImage size:(CGSize) imageSize {
    static float base = 0.2;
    
    CAEmitterLayer *emitter = [[CAEmitterLayer alloc] init];
    emitter.emitterPosition = CGPointMake(-imageSize.width, -imageSize.height);
    emitter.emitterSize = CGSizeMake(imageSize.width/1.5, imageSize.height/1.5);
    CAEmitterCell *sparkle = [CAEmitterCell emitterCell];
    
    sparkle.contents = (id)(sparkleImage);
    
    sparkle.birthRate = 20.0/2.0 + 15.0;
    sparkle.lifetime = 2.0 * 0.5 + base;
    sparkle.lifetimeRange = 1.5;
    sparkle.name = @"sparkle";
    
    // Fade from white to purple
    sparkle.color = CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0);
    sparkle.greenSpeed = -0.7;
    
    sparkle.minificationFilter = kCAFilterNearest;
    
    // Fade out
    sparkle.alphaSpeed = -1.0;
    
    // Shrink
    sparkle.scale = 0.8;
    sparkle.scaleRange = 0.5;
    sparkle.scaleSpeed = sparkle.alphaSpeed - base;
    
    // Fall away
    sparkle.velocity = -20.0;
    sparkle.velocityRange = 20.0;
    sparkle.yAcceleration = -100.0;
    sparkle.xAcceleration = -50.0;
    
    // Spin
    sparkle.spin = -2.0;
    sparkle.spinRange = 4.0;
    
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterShape = kCAEmitterLayerCuboid;
    emitter.emitterCells = [NSArray arrayWithObject:sparkle];
    return emitter;
}


-(void)viewDidAppear {
    [super viewDidAppear];
    
    // Gather image paths
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"unicorn" ofType:@"png"];
    NSString *sparklePath = [[NSBundle mainBundle] pathForResource:@"sparkle" ofType:@"png"];
    
    NSImage *image = [[NSImage alloc] initWithContentsOfFile: imagePath];
    
    
    //    if(![image isValid]) {
    //        invalid_image(stderr, (char *)[imagePath UTF8String]);
    //        return;
    //    }
    
    CGSize imageSize = image.size;
    [image dealloc];
    
    // Load images as CGImage
    CGDataProviderRef source = CGDataProviderCreateWithFilename([imagePath UTF8String]);
    CGImageRef cgimage = CGImageCreateWithPNGDataProvider(source, NULL, true, 0);
    
    
    CGDataProviderRef sparkleSource = CGDataProviderCreateWithFilename([sparklePath UTF8String]);
    
    CGImageRef sparkleImage = CGImageCreateWithPNGDataProvider(sparkleSource, NULL, true, 0);
    
    CGRect screen = self.view.frame;
    
    // Create a path to animate a layer on. We will also draw the path.
    self.path = [self pathInFrame:screen forSize:imageSize];
    
    
    CALayer *layer;
    CAEmitterLayer *emitter;
    
    double waitFor = 2.0/2.5;
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    
    [self.view setWantsLayer: YES];
    
    //    for(int i=0; i < 1; i++) {
    layer = [self layerForImageWithSize:cgimage size: imageSize];
    emitter = [self getEmitterForImageInFrame:sparkleImage size: imageSize];
    [self.view.layer addSublayer: layer];
    [self.view.layer addSublayer: emitter];
    
    [self animateLayerAlongPathForKeyLayer:layer path:self.path key:@"position"];
    [self animateLayerAlongPathForKeyLayer:emitter path:self.path key:@"emitterPosition"];
    
    //        [runLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow: waitFor]];
    //    }
    
}


@end
