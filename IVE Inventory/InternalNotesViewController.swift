//
//  InternalNotesViewController.swift
//  IVE Inventory
//
//  Created by Er Sanjay Morya on 03/02/18.
//  Copyright © 2018 Sanjay. All rights reserved.
//

import UIKit

enum InternalNoteMode {
    case rma
    case ir
    case none
}

class InternalNotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var view_gradientBorder:UIView!
    @IBOutlet weak var textView_Notes:UITextView!
    @IBOutlet weak var tableView_Notes:UITableView!
    
    @IBOutlet weak var heightConstraints:NSLayoutConstraint!

    var id: String!
    var array_table = [[String: Any]]()
    var array_Data = [[String: Any]]()
    var irNote_Mode: InternalNoteMode = .none

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        configureNavigationBar()
        configureView()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.heightConstraints.constant = 0
        self.tableView_Notes.roundCorners(radius: 0.0, width: 1.5, color: ColorConstant.navBarColor)
        
        refreshPage()
    }

    func refreshPage()
    {
        JustHUD.shared.showInView(view: self.view)

        if self.irNote_Mode == .rma
        {
            NetworkManager.sharedManager.getRmaLogsList(rmaId: self.id) { rmaLogs in
                JustHUD.shared.hide()
                if let _ = rmaLogs
                {
                    self.array_table = rmaLogs!
                    self.tableView_Notes.reloadData()
                    
                    if self.array_table.count == 0
                    {
                        self.showAlert(message: "No Internal Notes Found!")
                    }
                }
            }
        }
        else if self.irNote_Mode == .ir
        {
            NetworkManager.sharedManager.getInventoryLogsList(invId: self.id!) { rmaLogs in
                JustHUD.shared.hide()
                if let _ = rmaLogs
                {
                    self.array_table = rmaLogs!
                    self.tableView_Notes.reloadData()
                    
                    if self.array_table.count == 0
                    {
                        self.showAlert(message: "No Internal Notes Found!")
                    }
                }
            }
        }
    }
    
    
    func configureNavigationBar()
    {
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem.itemWith(colorfulImage: UIImage.init(named: "backbutton_icon"), target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
        
        self.title = "Internal Notes"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.blueFillColor]
        self.navigationController?.navigationBar.barTintColor = ColorConstant.navBarColor
        
        let rightButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(btnTapped_Add))
        rightButton.tintColor = ColorConstant.blueFillColor
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func configureView()
    {
        self.view_gradientBorder.addHorizontalGradientColor(leftColor: ColorConstant.leftRedColor, and: ColorConstant.rightRedColor)
        self.tableView_Notes.register(UINib.init(nibName: "InternalNoteCell", bundle: nil), forCellReuseIdentifier: "InternalNoteCell")
        self.tableView_Notes.estimatedRowHeight = 44.0
        self.tableView_Notes.rowHeight = UITableViewAutomaticDimension
        self.textView_Notes.inputAccessoryView = nil
        
    }
    
    //MARK:- NavigationBar Button Action
    @objc func goBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnTapped_Add()
    {
        let rightButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(btnTapped_Done))
        rightButton.tintColor = ColorConstant.blueFillColor
        self.navigationItem.rightBarButtonItem = rightButton
        
        self.heightConstraints.constant = 80
        self.textView_Notes.text = DrConstants.kInternalPlaceholder
        self.textView_Notes.textColor = UIColor.lightGray
        
        let header = UIView.init(frame:CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH , height: 8.0))
        header.backgroundColor = ColorConstant.navBarColor
        self.tableView_Notes.tableHeaderView = header
        
    }
    
    @objc func btnTapped_Done()
    {
        let rightButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(btnTapped_Add))
        rightButton.tintColor = ColorConstant.blueFillColor
        self.navigationItem.rightBarButtonItem = rightButton
        self.heightConstraints.constant = 0
        self.tableView_Notes.tableHeaderView = nil
        self.createNewNotesDict()
        
        if self.textView_Notes.isFirstResponder
        {
            self.textView_Notes.resignFirstResponder()
        }
    }
    
    func createNewNotesDict()
    {
        if let text = self.textView_Notes.text
        {
            if text.count > 0 &&  text != DrConstants.kInternalPlaceholder
            {
                NetworkManager.sharedManager.uploadCustomLogsReceipts(self.id!, screenMode: self.irNote_Mode, text, {
                    self.refreshPage()
                })
            }
        }
    }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return array_table.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return  UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InternalNoteCell", for: indexPath) as! InternalNoteCell
        
        let dict = self.array_table[indexPath.row]
        var message = String()
        
        cell.number_label.text = "\(indexPath.row + 1)#"
        
        if let user = dict["empname"]
        {
            message = "\(user)"
        }
        
        if let timestamp = dict["date"]
        {
            message = "\(message) \(timestamp)  "
        }
        
        if let note = dict["message"]
        {
            message = "\(message) \(note)"
        }
        
        
        cell.note_label.text = message
        
        return cell
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}


extension InternalNotesViewController:UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if textView.text == DrConstants.kInternalPlaceholder
        {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = DrConstants.kInternalPlaceholder
            textView.textColor = UIColor.lightGray
        }
    }
}
