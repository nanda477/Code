//
//  MaskView.m
//
//  Created by Ming Yang on 7/7/12.
//

#import "ImageCropView.h"
#import "AppDelegate.h"

static CGFloat const DEFAULT_MASK_ALPHA = 0.75;
static bool const square = NO;

#pragma mark ImageCropViewController implementation

@interface ImageCropViewController ()
- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize;

@end

@implementation ImageCropViewController

@synthesize delegate;
@synthesize cropView;

-(id)initWithImage:(UIImage*) image{
   self =  [super init];
    if (self){
        self.image = [image fixOrientation];
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self){
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - [[self navigationController] navigationBar].bounds.size.height)];
        contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        contentView.backgroundColor = [UIColor whiteColor];
        
      /*  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                                 initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                 target:self
                                                 action:@selector(cancel:)];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self
                                                  action:@selector(done:)];*/
        
        UIView *btnVw=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        
        UIButton* res1 = [UIButton buttonWithType:UIButtonTypeCustom];
        res1.backgroundColor=[UIColor clearColor];
        //res1.frame = CGRectMake(2, 25, 52, 30);
        res1.frame = CGRectMake(250, 25, 68, 30);
        [res1 addTarget:self action:@selector(cropTapped:) forControlEvents:UIControlEventTouchUpInside];
        [res1 setTitle:@"Crop" forState:UIControlStateNormal];
        [res1 setTitleColor:[UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        res1.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        //[res1 setBackgroundImage:[UIImage imageNamed:@"buttonbg.png"] forState:UIControlStateNormal];
        
        /*UIButton* logo = [UIButton buttonWithType:UIButtonTypeCustom];
        logo.frame = CGRectMake(55, 25, 101, 30);
        [logo setTitle:@"Use Original" forState:UIControlStateNormal];
        [logo addTarget:self action:@selector(useActual) forControlEvents:UIControlEventTouchUpInside];
        
        //  [logo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [logo setBackgroundImage:[UIImage imageNamed:@"buttonbg.png"] forState:UIControlStateNormal];
        logo.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        
        [btnVw addSubview:logo];*/
        [btnVw addSubview:res1];
        //[res1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[res1 setBackgroundImage:[UIImage imageNamed:@"buttonbg.png"] forState:UIControlStateNormal];
        
        UIButton* res2 = [UIButton buttonWithType:UIButtonTypeCustom];
        res2.backgroundColor=[UIColor clearColor];
        //res2.frame = CGRectMake(250, 25, 68, 30);
        res2.frame = CGRectMake(2, 25, 52, 30);

        [res2 addTarget:self action:@selector(cancelTapped:) forControlEvents:UIControlEventTouchUpInside];
        [res2 setTitle:@"Cancel" forState:UIControlStateNormal];
        res2.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [res2 setTitleColor:[UIColor colorWithRed:0.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        // [res1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[res2 setBackgroundImage:[UIImage imageNamed:@"buttonbg.png"] forState:UIControlStateNormal];
        [btnVw addSubview:res2];

        
        [contentView addSubview:btnVw];
        
    /*    UIBarButtonItem* resol = [[UIBarButtonItem alloc] initWithCustomView:btnVw];
        //[res1.titleLabel setTextColor:[UIColor colorWithRed:1 green:0.6 blue:0.012 alpha:1]];
        [res1.titleLabel setTextColor:[UIColor whiteColor]];
        [logo.titleLabel setTextColor:[UIColor whiteColor]];
        
        self.navigationItem.leftBarButtonItem=resol;*/
        
        
        
        CGRect view = CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height - [[self navigationController] navigationBar].bounds.size.height-60);
        self.cropView  = [[ImageCropView alloc] initWithFrame:view];
        //self.view = contentView;
        [self.view addSubview:contentView];
        [contentView addSubview:cropView];
        [cropView setImage:self.image];
    }
    /*if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        
        //  self.edgesForExtendedLayout = UIRectEdgeNone;
        self.view.frame=CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-1.5*self.navigationController.navigationBar.frame.size.height);
        
        
    }
    //self.image.center=self.c
    
    //    if (imageToCrop.size.width>imageToCrop.size.height) {
    //        resizingSize.height=imageToCrop.size.width;
    //        resizingSize.width=imageToCrop.size.height;
    //    }
    BOOL rotated=NO;
    float longrDimn=self.image.size.height;
    float wdth=self.image.size.width;
    if (longrDimn<wdth) {
        longrDimn=self.image.size.width;
        rotated=YES;
    }
    float resizeScale=1;
    //NSLog(@"%f %f",resizingSize.width,resizingSize.height);
    NSString *imageQuality=[[NSUserDefaults standardUserDefaults]objectForKey:@"iQuality"];
    // Original",@"High",@"Medium",@"Low"
    NSLog(@"%@",imageQuality);
    if ([imageQuality isEqualToString:@"high"])
    {
        resizeScale=longrDimn/960;
        
    }
    else
    {
        resizeScale=longrDimn/640;
        
    }
    
    // imageToCrop=[self resizeImage:imageToCrop newSize:resizingSize];
    
    // imageToCrop=[self resizeImage:imageToCrop width:imageToCrop.size.width/resizeScale height:imageToCrop.size.height/resizeScale];
    self.image=[self resizeImage:self.image scale:resizeScale];
    NSLog(@"height = %f  width=%f ",self.image.size.height,self.image.size.width);
    NSData *dta=UIImageJPEGRepresentation(self.image, 0.75);
    UIImage *img=[UIImage imageWithData:dta];
    NSLog(@"%d",[dta length]);
    cropView.image=img;
    NSLog(@"height = %f  width=%f ",img.size.height,img.size.width);
     */
        
}

- (UIImage *)resizeImage:(UIImage*)image scale:(float )newScale {
    
    
    
    CGSize newSize=CGSizeMake(image.size.width/newScale, image.size.height/newScale);
    
    CGImageRef imgRef = image.CGImage;
    
    
    
    CGFloat width = CGImageGetWidth(imgRef);
    
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    if (width > newSize.width || height > newSize.height) {
        
        CGFloat ratio = width/height;
        
        if (ratio > 1) {
            
            bounds.size.width = newSize.width;
            
            bounds.size.height = bounds.size.width / ratio;
            
        }
        
        else {
            
            bounds.size.height = newSize.height;
            
            bounds.size.width = bounds.size.height * ratio;
            
        }
        
    }
    
    
    
    CGFloat scaleRatio = bounds.size.width / width;
    
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    
    CGFloat boundHeight;
    
    UIImageOrientation orient = image.imageOrientation;
    
    switch(orient) {
            
            
            
        case UIImageOrientationUp: //EXIF = 1
            
            transform = CGAffineTransformIdentity;
            
            break;
            
            
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            
            break;
            
            
            
        case UIImageOrientationDown: //EXIF = 3
            
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            
            transform = CGAffineTransformRotate(transform, M_PI);
            
            break;
            
            
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            
            break;
            
            
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            
            break;
            
            
            
        case UIImageOrientationLeft: //EXIF = 6
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            
            break;
            
            
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            
            break;
            
            
            
        case UIImageOrientationRight: //EXIF = 8
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            
            break;
            
            
            
        default:
            
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
            
            
    }
    
    
    
    UIGraphicsBeginImageContext(bounds.size);
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        
        CGContextTranslateCTM(context, -height, 0);
        
    }
    
    else {
        
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        
        CGContextTranslateCTM(context, 0, -height);
        
    }
    
    
    
    CGContextConcatCTM(context, transform);
    
    
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return imageCopy;
    
}

