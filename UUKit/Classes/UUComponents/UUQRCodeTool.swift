//
//  QRCodeTool.swift
//  UUKit
//
//  Created by 夏军辉 on 2021/11/15.
//

import Foundation
import AVFoundation
import UIKit

public typealias UUQRCodeScanResult = ([String]) -> ()

@available(iOS 10.2, *)
public class UUQRCodeTool: NSObject {
    static let shared = UUQRCodeTool()
    
    fileprivate lazy var input: AVCaptureDeviceInput? = {
        let deviceSession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInDualCamera], mediaType: .video, position: .back)
        let backDevice = deviceSession.devices[0]
        var isFlash = backDevice.hasFlash
        
        print(isFlash.hashValue)
        let input = try? AVCaptureDeviceInput(device: deviceSession.devices[0])
        return input
    }()
    
    fileprivate lazy var output: AVCaptureMetadataOutput = {
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        return output
    }()
    
    fileprivate lazy var session: AVCaptureSession = {
        let session = AVCaptureSession()
        return session
    }()
    
    fileprivate lazy var preLayer: AVCaptureVideoPreviewLayer? = {
        let preLayer = AVCaptureVideoPreviewLayer(session: self.session)
        // 设置视频预览图层尺寸适配方法
        preLayer.videoGravity = .resizeAspectFill
        return preLayer
    }()
    
    var isDrawFrame: Bool = false
    
    var resultBlock: UUQRCodeScanResult?
}

// MARK: - 开启摄像头扫描二维码
@available(iOS 10.2, *)
extension UUQRCodeTool {
    /// 扫描二维码
    ///
    /// - parameter inView:      视频预览图层的承载视图
    /// - parameter isDrawFrame: 是否需要绘制边框
    /// - parameter resultBlock: 结果代码块
    public func scanQRCode(inView: UIView, isDrawFrame: Bool = false, resultBlock: UUQRCodeScanResult?) {
        self.resultBlock = resultBlock
        
        self.isDrawFrame = isDrawFrame
        
        // 创建一个会话，连接输入和输出
        if let input = input {
            if session.canAddInput(input), session.canAddOutput(output) {
                session.addInput(input)
                session.addOutput(output)
            }
        }
        
        // 输出处理对象，可以处理的数据类型
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        // 添加视频预览图层，然后用户可以看见扫描界面
        preLayer!.frame = UIScreen.main.bounds
        inView.layer.insertSublayer(preLayer!, at: 0)
        
        // 5.启动会话
        session.startRunning()
    }
    
    /// 取消扫描
    func stopScan() {
        session.stopRunning()
    }
}

// MARK: - 设置扫描区域
@available(iOS 10.2, *)
extension UUQRCodeTool {
    /// 设置扫描区域
    ///
    /// - parameter scanRect: 扫描区域
    func setScanRect(scanRect: CGRect) {
        let screenSize = UIScreen.main.bounds.size
        let xR = scanRect.origin.x / screenSize.width
        let yR = scanRect.origin.y / screenSize.height
        let wR = scanRect.size.width / screenSize.width
        let hR = scanRect.size.height / screenSize.height
        output.rectOfInterest = CGRect(x: yR, y: xR, width: hR, height: wR)
    }
}

// MARK: - 闪光灯开关
@available(iOS 10.2, *)
extension UUQRCodeTool {
    /// 闪光灯开关
    ///
    /// - parameter isOn: 闪光灯状态
    func setTorch(isOn: Bool) {
        let device = input?.device
        if device?.hasTorch ?? false {
            //  操作设备之前，必须先搜定设备
            try? device?.lockForConfiguration()
            // 进行修改配置
            device?.torchMode = isOn ? .on : .off
            // 解锁设备
            device?.unlockForConfiguration()
        }
    }
}

