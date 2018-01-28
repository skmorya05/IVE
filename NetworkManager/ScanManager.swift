//
//  ScanManager.swift
//  QRCodeReader
//
//  Created by Vivan Raghuvanshi on 06/01/18.
//  Copyright © 2018 Vivan Raghuvanshi. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class ScanManager:NSObject {
    
    // Supported Types of code
    private let supportedCodeType = AVMetadataObject.ObjectType.qr
    
    let captureSession = AVCaptureSession()
    
    fileprivate var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    fileprivate var qrCodeFrameView:UIView?
    
    fileprivate var scannedCode:((_ :String?,_ :String?)->Void)?
    fileprivate var view:UIView?
    
    override init()
    {
        super.init()
    }
    
    func showScanner(_ sender:UIView,_ codeText:@escaping (_ :String?,_ :String?)->Void) {
        view = sender
        scannedCode = codeText
        self.setUpSession()
    }
    
    private func intializeDetectedCodeGreenView() {
    
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view?.addSubview(qrCodeFrameView)
            view?.bringSubview(toFront: qrCodeFrameView)
        }
    }
    
    
    private func setUpSession() {
        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            //captureSession.addInput(input)
            if captureSession.inputs.isEmpty
            {
                self.captureSession.addInput(input)
            }
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [supportedCodeType]
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            
            let rect = self.view?.frame
            videoPreviewLayer?.frame = CGRect.init(x: 10, y: 10, width: ScreenSize.SCREEN_WIDTH - 20, height: (rect?.size.height)!-20)
            view?.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession.startRunning()
            
            self.intializeDetectedCodeGreenView()
            
        }
        catch
        {
            print(error)
            return
        }
    }
    
    // MARK: - Helper methods
    private func launchApp(decodedURL: String) {
        if self.captureSession.isRunning
        {
            self.captureSession.stopRunning()
        }
        self.captureSession.stopRunning()
        scannedCode?(decodedURL,nil)
    }
}

extension ScanManager:AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            qrCodeFrameView?.layer.borderColor = UIColor.clear.cgColor
            scannedCode?(nil,"No QR code is detected")
            return
        }
        
        // Get the metadata object.
        if let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
            
            if supportedCodeType == metadataObj.type {
                
                // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
                if let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj) {
                    print("frame \(barCodeObject.bounds)")
                    qrCodeFrameView?.frame = barCodeObject.bounds
                }
                
                if let msg = metadataObj.stringValue
                {
                    launchApp(decodedURL: msg)
                }
            }
        }
    }
}
