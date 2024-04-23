#import "ImageRepository.h"

@implementation ImageRepository

- (UIImage *)imageForItemIdentifier:(NSInteger)itemIdentifier {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(30, 30), NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [[UIColor blackColor] setFill];
    CGContextFillEllipseInRect(ctx, CGRectMake(0, 0, 30, 30));
    
    NSString *numberString = [NSString stringWithFormat:@"%ld", (long)itemIdentifier];
    NSDictionary *attributes = @{
        NSFontAttributeName: [UIFont boldSystemFontOfSize:(16)],
        NSForegroundColorAttributeName: [UIColor whiteColor]
    };

    
    CGSize textSize = [numberString sizeWithAttributes:attributes];
    CGRect textRect = CGRectMake((30 - textSize.width) / 2, (30 - textSize.height) / 2, textSize.width, textSize.height);
    

    [numberString drawInRect:textRect withAttributes:attributes];
    

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    

    UIGraphicsEndImageContext();
    
    return image;
}

@end