- (IBAction)cancel:(id)sender
{
    
    if ([self.delegate respondsToSelector:@selector(ImageCropViewControllerDidCancel:)])
    {
        [self.delegate ImageCropViewControllerDidCancel:self];
    }
    
}

- (IBAction)cropTapped:(id)sender
{
    UIImage *cropped;
    if (self.image != nil){
        CGRect CropRect = self.cropView.cropAreaInImage;
        CGImageRef imageRef = CGImageCreateWithImageInRect([self.image CGImage], CropRect) ;
        cropped = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
  //  UIAppDelegate.croppedImage=cropped;
    AppDelegate*myApp = [[AppDelegate alloc]init];
    
    myApp.croppedImage = cropped;
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
    
}

- (IBAction)cancelTapped:(id)sender
{
    NSLog(@"Cancelled");
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}



- (IBAction)done:(id)sender
{
    
    if ([self.delegate respondsToSelector:@selector(ImageCropViewController:didFinishCroppingImage:)])
    {
        UIImage *cropped;
        if (self.image != nil){
            CGRect CropRect = self.cropView.cropAreaInImage;
            CGImageRef imageRef = CGImageCreateWithImageInRect([self.image CGImage], CropRect) ;
            cropped = [UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);
        }
        [self.delegate ImageCropViewController:self didFinishCroppingImage:cropped];
    }
    
}
@end


#pragma mark ControlPointView implementation

@implementation ControlPointView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.color = [UIColor colorWithRed:18.0/255.0 green:173.0/255.0 blue:251.0/255.0 alpha:1];
        self.opaque = NO;
    }
    return self;
}

