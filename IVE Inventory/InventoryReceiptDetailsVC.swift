//
//  InventoryReceiptDetailsVC.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 09/02/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

enum IR_Type
{
    case PRICE
    case RECEIVED
    case INVOICE
}


class InventoryReceiptDetailsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    //Outlets
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var pageControl:UIPageControl!
    @IBOutlet weak var view_gradientBorder:UIView!
    
    @IBOutlet weak var priceContainerView:UIView!
    @IBOutlet weak var btn_price:UIButton!
    @IBOutlet weak var width_price:NSLayoutConstraint!
    
    @IBOutlet weak var receivedContainerView:UIView!
    @IBOutlet weak var btn_received:UIButton!
    @IBOutlet weak var width_received:NSLayoutConstraint!
    
    @IBOutlet weak var invoiceContainerView:UIView!
    @IBOutlet weak var btn_invoice:UIButton!
    @IBOutlet weak var width_invoice:NSLayoutConstraint!

    let grayColor = UIColor.init(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    let blueColor = UIColor.init(red: 3.0/255.0, green: 9.0/255.0, blue: 91.0/255.0, alpha: 1.0)
    
    var imagesArr = ["Apple", "Rose"]
    
    var iveReceipt:IVEReceipt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureButtons()
        configureView()
        
        self.collectionView.register(UINib.init(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.pageControl.numberOfPages = self.iveReceipt.images.count

    }
    
    func configureButtons()
    {
        self.priceContainerView.backgroundColor = grayColor
        self.priceContainerView.roundCorners(corners: .allCorners, radius: 5.0)
        self.receivedContainerView.backgroundColor = grayColor
        self.receivedContainerView.roundCorners(corners: .allCorners, radius: 5.0)
        self.invoiceContainerView.backgroundColor = grayColor
        self.invoiceContainerView.roundCorners(corners: .allCorners, radius: 5.0)
    }
    
    func configureNavigationBar()
    {
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "backbutton_icon"), target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
        
        self.title = "IR#\(self.iveReceipt.receipt_no!)"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.navigationController?.navigationBar.barTintColor = ColorConstant.navBarColor
        
        let composeButton = UIBarButtonItem.init(barButtonSystemItem: .compose, target: self, action:  #selector(printerButtonTapped))
        composeButton.tintColor = ColorConstant.blueFillColor
        
        self.navigationItem.rightBarButtonItem = composeButton
        
        self.view_gradientBorder.addHorizontalGradientColor(leftColor: ColorConstant.leftRedColor, and: ColorConstant.rightRedColor)
    }
    
    func configureView()
    {
    
        self.btn_price.isSelected = (self.iveReceipt.price_ok == "Yes") ? true : false
        self.btn_received.isSelected = (self.iveReceipt.received_qb == "Yes") ? true : false
        self.btn_invoice.isSelected = (self.iveReceipt.invoice_paid == "Yes") ? true : false
        
        self.animateView(animateView: self.priceContainerView, isSelected: self.btn_price.isSelected )
        self.animateView(animateView: self.receivedContainerView, isSelected: self.btn_received.isSelected )
        self.animateView(animateView: self.invoiceContainerView, isSelected: self.btn_invoice.isSelected )

    }
    
    //MARK:  Btn Tapped NavBar
    @objc func goBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func printerButtonTapped()
    {
        let internalVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "InternalNotesViewController") as! InternalNotesViewController
        internalVC.id = self.iveReceipt.id!
        internalVC.irNote_Mode = .ir
        self.navigationController?.pushViewController(internalVC, animated: true)
    }
    
    @objc func scannerButtonTapped()
    {
        print("#function = \(#function)")
        
        let scannerVC = DrConstants.kStoryBoard.instantiateViewController(withIdentifier: "ScannerViewController") as! ScannerViewController
        self.navigationController?.pushViewController(scannerVC, animated: true)
    }
    
    //MARK: COllectionView DataSource and Delegate 
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return self.iveReceipt.images.count
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.cancelButton.isHidden = true
        
        cell.scrollImageView.minimumZoomScale = 1.0
        cell.scrollImageView.maximumZoomScale = 3.0
        cell.capturedImageView.isUserInteractionEnabled = true
        
        let imageDict = self.iveReceipt.images[indexPath.section]
        if var imageStr = imageDict["image_name"] as? String
        {
            imageStr = "\(DrConstants.kBaseUrlImage)\(imageStr)"
            cell.capturedImageView?.sd_setImage(with: URL(string:imageStr), placeholderImage: #imageLiteral(resourceName: "electronics"))
        }
        
        cell.capturedImageView.contentMode = .scaleAspectFill
        return cell
    }
    
   
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        
        self.pageControl.currentPage = Int(currentPage)
    }

    
    @IBAction func buttonTapped_Price()
    {
        self.btn_price.isSelected = !self.btn_price.isSelected
        
        self.animateView(animateView: self.priceContainerView, isSelected: self.btn_price.isSelected )
        
        let status = self.btn_price.isSelected ? "Yes" : "No"
        
        JustHUD.shared.showInView(view: self.view)
        NetworkManager.sharedManager.getUpdateInventoryReceipts(mode: .PRICE, selectionStatus:status , inventory_id: self.iveReceipt.id!, completion: { status in
            JustHUD.shared.hide()
            if let _ = status
            {
                if status == true
                {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        })

    }
    @IBAction func buttonTapped_Received()
    {
        self.btn_received.isSelected = !self.btn_received.isSelected
        
        self.animateView(animateView: self.receivedContainerView, isSelected: self.btn_received.isSelected)

        let status = self.btn_received.isSelected ? "Yes" : "No"
        
        JustHUD.shared.showInView(view: self.view)
        NetworkManager.sharedManager.getUpdateInventoryReceipts(mode: .RECEIVED, selectionStatus:status , inventory_id: self.iveReceipt.id!, completion: { status in
            JustHUD.shared.hide()
            if let _ = status
            {
                if status == true
                {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        })

    }
    @IBAction func buttonTapped_Invoice()
    {
        self.btn_invoice.isSelected = !self.btn_invoice.isSelected
        
        self.animateView(animateView: self.invoiceContainerView, isSelected: self.btn_invoice.isSelected)
        
        let status = self.btn_invoice.isSelected ? "Yes" : "No"
        JustHUD.shared.showInView(view: self.view)
        NetworkManager.sharedManager.getUpdateInventoryReceipts(mode: .INVOICE, selectionStatus:status , inventory_id: self.iveReceipt.id!, completion: { status in
            JustHUD.shared.hide()
            if let _ = status
            {
                if status == true
                {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        })
    }
    
    func animateView(animateView:UIView , isSelected:Bool)
    {
        if isSelected == true
        {
            animateView.backgroundColor = self.blueColor
            UIView.animate(withDuration: 0.3,
                           animations: {
                            animateView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            },
                           completion: { _ in
                            
            })
        }
        else
        {
            UIView.animate(withDuration: 0.3,
                           animations: {
                            animateView.backgroundColor = self.grayColor
                            animateView.transform = CGAffineTransform.identity
            },
                           completion: { _ in
                            
            })
        }
    }
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
