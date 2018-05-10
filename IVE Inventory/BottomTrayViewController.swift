//
//  BottomTrayViewController.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 21/01/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import Alamofire


enum CameraMode {
    case QRCode
    case Receipt
}

protocol QRCodeReadProtocol:class {
    func didUpdate(qrcodeStr:String)
}

let cellIdef = "BottomTrayCell"


class BottomTrayViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NextButtonProtocol, VendorSelectionProtocol
{

    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var pageControl:UIPageControl!

    let scanner = ScanManager.init()
    var picker = UIImagePickerController()
    var cell : BottomTrayCell!
    var actionToEnable : UIAlertAction!
    var irNameStr = String()
    
    weak var delegate_QRCRProtocol:QRCodeReadProtocol!
    weak var delegate_InternalProtocol: InternalProtocols!
    
    var isCameraOnly:Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.navigationItem.leftBarButtonItem = nil

        self.collectionView.register(UINib.init(nibName: "BottomTrayCell", bundle: nil), forCellWithReuseIdentifier: cellIdef)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
        
        if self.isCameraOnly == true
        {
            self.updatePageIfShowCameraOnly()
        }
        else
        {
            self.showNavigationBar(mode: .QRCode)
        }
    }
    
    func updatePageIfShowCameraOnly()
    {
        self.collectionView.scrollToItem(at: IndexPath.init(row: 0, section: 1), at: .centeredHorizontally, animated: false)
        
        let flashButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "Flash"), target: self, action: #selector(btnTapped_Flash))
        self.navigationItem.rightBarButtonItem = flashButton
        
        
        let backButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "backbutton_icon"), target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton

        
        self.title = "Inventory Camera Receipt"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.pageControl.isHidden = true
    }
    
    //MARK:- NavigationBar Button Action
    @objc func goBack()
    {
        if isCameraOnly
        {
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 2
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize.init(width: ScreenSize.SCREEN_WIDTH, height: self.collectionView.frame.height)
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdef, for: indexPath) as! BottomTrayCell
        self.cell = cell
        
        if indexPath.section == 0
        {
            cell.delegateNextBtn = nil
            scanner.showScanner(cell, { (code, errorMsg) in
                
                if let _ = code
                {
                    self.dismiss(animated: true, completion: {
                        if let _ = self.delegate_QRCRProtocol
                        {
                            self.delegate_QRCRProtocol.didUpdate(qrcodeStr: code!)
                        }
                    })
                }
            })
        }
        else
        {
            cell.showCamera()
            cell.delegateNextBtn = self
            if cell.images_captured.count == 0
            {
                cell.height_collectionView.constant = 0.0
                cell.collecton_ContainerView.isHidden = true
            }
            else
            {
                cell.collecton_ContainerView.isHidden = false
                
                if UIDevice.current.userInterfaceIdiom == .phone
                {
                    cell.height_collectionView.constant = 84.0
                }
                else if UIDevice.current.userInterfaceIdiom == .pad
                {
                    cell.height_collectionView.constant = 120.0
                }
            }
            cell.collecton_ContainerView.layoutIfNeeded()
        }
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1

        self.pageControl.currentPage = Int(currentPage)
        
        if  self.pageControl.currentPage == 0
        {
            self.showNavigationBar(mode: .QRCode)
            if !self.scanner.captureSession.isRunning
            {
                self.scanner.captureSession.startRunning()
            }
        }
        else
        {
            self.showNavigationBar(mode: .Receipt)
            if !self.cell.captureSession.isRunning
            {
                self.cell.captureSession.startRunning()
            }
        }
    }
    
    func showNavigationBar(mode: CameraMode)
    {
        if mode == .QRCode
        {
            let backButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "Down_arrow"), target: self, action: #selector(goBack))
            self.navigationItem.leftBarButtonItem = backButton
            self.navigationItem.rightBarButtonItem = nil

            self.title = "QRCode Scanner"
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]

        }
        else if mode == .Receipt

        {
            let flashButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "Flash"), target: self, action: #selector(btnTapped_Flash))
            self.navigationItem.leftBarButtonItem = flashButton

            
            let gridButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "Grid"), target: self, action: #selector(gridButton_Tapped))
            self.navigationItem.rightBarButtonItem = gridButton
            
            self.title = "Inventory Camera Receipt"
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]

        }
    }

    @objc func btnTapped_Flash()
    {
        guard let flashLight = AVCaptureDevice.default(for: .video) else
        {
            return
        }
        
        if (flashLight.isTorchAvailable) && (flashLight.isTorchModeSupported(AVCaptureDevice.TorchMode.on))
        {
            do {
                 try flashLight.lockForConfiguration()
                
                    if flashLight.isTorchActive == true
                    {
                        flashLight.torchMode = .off
                    }
                    else
                    {
                        flashLight.torchMode = .on
                    }
                
                    flashLight.unlockForConfiguration()
            }
            catch{
                
            }
            
        }

        
    }
    
    @objc func gridButton_Tapped()
    {
        
    }
    
    //MARK:- NextButtonProtocol
    func nextbuttonTapped(images:[UIImage])
    {
        NetworkManager.sharedManager.getVendorsList { (vendorsList) in
            
            if let _ = vendorsList
            {
                DispatchQueue.main.async {
                    let vc = VendorSelectionVC.init(nibName: "VendorSelectionVC", bundle: nil)
                    vc.vendors = vendorsList
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    vc.delegateVendor = self
                    
                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate
                    {
                        //appDelegate.window?.rootViewController?.present(vc, animated: true, completion: nil)
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @objc func textChangedBegain(_ sender:UITextField)
    {
        if sender.text?.count != 0
        {
            self.actionToEnable?.isEnabled = true
        }
        else
        {
            self.actionToEnable?.isEnabled = false
        }
        
        sender.isUserInteractionEnabled = false
        sender.resignFirstResponder()
    }
    
    func didSelectVendor(name:String)
    {
        let alertController = UIAlertController(title: "Message!", message: "Inventory Camera Receipt", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Please enter receipt name"
            textField.textAlignment = .left
            
            textField.addTarget(self, action: #selector(BottomTrayViewController.textChangedBegain(_ :)), for: .editingDidBegin)
            
            textField.text = name
            
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler:nil))
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            
            JustHUD.shared.showInView(view: self.view)
            NetworkManager.sharedManager.uploadInventoryReceipts(images: self.cell.images_captured, irNameStr: name, completion: {
                
                JustHUD.shared.hide()
                
                let errorAlert = UIAlertController(title: "Message", message: "Inventory images saved", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                    alert -> Void in
                    
                    if self.isCameraOnly == true
                    {
                        if let _ = self.delegate_InternalProtocol
                        {
                            self.delegate_InternalProtocol.didTappedInternalProtocols()
                        }
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                    else
                    {
                        self.dismiss(animated: true, completion: {
                            if let _ = self.delegate_InternalProtocol
                            {
                                self.delegate_InternalProtocol.didTappedInternalProtocols()
                            }
                        })
                    }
                }))
                
                self.present(errorAlert, animated: true, completion: nil)
                
            })
        })
        
        self.actionToEnable = saveAction
        alertController.addAction(saveAction)
        saveAction.isEnabled = false
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showMaxImagesAlert()
    {
        let alert = UIAlertController(title: "Alert!", message: "You can take Max six Images of Receipts", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
   
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