- (void)setColor:(UIColor *)_color {
    [_color getRed:&red green:&green blue:&blue alpha:&alpha];
    [self setNeedsDisplay];
}

- (UIColor*)color {
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSetRGBFillColor(context, red, green, blue, alpha);
    CGContextFillEllipseInRect(context, rect);
}

@end

#pragma mark - MaskView implementation

@implementation ShadeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
    }
    return self;
}

- (void)setCropBorderColor:(UIColor *)_color {
    [_color getRed:&cropBorderRed green:&cropBorderGreen blue:&cropBorderBlue alpha:&cropBorderAlpha];
    [self setNeedsDisplay];
}

- (UIColor*)cropBorderColor {
    return [UIColor colorWithRed:cropBorderRed green:cropBorderGreen blue:cropBorderBlue alpha:cropBorderAlpha];
}

- (void)setCropArea:(CGRect)_clearArea {
    cropArea = _clearArea;
    [self setNeedsDisplay];
}

- (CGRect)cropArea {
    return cropArea;
}

- (void)setShadeAlpha:(CGFloat)_alpha {
    shadeAlpha = _alpha;
    [self setNeedsDisplay];
}

- (CGFloat)shadeAlpha {
    return shadeAlpha;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    CGContextSetRGBFillColor(context, 0, 0, 0.05, self.shadeAlpha);
    CGContextFillRect(context, rect);
    
    CGContextClearRect(context, self.cropArea);
    
    CGContextSetRGBStrokeColor(context, cropBorderRed, cropBorderGreen, cropBorderBlue, cropBorderAlpha);
    CGContextSetLineWidth(context, 2);
    CGContextStrokeRect(context, self.cropArea);
    
}

@end

#pragma mark - MaskImageView implementation

static CGFloat const DEFAULT_CONTROL_POINT_SIZE = 5;

CGRect SquareCGRectAtCenter(CGFloat centerX, CGFloat centerY, CGFloat size) {
    CGFloat x = centerX - size / 2.0;
    CGFloat y = centerY - size / 2.0;
    return CGRectMake(x, y, size, size);
}

@implementation ImageCropView

