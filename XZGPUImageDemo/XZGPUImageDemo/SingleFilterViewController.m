//  SingleFilterViewController.m
//  XZGPUImage
//
//  Created by 徐章 on 16/5/7.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "SingleFilterViewController.h"
#import "GPUImage/GPUImage.h"


@interface SingleFilterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *value1Lab;
@property (weak, nonatomic) IBOutlet UILabel *maxValueLab1;
@property (weak, nonatomic) IBOutlet UILabel *minValueLab1;
@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UILabel *value1NameLab;

@property (weak, nonatomic) IBOutlet UILabel *value2Lab;
@property (weak, nonatomic) IBOutlet UILabel *maxValueLab2;
@property (weak, nonatomic) IBOutlet UILabel *minValueLab2;
@property (weak, nonatomic) IBOutlet UISlider *slider2;
@property (weak, nonatomic) IBOutlet UILabel *value2NameLab;


@property (strong, nonatomic) GPUImageOutput<GPUImageInput> *filter;
@property (strong, nonatomic) GPUImagePicture *imageSource;
@property (strong, nonatomic) GPUImageView *primaryView;
@end

@implementation SingleFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.type;
    
    Class class = NSClassFromString(self.type);
    
    self.imageSource = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:@"createTopic_background"]];
    self.filter = [[class alloc] init];

    CGFloat width = [UIScreen mainScreen].bounds.size.width - 40;

    self.primaryView = [[GPUImageView alloc] initWithFrame:CGRectMake(20, 124, width, width*(158/280.0f))];
    [self.view addSubview:self.primaryView];

    [self.filter forceProcessingAtSize:CGSizeMake(width,width*(158/280.0f))];
    [self.imageSource addTarget:self.filter];
    [self.filter addTarget:self.primaryView];
    
    [self.filter useNextFrameForImageCapture];
    [self.imageSource processImage];
    [self initalMinMaxValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initalMinMaxValue{
    
    CGFloat minValue;
    CGFloat maxValue;
    if ([self.type isEqualToString:NSStringFromClass([GPUImageBrightnessFilter class])]) {
        
        minValue = -1.0f;
        maxValue = 1.0f;
        self.minValueLab1.text = @"-1";
        self.maxValueLab1.text = @"1";
        self.slider1.value = 0.0f;
        self.value1NameLab.text = @"Brightness:";
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageContrastFilter class])]){
        
        minValue = 0.0f;
        maxValue = 4.0f;
        self.minValueLab1.text = @"0";
        self.maxValueLab1.text = @"4";
        self.slider1.value = 1.0f;
        self.value1NameLab.text = @"Contrast:";
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageSaturationFilter class])]){
        
        minValue = 0.0f;
        maxValue = 2.0f;
        self.minValueLab1.text = @"0";
        self.maxValueLab1.text = @"2";
        self.slider1.value = 1.0f;
        self.value1NameLab.text = @"Saturation:";
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageExposureFilter class])]){
        
        minValue = -1.0f;
        maxValue = 10.0f;
        self.minValueLab1.text = @"-1";
        self.maxValueLab1.text = @"10";
        self.slider1.value = 0.0f;
        self.value1NameLab.text = @"Exposure:";
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageWhiteBalanceFilter class])]){
        
        minValue = 1000.0f;
        maxValue = 10000.0f;
        self.minValueLab1.text = @"1000";
        self.maxValueLab1.text = @"10000";
        self.slider1.value = 5000.0f;
        self.value1NameLab.text = @"Temperature:";
        
        [self showSlider2];
        
        self.value2NameLab.text = @"Tint:";
        self.minValueLab2.text = @"-1000";
        self.maxValueLab2.text = @"1000";
        self.slider2.value = 0.0f;
        self.slider2.minimumValue = -1000.0f;
        self.slider2.maximumValue = 1000.0f;
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageVibranceFilter class])]){
        
        minValue = -1.0f;
        maxValue = 1.0f;
        self.minValueLab1.text = @"-1";
        self.maxValueLab1.text = @"1";
        self.slider1.value = 0.0f;
        self.value1NameLab.text = @"Vibrance:";
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageSharpenFilter class])]){
    
        minValue = -4.0f;
        maxValue = 4.0f;
        self.minValueLab1.text = @"-4";
        self.maxValueLab1.text = @"4";
        self.slider1.value = 0.0f;
        self.value1NameLab.text = @"Sharpen:";
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageColorInvertFilter class])]){
        
        [self hideSlider1];
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageSepiaFilter  class])]){
    
        [self hideSlider1];
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageHistogramGenerator class])]){
        
        [self hideSlider1];
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageSketchFilter class])]){
        
        [self hideSlider1];
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageHighlightShadowFilter class])]){
        
        minValue = 0.0f;
        maxValue = 1.0f;
        self.minValueLab1.text = @"0";
        self.maxValueLab1.text = @"1";
        self.slider1.value = 0.0f;
        self.value1NameLab.text = @"Shadow:";
        
        [self showSlider2];
        
        self.value2NameLab.text = @"Highlights:";
        self.minValueLab2.text = @"0";
        self.maxValueLab2.text = @"1";
        self.slider2.value = 1.0f;
        self.slider2.minimumValue = 0.0f;
        self.slider2.maximumValue = 1.0f;
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageMissEtikateFilter class])]){
        
        [self hideSlider1];
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageSoftEleganceFilter class])]){
        
        [self hideSlider1];
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageAmatorkaFilter class])]){
    
        [self hideSlider1];
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageGlassSphereFilter class])]){
    
        [self hideSlider1];
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageBoxBlurFilter class])]){
    
        [self hideSlider1];
    }else if ([self.type containsString:@"FW"]){
    
        [self hideSlider1];
    }
    
    self.slider1.minimumValue = minValue;
    self.slider1.maximumValue = maxValue;
}