@available(iOS 10.2, *)
extension UUQRCodeTool {
    /// 根据字符串和图片比例生成一张二维码图片，可以添加自定义中间图片
    ///
    /// - parameter input:       输入的字符串内容
    /// - parameter scale:       图片的缩放比例，默认(30， 30)
    /// - parameter middleImage: 自定义的中间图片
    ///
    /// - returns: 二维码图片
    public func createQRCode(input: String, scale: CGPoint = CGPoint(x: 30, y: 30), middleImage: UIImage?) -> UIImage {
        // 1.创建二维码滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        // 恢复滤镜设置
        filter?.setDefaults()
        
        // 2.给滤镜设置输入内容，只能用KVC设置输入的内容
        let data = input.data(using: String.Encoding.utf8)
        
        filter?.setValue(data, forKeyPath: "inputMessage")
        // 设置纠错率
        filter?.setValue("H", forKeyPath: "inputCorrectionLevel")
        
        // 3.直接取出图片
        let outImage = filter?.outputImage
        
        // 4.对图片进行处理
        let resImage = outImage?.transformed(by: CGAffineTransform(scaleX: scale.x, y: scale.y))
        let image = UIImage(ciImage: resImage!)
        
        guard middleImage != nil else {
            return image
        }
        return addMiddleImage(image: middleImage!, toBackImage: image)
    }
    
    /// 根据一个二维码图片，查看二维码结果，并返回
    ///
    /// - parameter qrImage: 二维码图片
    ///
    /// - returns: 识别结果和绘制好边框的二维码图片
    func detectorQRCode(qrImage: UIImage) -> (resultStrs: [String], resultImg: UIImage) {
        // 1.创建一个二维码探测器
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        
        // 2.探测图片的特征值
        let ciImage = CIImage(image: qrImage)
        guard let features = detector?.features(in: ciImage!) else {
            return ([], qrImage)
        }
        
        // 3.处理特征值
        var resultImg = qrImage
        var resultStrs = [String]()
        for feature in features as! [CIQRCodeFeature] {
            resultStrs.append(feature.messageString!)
            // 在识别出来的图片周围添加相框
            resultImg = drawFrame(feature: feature, image: resultImg)
        }
        return (resultStrs, resultImg)
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
@available(iOS 10.2, *)
extension UUQRCodeTool: AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if isDrawFrame {
            removeQRCodeFrame(layer: preLayer!)
        }
        
        var resultStrs = [String]()
        
        for metadataObject in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
            if isDrawFrame {
                drawQRCodeFrame(metadataObject: metadataObject, layer: preLayer!)
            }
            resultStrs.append(metadataObject.stringValue ?? "")
        }
        
        resultBlock?(resultStrs)
    }
}

@available(iOS 10.2, *)
private extension UUQRCodeTool {
    func addMiddleImage(image: UIImage, toBackImage: UIImage) -> UIImage {
        // 开启图形上下文
        let size: CGSize = toBackImage.size
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(size, true, scale)
        
        // 绘制大图片
        toBackImage.draw(in: CGRect(x: 0, y: 0, width: size
                                        .width, height: size.height))
        
        // 绘制小图片
        let w = size.width * 0.3
        let h = size.height * 0.3
        let x = (size.width - w) * 0.5
        let y = (size.height - h) * 0.5
        
        image.draw(in: CGRect(x: x, y: y, width: w, height: h))
        
        // 从图形上下文中取得图片
        let curImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        
        guard curImage != nil else {
            return toBackImage
        }
        return curImage!
    }
    
    func drawFrame(feature: CIQRCodeFeature, image: UIImage) -> UIImage {
        // 1.开启图形上下文
        let size = image.size
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(size, true, scale)
        
        // 2.绘制大图片
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        // 3.翻转坐标系
        let context = UIGraphicsGetCurrentContext()
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -size.height)
        
        UIColor.red.setStroke()
        let bounds = feature.bounds
        let path = UIBezierPath(rect: bounds)
        path.lineWidth = 10
        path.stroke()
        
        // 4.获取新图片
        let curImage = UIGraphicsGetImageFromCurrentImageContext() ?? image
        
        // 5.关闭图形上下文
        UIGraphicsEndImageContext()
        
        return curImage
    }
    
    func removeQRCodeFrame(layer: AVCaptureVideoPreviewLayer) {
        if let layers = layer.sublayers {
            for layer in layers {
                if layer.isKind(of: CAShapeLayer.self) {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    
    func drawQRCodeFrame(metadataObject: AVMetadataMachineReadableCodeObject, layer: AVCaptureVideoPreviewLayer) {
        guard let qrObj = layer.transformedMetadataObject(for: metadataObject) as? AVMetadataMachineReadableCodeObject else { return }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 6
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        let path = UIBezierPath()
        
        let pointArray = qrObj.corners
        for (index, point) in pointArray.enumerated() {
            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        
        path.close()
        shapeLayer.path = path.cgPath
        
        layer.addSublayer(shapeLayer)
    }
}