@synthesize cropAreaInImage;
@synthesize imageScale;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self=[super initWithCoder:aDecoder]) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    CGRect subviewFrame = self.bounds;
    
    //the shade
    shadeView = [[ShadeView alloc] initWithFrame:subviewFrame];
    
    //the image
    imageView = [[UIImageView alloc] initWithFrame:subviewFrame];

    //control points
    controlPointSize = DEFAULT_CONTROL_POINT_SIZE;
    int initialClearAreaSize = self.frame.size.width / 2;
    CGPoint centerInView = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    topLeftPoint = [self createControlPointAt:SquareCGRectAtCenter(centerInView.x - initialClearAreaSize,
                                                                   centerInView.y - initialClearAreaSize, 
                                                                   controlPointSize)];
    
    bottomLeftPoint = [self createControlPointAt:SquareCGRectAtCenter(centerInView.x - initialClearAreaSize, 
                                                                      centerInView.y + initialClearAreaSize, 
                                                                      controlPointSize)];
    
    bottomRightPoint = [self createControlPointAt:SquareCGRectAtCenter(centerInView.x + initialClearAreaSize, 
                                                                       centerInView.y + initialClearAreaSize, controlPointSize) ];
    
    topRightPoint = [self createControlPointAt:SquareCGRectAtCenter(centerInView.x + initialClearAreaSize, 
                                                                    centerInView.y - initialClearAreaSize, controlPointSize)];
    
    //the "hole"
    CGRect cropArea = [self clearAreaFromControlPoints];
    cropAreaView = [[UIView alloc] initWithFrame:cropArea];
    cropAreaView.opaque = NO;
    cropAreaView.backgroundColor = [UIColor clearColor];
    UIPanGestureRecognizer* dragRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDrag:)];
    dragRecognizer.maximumNumberOfTouches = 1;
    [self.viewForBaselineLayout addGestureRecognizer:dragRecognizer];
    
    [self addSubview:imageView];
    [self addSubview:shadeView];
    [self addSubview:cropAreaView];
    [self addSubview:topRightPoint];
    [self addSubview:bottomRightPoint];
    [self addSubview:topLeftPoint];
    [self addSubview:bottomLeftPoint];
    
    PointsArray = [[NSArray alloc] initWithObjects:topRightPoint, bottomRightPoint, topLeftPoint, bottomLeftPoint, nil];
    [shadeView setCropArea:cropArea];
    
    self.maskAlpha = DEFAULT_MASK_ALPHA;
    
    imageFrameInView = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    imageView.frame = imageFrameInView;

}

- (ControlPointView*)createControlPointAt:(CGRect)frame {
    ControlPointView* point = [[ControlPointView alloc] initWithFrame:frame];
    return point;
}

- (CGRect)clearAreaFromControlPoints {
    CGFloat width = topRightPoint.center.x - topLeftPoint.center.x;
    CGFloat height = bottomRightPoint.center.y - topRightPoint.center.y;
    CGRect hole = CGRectMake(topLeftPoint.center.x, topLeftPoint.center.y, width, height);
    return hole;
}

- (CGRect)controllableAreaFromControlPoints {
    CGFloat width = topRightPoint.center.x - topLeftPoint.center.x - controlPointSize;
    CGFloat height = bottomRightPoint.center.y - topRightPoint.center.y - controlPointSize;
    CGRect hole = CGRectMake(topLeftPoint.center.x + controlPointSize / 2, topLeftPoint.center.y + controlPointSize / 2, width, height);
    return hole;
}

- (void)boundingBoxForTopLeft:(CGPoint)topLeft bottomLeft:(CGPoint)bottomLeft bottomRight:(CGPoint)bottomRight topRight:(CGPoint)topRight {
    CGRect box = CGRectMake(topLeft.x - controlPointSize / 2, topLeft.y - controlPointSize / 2 , topRight.x - topLeft.x + controlPointSize , bottomRight.y - topRight.y + controlPointSize );
    //If not square - crop cropView =-)
    if (!square){
        box = CGRectIntersection(imageFrameInView, box);
    }
    
    if (CGRectContainsRect(imageFrameInView, box)) {
        bottomLeftPoint.center = CGPointMake(box.origin.x + controlPointSize / 2, box.origin.y + box.size.height - controlPointSize / 2);
        bottomRightPoint.center = CGPointMake(box.origin.x + box.size.width - controlPointSize / 2, box.origin.y + box.size.height - controlPointSize / 2);;
        topLeftPoint.center = CGPointMake(box.origin.x + controlPointSize / 2, box.origin.y + controlPointSize / 2);
        topRightPoint.center = CGPointMake(box.origin.x + box.size.width - controlPointSize / 2, box.origin.y + controlPointSize / 2);
    }
}