- (void)showSlider2{
    
    self.value2NameLab.hidden = NO;
    self.minValueLab2.hidden = NO;
    self.maxValueLab2.hidden = NO;
    self.slider2.hidden = NO;
    self.value2Lab.hidden = NO;
}

- (void)hideSlider1{
    self.value1NameLab.hidden = YES;
    self.value1Lab.hidden = YES;
    self.slider1.hidden = YES;
    self.minValueLab1.hidden = YES;
    self.maxValueLab1.hidden = YES;
}

- (IBAction)sliderValue_Changed:(UISlider *)sender {
    
    self.value1Lab.text = [NSString stringWithFormat:@"%f",sender.value];
    
    if ([self.type isEqualToString:NSStringFromClass([GPUImageBrightnessFilter class])]) {
        
        [(GPUImageBrightnessFilter *)self.filter setBrightness:sender.value];
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageContrastFilter class])]){
        
        [(GPUImageContrastFilter *)self.filter setContrast:sender.value];
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageSaturationFilter class])]){
        
        [(GPUImageSaturationFilter *)self.filter setSaturation:sender.value];
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageExposureFilter class])]){
        
        [(GPUImageExposureFilter *)self.filter setExposure:sender.value];
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageWhiteBalanceFilter class])]){
        
        [(GPUImageWhiteBalanceFilter *)self.filter setTemperature:sender.value];
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageVibranceFilter class])]){
        
        [(GPUImageVibranceFilter *)self.filter setVibrance:sender.value];
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageSharpenFilter class])]){
        
        [(GPUImageSharpenFilter *)self.filter setSharpness:sender.value];
        
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageHighlightShadowFilter class])]){
    
        [(GPUImageHighlightShadowFilter *)self.filter setShadows:sender.value];
    }
    
    
    [self.imageSource processImage];
}

- (IBAction)slide2Value_Changed:(UISlider *)sender {
    
    self.value2Lab.text = [NSString stringWithFormat:@"%f",sender.value];
    
    if ([self.type isEqualToString:NSStringFromClass([GPUImageWhiteBalanceFilter class])]){
        
        [(GPUImageWhiteBalanceFilter *)self.filter setTint:sender.value];
    
    }else if ([self.type isEqualToString:NSStringFromClass([GPUImageHighlightShadowFilter class])]){
        
        [(GPUImageHighlightShadowFilter *)self.filter setHighlights:sender.value];
    }
    
    [self.imageSource processImage];

}

@end
