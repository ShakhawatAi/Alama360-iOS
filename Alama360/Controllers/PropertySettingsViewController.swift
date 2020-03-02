//
//  PropertySettingsViewController.swift
//  Alama360
//
//  Created by Alama360 on 28/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import LanguageManager_iOS
import CollapsibleTableSectionViewController

struct ExpandCollapse {
    var isExpanded: Bool
    var rows: Int
}

class PropertySettingsViewController: UIViewController {
    
    @IBOutlet weak var sview: OwnerSettingsSectionHeader!
    @IBOutlet weak var ssview: UIView!
    @IBOutlet weak var propertySettingsTable: UITableView!
    let defaults = UserDefaults.standard
    let lan = LanguageManager.shared.currentLanguage.rawValue
    
    var bankArray = [BankCategoryModel]()
    var timeArray = [TimeModel]()
    var clientManagerArray = [ClientManagerModel]()
    var sectionBool: Bool = false
    var sectionHeight: CGFloat = 40.0
    
    var sectionArray = [ExpandCollapse(isExpanded: false, rows: 1),
                        ExpandCollapse(isExpanded: false, rows: 1),
                        ExpandCollapse(isExpanded: false, rows: 1),
                        ExpandCollapse(isExpanded: false, rows: 4),
                        ExpandCollapse(isExpanded: false, rows: 4)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For light mode
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        
        
        // Do any additional setup after loading the view.
        loadClientManager()
        loadBankCateory()
        getTimes()
        
        propertySettingsTable.delegate = self
        propertySettingsTable.dataSource = self

    }
    
    func loadClientManager() {
        let nUrl = StaticUrls.BASE_URL_FINAL + "getclientmanager?lang=en&property_title=&slug=&property_id=130&userid=257&author_id=257"
        
        Alamofire.request(nUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                //                print(resultArray)
                for i in resultArray.arrayValue {
                    let manager = ClientManagerModel(json: i)
                    self.clientManagerArray.append(manager)
                }
                print(self.clientManagerArray)
                
                
            }
        }
    }
    
    func loadBankCateory() {
        let bUrl = StaticUrls.BASE_URL_FINAL + "getclientbank?lang=en&property_title=&slug=&property_id=130&userid=257&author_id=257"
                
                Alamofire.request(bUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
                    
                    if mysresponse.result.isSuccess {
                        let myResult = try? JSON(data: mysresponse.data!)
                        let resultArray = myResult!["data"]
                        
        //              print(resultArray)
                        for i in resultArray.arrayValue {
                            let bank = BankCategoryModel(json: i)
                            self.bankArray.append(bank)
                        }
        //                print(self.timeArray)
                        
                        
                    }
                }
        }
    
    func getTimes() {
        let tUrl = StaticUrls.BASE_URL_FINAL + "getLookUpByCat/88?lang=en&limit=20"
        
        Alamofire.request(tUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult![]
                
//              print(resultArray)
                for i in resultArray.arrayValue {
                    let time = TimeModel(json: i)
                    self.timeArray.append(time)
                }
//                print(self.timeArray)
                
                
            }
        }
    }
    
}



extension PropertySettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = Bundle.main.loadNibNamed("OwnerSettingHeaderCell", owner: self, options: nil)?.first as! OwnerSettingHeaderCell
        
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: propertySettingsTable.frame.size.width, height: 40))
//        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // Set your background color
//
//        let button = UIButton(type: .system)
//        button.frame = CGRect(x: 8, y: 2, width: propertySettingsTable.frame.size.width - 16, height: 36)
        
        //        let somespace: CGFloat = 10
        
        //          self.myButton.setImage(UIImage(named: "cross"), forState: UIControlState.Normal)
        //
        //          self.myButton.imageEdgeInsets = UIEdgeInsetsMake(0, self.myButton.frame.size.width - somespace , 0, 0)
        //
        //          print(self.myButton.imageView?.frame)
        //
        //          self.myButton.titleEdgeInsets = UIEdgeInsetsMake(0, (self.myButton.imageView?.frame.width)! + somespace, 0, 10 )
        
        //        button.contentHorizontalAlignment = .left
//        button.contentHorizontalAlignment = .leading
//        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        button.titleLabel?.textAlignment = .right
//        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
//        if #available(iOS 13.0, *) {
//            button.setImage(UIImage(systemName: "plus"), for: .normal)
//        } else {
//            // Fallback on earlier versions
//        }
//        button.semanticContentAttribute = UIApplication.shared
//            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        
        //        button.imageEdgeInsets = UIEdgeInsets(top: 0,left: button.bounds.width - 38, bottom: 0, right: 0)
        //        button.titleEdgeInsets = UIEdgeInsets(top: 0,left: -(button.imageView?.bounds.width)! + 8, bottom: 0, right: 0)