- (UIView*)  checkHit:(CGPoint)point {
    UIView* view = cropAreaView;
    for (int i =0; i < PointsArray.count; i++) {
        if (sqrt(pow((point.x-view.center.x),2) + pow((point.y-view.center.y),2))>sqrt(pow((point.x- [PointsArray[i] center].x),2) + pow((point.y- [PointsArray[i] center].y),2)))
            view = PointsArray[i];
         }
    
    return view;
}
- (void)handleDrag:(UIPanGestureRecognizer*)recognizer {
    if (recognizer.state==UIGestureRecognizerStateBegan) {
        dragView = [self checkHit:[recognizer locationInView:self]];
        dragPoint.dragStart = [recognizer locationInView:self];
        dragPoint.topLeftCenter = topLeftPoint.center;
        dragPoint.bottomLeftCenter = bottomLeftPoint.center;
        dragPoint.bottomRightCenter = bottomRightPoint.center;
        dragPoint.topRightCenter = topRightPoint.center;
        dragPoint.clearAreaCenter = cropAreaView.center;
        return;
    }
    
    CGPoint location = [recognizer locationInView:self];
    if (dragView==topLeftPoint) {
        [self handleDragTopLeft:location];
    }
    else if (dragView==bottomLeftPoint) {
        [self handleDragBottomLeft:location];
    }
    else if (dragView==bottomRightPoint) {
        [self handleDragBottomRight:location];
    }
    else if (dragView==topRightPoint) {
        [self handleDragTopRight:location];
    }
    else if (dragView==cropAreaView) {
        [self handleDragClearArea:location];
    }

    CGRect clearArea = [self clearAreaFromControlPoints];
    cropAreaView.frame = clearArea;
    [shadeView setCropArea:clearArea];
}

- (CGSize)deriveDisplacementFromDragLocation:(CGPoint)dragLocation draggedPoint:(CGPoint)draggedPoint oppositePoint:(CGPoint)oppositePoint {
    CGFloat dX = dragLocation.x - dragPoint.dragStart.x;
    CGFloat dY = dragLocation.y - dragPoint.dragStart.y;
    CGPoint tempDraggedPoint = CGPointMake(draggedPoint.x + dX, draggedPoint.y + dY);
    CGFloat width = (tempDraggedPoint.x - oppositePoint.x);
    CGFloat height = (tempDraggedPoint.y - oppositePoint.y);
    CGFloat size = fabs(width)>=fabsf(height) ? width : height;
    CGFloat xDir = draggedPoint.x<=oppositePoint.x ? 1 : -1;
    CGFloat yDir = draggedPoint.y<=oppositePoint.y ? 1 : -1;
    CGFloat newX = 0, newY = 0;
    if (xDir>=0) {
        //on the right
        if(square)
        newX = oppositePoint.x - fabs(size);
        else
        newX = oppositePoint.x - fabs(width);
     }
    else {
        //on the left
    if(square )
        newX = oppositePoint.x + fabs(size);
    else
        newX = oppositePoint.x + fabs(width);
     }

    if (yDir>=0) {
        //on the top
    if(square)
        newY = oppositePoint.y - fabs(size);
    else
        newY = oppositePoint.y - fabs(height);
      }
    else {
        //on the bottom
    if(square)
        newY = oppositePoint.y + fabs(size);
    else
        newY = oppositePoint.y + fabs(height);
    }
    
    CGSize displacement = CGSizeMake(newX - draggedPoint.x, newY - draggedPoint.y);
    return displacement;
}

