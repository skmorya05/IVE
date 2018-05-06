//
//  ViewController.swift
//  CollectionView
//
//  Created by Er Sanjay Morya on 25/04/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UpdateCurrentPageProtocol
{
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    var dataSource = DataSource_ViewController()
    var delegate = Delegate_ViewController()
    
    var photos = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        configureNavigationBar()
        self.pageControl.numberOfPages = self.photos.count
        self.photoCollectionView.reloadData()
        
    }

    func configureNavigationBar()
    {
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "backbutton_icon"), target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    @objc func goBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func didUpdateCurrentPage(pageNumber:Int)
    {
        self.pageControl.currentPage = pageNumber
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension GalleryViewController
{
    func setUp()
    {
        self.photoCollectionView.register(UINib.init(nibName: "GalleryCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCell")
        self.dataSource.photosArr = self.photos
        self.delegate.photosArr = self.photos
        self.delegate.delegate = self
        self.delegate.cellSize = self.view.bounds.size
        self.photoCollectionView.dataSource = self.dataSource
        self.photoCollectionView.delegate = self.delegate
    }
}
