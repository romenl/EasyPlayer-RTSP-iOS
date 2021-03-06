//
//  KxMovieDecoder.m
//  kxmovie
//
//  Created by Kolyvan on 15.10.12.
//  Copyright (c) 2012 Konstantin Boukreev . All rights reserved.
//
//  https://github.com/kolyvan/kxmovie
//  this file is part of KxMovie
//  KxMovie is licenced under the LGPL v3, see lgpl-3.0.txt

#import "KxMovieDecoder.h"
#import <Accelerate/Accelerate.h>

NSString * kxmovieErrorDomain = @"ru.kolyvan.kxmovie";
//static void FFLog(void* context, int level, const char* format, va_list args);

//static NSError * kxmovieError (NSInteger code, id info) {
//    NSDictionary *userInfo = nil;
//
//    if ([info isKindOfClass: [NSDictionary class]]) {
//        userInfo = info;
//    } else if ([info isKindOfClass: [NSString class]]) {
//        userInfo = @{ NSLocalizedDescriptionKey : info };
//    }
//
//    return [NSError errorWithDomain:kxmovieErrorDomain code:code userInfo:userInfo];
//}

//static NSString * errorMessage (kxMovieError errorCode) {
//    switch (errorCode) {
//        case kxMovieErrorNone:
//            return @"";
//        case kxMovieErrorOpenFile:
//            return NSLocalizedString(@"Unable to open file", nil);
//        case kxMovieErrorStreamInfoNotFound:
//            return NSLocalizedString(@"Unable to find stream information", nil);
//        case kxMovieErrorStreamNotFound:
//            return NSLocalizedString(@"Unable to find stream", nil);
//        case kxMovieErrorCodecNotFound:
//            return NSLocalizedString(@"Unable to find codec", nil);
//        case kxMovieErrorOpenCodec:
//            return NSLocalizedString(@"Unable to open codec", nil);
//        case kxMovieErrorAllocateFrame:
//            return NSLocalizedString(@"Unable to allocate frame", nil);
//        case kxMovieErroSetupScaler:
//            return NSLocalizedString(@"Unable to setup scaler", nil);
//        case kxMovieErroReSampler:
//            return NSLocalizedString(@"Unable to setup resampler", nil);
//        case kxMovieErroUnsupported:
//            return NSLocalizedString(@"The ability is not supported", nil);
//    }
//}

//static NSData * copyFrameData(UInt8 *src, int linesize, int width, int height) {
//    width = MIN(linesize, width);
//    NSMutableData *md = [NSMutableData dataWithLength: width * height];
//    Byte *dst = md.mutableBytes;
//
//    for (NSUInteger i = 0; i < height; ++i) {
//        memcpy(dst, src, width);
//        dst += width;
//        src += linesize;
//    }
//    
//    return md;
//}

//static BOOL isNetworkPath (NSString *path) {
//    NSRange r = [path rangeOfString:@":"];
//    if (r.location == NSNotFound)
//        return NO;
//
//    NSString *scheme = [path substringToIndex:r.length];
//    if ([scheme isEqualToString:@"file"])
//        return NO;
//
//    return YES;
//}

//static int interrupt_callback(void *ctx);

////////////////////////////////////////////////////////////////////////////////

@interface KxMovieFrame()

@end

@implementation KxMovieFrame

@end

@interface KxAudioFrame()

@end

@implementation KxAudioFrame

- (KxMovieFrameType) type { return KxMovieFrameTypeAudio; }

@end

@interface KxVideoFrame()

@end

@implementation KxVideoFrame
- (KxMovieFrameType) type { return KxMovieFrameTypeVideo; }
@end

@interface KxVideoFrameRGB ()
@end

@implementation KxVideoFrameRGB

- (KxVideoFrameFormat) format {
    return KxVideoFrameFormatRGB;
}

- (UIImage *) asImage {
    UIImage *image = nil;
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)(_rgb));
    if (provider) {
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        if (colorSpace) {
            CGImageRef imageRef = CGImageCreate(self.width,
                                                self.height,
                                                8,
                                                24,
                                                self.linesize,
                                                colorSpace,
                                                kCGBitmapByteOrderDefault,
                                                provider,
                                                NULL,
                                                YES, // NO
                                                kCGRenderingIntentDefault);
            
            if (imageRef) {
                image = [UIImage imageWithCGImage:imageRef];
                CGImageRelease(imageRef);
            }
            CGColorSpaceRelease(colorSpace);
        }
        CGDataProviderRelease(provider);
    }
    
    return image;
}

@end

@interface KxVideoFrameYUV()

@end

@implementation KxVideoFrameYUV

- (KxVideoFrameFormat) format {
    return KxVideoFrameFormatYUV;
}

//- (KxVideoFrame *) handleVideoFrame
//{
////    if (!_videoFrame->data[0])
////        return nil;
////    
////    KxVideoFrame *frame;
////    
////    if (_videoFrameFormat == KxVideoFrameFormatYUV) {
//        
////        KxVideoFrameYUV * yuvFrame = [[KxVideoFrameYUV alloc] init];
////        
////        yuvFrame.luma = copyFrameData(_videoFrame->data[0],
////                                      _videoFrame->linesize[0],
////                                      _videoCodecCtx->width,
////                                      _videoCodecCtx->height);
////        
////        yuvFrame.chromaB = copyFrameData(_videoFrame->data[1],
////                                         _videoFrame->linesize[1],
////                                         _videoCodecCtx->width / 2,
////                                         _videoCodecCtx->height / 2);
////        
////        yuvFrame.chromaR = copyFrameData(_videoFrame->data[2],
////                                         _videoFrame->linesize[2],
////                                         _videoCodecCtx->width / 2,
////                                         _videoCodecCtx->height / 2);
////        
////        frame = yuvFrame;
//}

@end