- (void)handleDragTopLeft:(CGPoint)dragLocation {
    CGSize disp = [self deriveDisplacementFromDragLocation:dragLocation draggedPoint:dragPoint.topLeftCenter oppositePoint:dragPoint.bottomRightCenter];
    CGPoint topLeft = CGPointMake(dragPoint.topLeftCenter.x + disp.width, dragPoint.topLeftCenter.y + disp.height);
    CGPoint topRight = CGPointMake(dragPoint.topRightCenter.x, dragPoint.topLeftCenter.y + disp.height);
    CGPoint bottomLeft = CGPointMake(dragPoint.bottomLeftCenter.x + disp.width, dragPoint.bottomLeftCenter.y);
    
    [self boundingBoxForTopLeft:topLeft bottomLeft:bottomLeft bottomRight:dragPoint.bottomRightCenter topRight:topRight];
}
- (void)handleDragBottomLeft:(CGPoint)dragLocation {
    CGSize disp = [self deriveDisplacementFromDragLocation:dragLocation draggedPoint:dragPoint.bottomLeftCenter oppositePoint:dragPoint.topRightCenter];
    CGPoint bottomLeft = CGPointMake(dragPoint.bottomLeftCenter.x + disp.width, dragPoint.bottomLeftCenter.y + disp.height);
    CGPoint topLeft = CGPointMake(dragPoint.topLeftCenter.x + disp.width, dragPoint.topLeftCenter.y);
    CGPoint bottomRight = CGPointMake(dragPoint.bottomRightCenter.x, dragPoint.bottomRightCenter.y + disp.height);
    
    [self boundingBoxForTopLeft:topLeft bottomLeft:bottomLeft bottomRight:bottomRight topRight:dragPoint.topRightCenter];
}

- (void)handleDragBottomRight:(CGPoint)dragLocation {
    CGSize disp = [self deriveDisplacementFromDragLocation:dragLocation draggedPoint:dragPoint.bottomRightCenter oppositePoint:dragPoint.topLeftCenter];
    CGPoint bottomRight = CGPointMake(dragPoint.bottomRightCenter.x + disp.width, dragPoint.bottomRightCenter.y + disp.height);
    CGPoint topRight = CGPointMake(dragPoint.topRightCenter.x + disp.width, dragPoint.topRightCenter.y);
    CGPoint bottomLeft = CGPointMake(dragPoint.bottomLeftCenter.x, dragPoint.bottomLeftCenter.y + disp.height);

    [self boundingBoxForTopLeft:dragPoint.topLeftCenter bottomLeft:bottomLeft bottomRight:bottomRight topRight:topRight];
}

- (void)handleDragTopRight:(CGPoint)dragLocation {
    CGSize disp = [self deriveDisplacementFromDragLocation:dragLocation draggedPoint:dragPoint.topRightCenter oppositePoint:dragPoint.bottomLeftCenter];
    CGPoint topRight = CGPointMake(dragPoint.topRightCenter.x + disp.width, dragPoint.topRightCenter.y + disp.height);
    CGPoint topLeft = CGPointMake(dragPoint.topLeftCenter.x, dragPoint.topLeftCenter.y + disp.height);
    CGPoint bottomRight = CGPointMake(dragPoint.bottomRightCenter.x + disp.width, dragPoint.bottomRightCenter.y);

    [self boundingBoxForTopLeft:topLeft bottomLeft:dragPoint.bottomLeftCenter bottomRight:bottomRight topRight:topRight];
}