//        button.imageEdgeInsets.left = 8
//        button.titleEdgeInsets.left = 16
        
        headerCell.btnExpand.tag = section
        
        
        if section == 0 {
            //            button.setTitle("1. Conditions of Reservation", for: .normal)
            headerCell.lblHeaderTitle.text = "1. Conditions of Reservation"
        } else if section == 1 {
            //            button.setTitle("2. Cancellation and return policy", for: .normal)
            headerCell.lblHeaderTitle.text = "2. Cancellation and return policy"
        } else if section == 2 {
            //            button.setTitle("3. Entry and departure hours", for: .normal)
            headerCell.lblHeaderTitle.text = "3. Entry and departure hours"
        } else if section == 3 {
            //            button.setTitle("4. Book managers and messages SMS", for: .normal)
            headerCell.lblHeaderTitle.text = "4. Book managers and messages SMS"
        } else if section == 4 {
            //            button.setTitle("5. Banks", for: .normal)
            headerCell.lblHeaderTitle.text = "5. Banks"
        }
        
        headerCell.btnExpand.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        
        //        view.addSubview(button)
        
        return headerCell.contentView
    }
    
    @objc func handleExpandClose(button: UIButton) {
        print("Header Button Tapped \(button.tag)")
        
        let section = button.tag
        var indexPaths = [IndexPath]()
        
        
        let sectionStat = sectionArray[section].isExpanded
        sectionArray[section].isExpanded = !sectionStat
        
        if section == 0 || section == 1 || section == 2 {
            let indexPath = IndexPath(row: 0, section: section)
            indexPaths.append(indexPath)
        } else if section == 3 {
            for i in 0 ... (clientManagerArray.count + 2) {
                let indexPath = IndexPath(row: i, section: section)
                indexPaths.append(indexPath)
            }
        } else if section == 4 {
            for i in 0...(bankArray.count + 2) {
                let indexPath = IndexPath(row: i, section: section)
                indexPaths.append(indexPath)
            }
        } else {
            return
        }
        
        //        propertySettingsTable.reloadData()
        if sectionStat {
            propertySettingsTable.deleteRows(at: indexPaths, with: .fade)
        } else {
            propertySettingsTable.insertRows(at: indexPaths, with: .fade)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        if section == 0 {
            if sectionArray[section].isExpanded == true {
                rows = 1
            } else {
                rows = 0
            }
            return rows
            
        } else if section == 1 {
            
            if sectionArray[section].isExpanded == true{
                rows = 1
            } else {
                rows = 0
            }
            return rows
            
        } else if section == 2 {
            
            if sectionArray[section].isExpanded == true {
                rows = 1
            } else {
                rows = 0
            }
            return rows
            
        } else if section == 3{
            if sectionArray[section].isExpanded == true {
                rows = clientManagerArray.count + 3
            } else {
                rows = 0
            }
            return rows
        } else if section == 4{
            if sectionArray[section].isExpanded == true {
                rows = bankArray.count + 3
            } else {
                rows = 0
            }
            return rows
        } else {
            return rows
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        var cell: UITableViewCell?
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InsuranceTableViewCell", for: indexPath) as! InsuranceTableViewCell
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CancelationReturnTableViewCell", for: indexPath) as! CancelationReturnTableViewCell
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckInAndOutTableViewCell", for: indexPath) as! CheckInAndOutTableViewCell
            
            cell.setTimes(time: timeArray)
            
            return cell
        } else if indexPath.section == 3 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonTableViewCell", for: indexPath) as! AddButtonTableViewCell
                
                cell.index = indexPath
                cell.delegate = self as? AddNewDelegate
                
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookManagerTitleTableViewCell", for: indexPath) as! BookManagerTitleTableViewCell
                return cell
            } else if indexPath.row == clientManagerArray.count + 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookManagerDescTableViewCell", for: indexPath) as! BookManagerDescTableViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookManagerRowTableViewCell", for: indexPath) as! BookManagerRowTableViewCell
                
                if clientManagerArray.isEmpty != true {
                    cell.setManagers(managers: clientManagerArray[indexPath.row - 2] )
                }
                
                return cell
            }
            
            
            
        } else if indexPath.section == 4 {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonTableViewCell", for: indexPath) as! AddButtonTableViewCell
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BankTitleTableViewCell", for: indexPath) as! BankTitleTableViewCell
                return cell
            } else if indexPath.row == bankArray.count + 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BankDescAndButtonTableViewCell", for: indexPath) as! BankDescAndButtonTableViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BankRowTableViewCell", for: indexPath) as! BankRowTableViewCell
                return cell
            }
            
        }
        
        return UITableViewCell()
    }
    
    
}

extension PropertySettingsViewController: AddNewDelegate {
    func addNewBtnTapped(index: IndexPath) {
        if index.section == 3 {
            openAlert()
        }
    }
    
    func openAlert(){
        let alertController = UIAlertController(title: "Title", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter name"
        }
    
        let saveAction = UIAlertAction(title: "Confirm", style: .default, handler: { alert -> Void in
            if let textField = alertController.textFields?[0] {
                if textField.text!.count > 0 {
                    print("Text :: \(textField.text ?? "")")
                }
            }
        })
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
    
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
    
        alertController.preferredAction = saveAction
    
        self.present(alertController, animated: true, completion: nil)
    }

}

