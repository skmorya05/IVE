//
//  BottomTrayCell.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 21/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit
import AVFoundation

protocol NextButtonProtocol:class
{
    func nextbuttonTapped(images:[UIImage])
    func showMaxImagesAlert()
}

class BottomTrayCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ImageSaveProtocol
{
    @IBOutlet weak var cellContainerView: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collecton_ContainerView: UIView!
    @IBOutlet weak var height_collectionView: NSLayoutConstraint!
    
    let captureSession = AVCaptureSession()
    
    var sessionOutput = AVCaptureStillImageOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    var images_captured = [UIImage]()
    var delegateNextBtn: NextButtonProtocol!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        cellContainerView.roundCorners(radius: 5.0)
        collectionView.register(UINib.init(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func layoutIfNeeded()
    {
        
    }
    
    func showCamera()
    {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        let devices = AVCaptureDevice.devices(for: .video)
        for device in devices
        {
            if device.position == AVCaptureDevice.Position.back
            {
                do {
                     let input = try AVCaptureDeviceInput.init(device: device as! AVCaptureDevice)
                    if captureSession.canAddInput(input)
                    {
                        captureSession.addInput(input)
                        sessionOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
                        
                        if captureSession.canAddOutput(sessionOutput)
                        {
                            captureSession.addOutput(sessionOutput)
                            captureSession.startRunning()
                            previewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession)
                            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                            previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                            previewLayer.frame = CGRect.init(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH - 20, height: self.frame.size.height-20)
                            cellContainerView.layer.addSublayer(previewLayer)
                            self.bringSubview(toFront: self.cameraButton)
                        }
                    }
                }
                catch
                {
                    
                }
            }
        }
    }
    
    @IBAction func btnTapped_camera(sender: UIButton)
    {
        if self.images_captured.count <= 5
        {
            if let videoConnection = sessionOutput.connection(with: AVMediaType.video)
            {
                sessionOutput.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (buffer:CMSampleBuffer?, error:Error?) in
                    
                    if let imagedata = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buffer!)
                    {
                        if let image = UIImage.init(data: imagedata)
                        {
                            DispatchQueue.main.async {
                                
                                if !self.images_captured.contains(image)
                                {
                                    self.images_captured.append(image)
                                }
                                
                                if self.images_captured.count == 0
                                {
                                    self.height_collectionView.constant = 0.0
                                    self.collecton_ContainerView.isHidden = true
                                }
                                else
                                {
                                    self.collecton_ContainerView.isHidden = false
                                    
                                    if UIDevice.current.userInterfaceIdiom == .phone
                                    {
                                        self.height_collectionView.constant = 84.0
                                    }
                                    else if UIDevice.current.userInterfaceIdiom == .pad
                                    {
                                        self.height_collectionView.constant = 120.0
                                    }
                                }
                                
                                self.collecton_ContainerView.layoutIfNeeded()
                                self.collectionView.reloadData()
                            }
                        }
                    }
                })
            }
        }
        else
        {
            if let _ = self.delegateNextBtn
            {
                self.delegateNextBtn.showMaxImagesAlert()
            }
        }
    }
    
    
    //MARK:- ImageSaveProtocol
    func didDeleteImageFromCamera(cell:ImageCell)
    {
       if let indexPath = collectionView.indexPath(for: cell)
       {
          let section = indexPath.section
          self.images_captured.remove(at:section)
        
          if self.images_captured.count == 0
          {
            self.height_collectionView.constant = 0.0
            self.collecton_ContainerView.isHidden = true
          }
          else
          {
            self.collecton_ContainerView.isHidden = false
          }
        
          self.collectionView.reloadData()
       }
    }
    
    @IBAction func nextButtonTapped(sender:UIButton)
    {
        if let _ = self.delegateNextBtn
        {
            self.delegateNextBtn.nextbuttonTapped(images: self.images_captured)
        }
    }
    
    //MARK:- UICOllectionView DataSource and Delegate Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return images_captured.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            return CGSize.init(width: 84.0, height: 84.0)
        }
        else if UIDevice.current.userInterfaceIdiom == .pad
        {
            return CGSize.init(width: 120.0, height: 120.0)
        }
        
        return CGSize.init(width: 120.0, height: 120.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.capturedImageView.image = self.images_captured[indexPath.section]
        cell.delgate_ImageSave = self
        return cell
    }
    
}