- (void)handleDragClearArea:(CGPoint)dragLocation {
    CGFloat dX = dragLocation.x - dragPoint.dragStart.x;
    CGFloat dY = dragLocation.y - dragPoint.dragStart.y;
    
    CGPoint newTopLeft = CGPointMake(dragPoint.topLeftCenter.x + dX, dragPoint.topLeftCenter.y + dY);
    CGPoint newBottomLeft = CGPointMake(dragPoint.bottomLeftCenter.x + dX, dragPoint.bottomLeftCenter.y + dY);
    CGPoint newBottomRight = CGPointMake(dragPoint.bottomRightCenter.x + dX, dragPoint.bottomRightCenter.y + dY);
    CGPoint newTopRight = CGPointMake(dragPoint.topRightCenter.x + dX, dragPoint.topRightCenter.y + dY);

    CGFloat clearAreaWidth = dragPoint.topRightCenter.x - dragPoint.topLeftCenter.x;
    CGFloat clearAreaHeight = dragPoint.bottomLeftCenter.y - dragPoint.topLeftCenter.y;
    
    CGFloat halfControlPointSize = controlPointSize / 2;
    CGFloat minX = imageFrameInView.origin.x + halfControlPointSize;
    CGFloat maxX = imageFrameInView.origin.x + imageFrameInView.size.width - halfControlPointSize;
    CGFloat minY = imageFrameInView.origin.y + halfControlPointSize;
    CGFloat maxY = imageFrameInView.origin.y + imageFrameInView.size.height - halfControlPointSize;
    
    if (newTopLeft.x<minX) {
        newTopLeft.x = minX;
        newBottomLeft.x = minX;
        newTopRight.x = newTopLeft.x + clearAreaWidth;
        newBottomRight.x = newTopRight.x;
    }
    
    if(newTopLeft.y<minY) {
        newTopLeft.y = minY;
        newTopRight.y = minY;
        newBottomLeft.y = newTopLeft.y + clearAreaHeight;
        newBottomRight.y = newBottomLeft.y;
    }
    
    if (newBottomRight.x>maxX) {        
        newBottomRight.x = maxX;
        newTopRight.x = maxX;
        newTopLeft.x = newBottomRight.x - clearAreaWidth;
        newBottomLeft.x = newTopLeft.x;
    }
    
    if (newBottomRight.y>maxY) {
        newBottomRight.y = maxY;
        newBottomLeft.y = maxY;
        newTopRight.y = newBottomRight.y - clearAreaHeight;
        newTopLeft.y = newTopRight.y;
    }
    topLeftPoint.center = newTopLeft;
    bottomLeftPoint.center = newBottomLeft;
    bottomRightPoint.center = newBottomRight;
    topRightPoint.center = newTopRight;

}

- (void)setControlPointSize:(CGFloat)_controlPointSize {
    CGFloat halfSize = _controlPointSize;
    CGRect topLeftPointFrame = CGRectMake(topLeftPoint.center.x - halfSize, topLeftPoint.center.y - halfSize, controlPointSize, controlPointSize);
    CGRect bottomLeftPointFrame = CGRectMake(bottomLeftPoint.center.x - halfSize, bottomLeftPoint.center.y - halfSize, controlPointSize, controlPointSize);
    CGRect bottomRightPointFrame = CGRectMake(bottomRightPoint.center.x - halfSize, bottomRightPoint.center.y - halfSize, controlPointSize, controlPointSize);
    CGRect topRightPointFrame = CGRectMake(topRightPoint.center.x - halfSize, topRightPoint.center.y - halfSize, controlPointSize, controlPointSize);
    
    topLeftPoint.frame = topLeftPointFrame;
    bottomLeftPoint.frame = bottomLeftPointFrame;
    bottomRightPoint.frame = bottomRightPointFrame;
    topRightPoint.frame = topRightPointFrame;
    
    [self setNeedsDisplay];
}

- (CGFloat)controlPointSize {
    return controlPointSize;
}

- (void)setMaskAlpha:(CGFloat)alpha {
    shadeView.shadeAlpha = alpha;
}

