//
//  UIImageExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/23.
//  Copyright © 2018年 uxiu.me Co. Ltd. All rights reserved.
//

import UIKit
import Accelerate

@objc public extension UIImage {
    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - imgName: <#imgName description#>
    ///   - bundleName: <#bundleName description#>
    /// - Returns: <#return value description#>
    static func `init`(_ imgName: String, inBundle bundleName: String) -> UIImage? {
//        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
//        NSString *imgPath= [bundlePath stringByAppendingPathComponent:imgName];
//        UIImage *image=[UIImage imageWithContentsOfFile:imgPath];
//        return image;
        let tmpBundlePath = Bundle.main.path(forResource: bundleName, ofType: "bundle")
        guard let bundlePath = tmpBundlePath else {
            return nil
        }
        let tmpBundle = Bundle.init(path: bundlePath)
        guard let bundle = tmpBundle else {
            return nil
        }
        let tmpImagePath = bundle.path(forResource: imgName, ofType: "png")
        guard let imagePath = tmpImagePath else {
            return nil
        }
        let tmpImage = UIImage(contentsOfFile: imagePath)?.withRenderingMode(.alwaysOriginal)
        guard let image = tmpImage else {
            return nil
        }
        return image
    }
    
    
    
    /// 根据颜色创建一张纯色的图片
    ///
    /// - Parameter color: 颜色值
    /// - Parameter size: 图片大小
    /// - Returns: 返回一个UIImage实例
    static func `init`(with color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static func from(_ color: UIColor, size: CGSize = .init(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    func blur(level: CGFloat) -> UIImage {
        // 处理模糊程度, 防止超出
        var levelValue: CGFloat = level
        if level < 0 {
            levelValue = 0.1
        } else if level > 1.0 {
            levelValue = 1.0
        }
        
        // boxSize 必须大于 0
        var boxSize = Int(levelValue * 100)
        boxSize = boxSize - (boxSize % 2) + 1
        
        let cgImage = self.cgImage!
        
        // 图像缓存: 输入缓存、输出缓存
        var inBuffer = vImage_Buffer()
        var outBuffer = vImage_Buffer()
        var error = vImage_Error()
        
        
        let inProvider = cgImage.dataProvider
        let inBitmapData = inProvider?.data
        
        inBuffer.width = vImagePixelCount(cgImage.width)
        inBuffer.height = vImagePixelCount(cgImage.height)
        inBuffer.rowBytes = cgImage.bytesPerRow
        inBuffer.data = UnsafeMutableRawPointer(mutating: CFDataGetBytePtr(inBitmapData!))
        
        // 像素缓存
        let pixelBuffer = malloc(cgImage.bytesPerRow * cgImage.height)
        outBuffer.data = pixelBuffer
        outBuffer.width = vImagePixelCount((cgImage.width))
        outBuffer.height = vImagePixelCount((cgImage.height))
        outBuffer.rowBytes = cgImage.bytesPerRow
        
        // 中间缓存区, 抗锯齿
        let pixelBuffer2 = malloc(cgImage.bytesPerRow * cgImage.height)
        var outBuffer2 = vImage_Buffer()
        outBuffer2.data = pixelBuffer2
        outBuffer2.width = vImagePixelCount(cgImage.width)
        outBuffer2.height = vImagePixelCount(cgImage.height)
        outBuffer2.rowBytes = cgImage.bytesPerRow
        
        error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        error = vImageBoxConvolve_ARGB8888(&outBuffer2, &outBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        
        
        if error != kvImageNoError {
            debugPrint(error)
        }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: outBuffer.data, width: Int(outBuffer.width), height: Int(outBuffer.height), bitsPerComponent: 8, bytesPerRow: outBuffer.rowBytes, space: colorSpace, bitmapInfo: cgImage.bitmapInfo.rawValue)
        
        let finalCGImage = context!.makeImage()
        let finalImage = UIImage(cgImage: finalCGImage!)
        
        free(pixelBuffer!)
        free(pixelBuffer2!)
        
        return finalImage
    }
    
}

public extension UIImage {
    
    /// 压缩图片质量(Quality)，图片尺寸不变，文件大小变
    /// - Parameters:
    ///   - fileSize: 文件大小，单位 “字节(byte 8个比特)”。 e.g.：150 * 1024 --> 150KB
    ///   - eachRatio: while循环压缩率 0.0 ~ 1.0
    /// - Returns: 压缩成功返回 image 的 Data 文件，压缩失败返回 nil
    func compressed(lessThan fileSize: Int, eachRatio: CGFloat = 0.9) -> Data? {
        var ratio = eachRatio
        guard var compressedImg = jpegData(compressionQuality: ratio) else { return nil }
        while compressedImg.count > fileSize {
            ratio = ratio * eachRatio
            guard let _compressedImg = jpegData(compressionQuality: ratio) else { return nil }
            compressedImg = _compressedImg
        }
        print("压缩后的图片大小：\(compressedImg.count / 1024) kb")
        return compressedImg
    }
    
    
}

extension UIImage {
    
    /// 将图片缩放成指定尺寸（多余部分自动删除）
    ///
    /// 将图片转成 400 * 300 尺寸
    /// let image2 = image.scaled(to: CGSize(width: 400, height: 300))
    public func scaled(to newSize: CGSize) -> UIImage {
        //计算比例
        let aspectWidth  = newSize.width/size.width
        let aspectHeight = newSize.height/size.height
        let aspectRatio = max(aspectWidth, aspectHeight)
        
        //图片绘制区域
        var scaledImageRect = CGRect.zero
        scaledImageRect.size.width  = size.width * aspectRatio
        scaledImageRect.size.height = size.height * aspectRatio
        scaledImageRect.origin.x    = (newSize.width - size.width * aspectRatio) / 2.0
        scaledImageRect.origin.y    = (newSize.height - size.height * aspectRatio) / 2.0
        
        //绘制并获取最终图片
        UIGraphicsBeginImageContext(newSize)
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    /// 将图片裁剪成指定比例（多余部分自动删除）
    ///
    /// 原始图片
    /// let image = UIImage(named: "image.jpg")!
    ///
    /// 将图片转成 4:3 比例
    /// let image2 = image.crop(ratio: 4/3)
    ///
    /// 将图片转成 1:1 比例（正方形）
    /// let image3 = image.crop(ratio: 1)
    func crop(ratio: CGFloat) -> UIImage {
        //计算最终尺寸
        var newSize:CGSize!
        if size.width/size.height > ratio {
            newSize = CGSize(width: size.height * ratio, height: size.height)
        }else{
            newSize = CGSize(width: size.width, height: size.width / ratio)
        }
        
        ////图片绘制区域
        var rect = CGRect.zero
        rect.size.width  = size.width
        rect.size.height = size.height
        rect.origin.x    = (newSize.width - size.width ) / 2.0
        rect.origin.y    = (newSize.height - size.height ) / 2.0
        
        //绘制并获取最终图片
        UIGraphicsBeginImageContext(newSize)
        draw(in: rect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    /**
     *  重设图片大小
     */
    func reSizeImage(_ reSize: CGSize) -> UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRectMake(0, 0, reSize.width, reSize.height));
        let reSizeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize: CGFloat) -> UIImage {
        let size = CGSize(width: size.width * scaleSize, height: size.height * scaleSize)
        return reSizeImage(size)
    }
    
    
}