- (CGFloat)maskAlpha {
    return shadeView.shadeAlpha;
}

- (CGRect)cropAreaInImage {
    CGRect _clearArea = self.cropAreaInView;
    CGRect r = CGRectMake((int)((_clearArea.origin.x - imageFrameInView.origin.x) * self.imageScale), (int)((_clearArea.origin.y - imageFrameInView.origin.y) * self.imageScale), (int)(_clearArea.size.width * self.imageScale), (int)(_clearArea.size.height * self.imageScale));
    return r;
}

- (void)setCropAreaInImage:(CGRect)_clearAreaInImage {
    CGRect r = CGRectMake(_clearAreaInImage.origin.x + imageFrameInView.origin.x, 
                          _clearAreaInImage.origin.y + imageFrameInView.origin.y, 
                          _clearAreaInImage.size.width, 
                          _clearAreaInImage.size.height);
    [self setCropAreaInView:r];
}

- (CGRect)cropAreaInView {
    CGRect area = [self clearAreaFromControlPoints];
    return area;
}

- (void)setCropAreaInView:(CGRect)area {
    CGPoint topLeft = area.origin;
    CGPoint bottomLeft = CGPointMake(topLeft.x, topLeft.y + area.size.height);
    CGPoint bottomRight = CGPointMake(bottomLeft.x + area.size.width, bottomLeft.y);
    CGPoint topRight = CGPointMake(topLeft.x + area.size.width, topLeft.y);
    topLeftPoint.center = topLeft;
    bottomLeftPoint.center = bottomLeft;
    bottomRightPoint.center = bottomRight;
    topRightPoint.center = topRight;
    shadeView.cropArea = area;
    [self setNeedsDisplay];
}

- (void)setImage:(UIImage *)image {
    CGFloat frameWidth = self.frame.size.width;
    CGFloat frameHeight = self.frame.size.height;
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    BOOL isPortrait = imageHeight > imageWidth;
    int x, y;
    int scaledImageWidth, scaledImageHeight;
    if (isPortrait) {
        imageScale = imageHeight / frameHeight;
        scaledImageWidth = imageWidth / imageScale;
        scaledImageHeight = frameHeight;
        x = (frameWidth - scaledImageWidth) / 2;
        y = 0;
    }
    else {
        imageScale = imageWidth / frameWidth;
        scaledImageWidth = frameWidth;
        scaledImageHeight = imageHeight / imageScale;
        x = 0;
        y = (frameHeight - scaledImageHeight) / 2;
    }
    imageFrameInView = CGRectMake(x, y, scaledImageWidth, scaledImageHeight);
    imageView.frame = imageFrameInView;
    imageView.image = image;
    
    //Special fix. If scaledImageWidth or scaledImageHeight < clearArea.width of clearArea.Height.
    [self boundingBoxForTopLeft:topLeftPoint.center bottomLeft:bottomLeftPoint.center bottomRight:bottomRightPoint.center topRight:topRightPoint.center];
    CGRect clearArea = [self clearAreaFromControlPoints];
    cropAreaView.frame = clearArea;
    [shadeView setCropArea:clearArea];
    
}

- (UIColor*)controlColor {
    return controlColor;
}

- (void)setControlColor:(UIColor *)_color {
    controlColor = _color;
    shadeView.cropBorderColor = _color;
    topLeftPoint.color = _color;
    bottomLeftPoint.color = _color;
    bottomRightPoint.color = _color;
    topRightPoint.color = _color;
}

- (void)setUserInteractionEnabled:(BOOL)_userInteractionEnabled {
    if (!_userInteractionEnabled) {
        [topLeftPoint setHidden:YES];
        [bottomLeftPoint setHidden:YES];
        [bottomRightPoint setHidden:YES];
        [topRightPoint setHidden:YES];
    }
    [super setUserInteractionEnabled:_userInteractionEnabled];
}

@end

@implementation UIImage (fixOrientation)

- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
@end

