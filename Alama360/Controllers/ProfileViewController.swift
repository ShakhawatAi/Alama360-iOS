//
//  ProfileViewController.swift
//  Alama360
//
//  Created by Alama360 on 16/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var maritalStatus: UITextField!
    @IBOutlet weak var selectCountry: UITextField!
    @IBOutlet weak var selectState: UITextField!
    @IBOutlet weak var selectCity: UITextField!
    @IBOutlet weak var selectDistrict: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTextFields()
        
    }
    
    func setTextFields() {
        
        firstName.setIcon(#imageLiteral(resourceName: "ic_first_name"))
        lastName.setIcon(#imageLiteral(resourceName: "ic_last_name"))
        emailAddress.setIcon(#imageLiteral(resourceName: "ic_email"))
        phoneNumber.setIcon(#imageLiteral(resourceName: "ic_phone_2"))
        dateOfBirth.setIcon(#imageLiteral(resourceName: "ic_dob"))
        maritalStatus.setIcon(#imageLiteral(resourceName: "ic_marit"))
        selectCountry.setIcon(#imageLiteral(resourceName: "ic_country_2"))
        selectState.setIcon(#imageLiteral(resourceName: "ic_state"))
        selectCity.setIcon(#imageLiteral(resourceName: "ic_city"))
        selectDistrict.setIcon(#imageLiteral(resourceName: "ic_district"))
        
    }

}

extension UITextField {
func setIcon(_ image: UIImage) {
   let iconView = UIImageView(frame:
                  CGRect(x: 10, y: 5, width: 20, height: 20))
   iconView.image = image
   let iconContainerView: UIView = UIView(frame:
                  CGRect(x: 20, y: 0, width: 30, height: 30))
   iconContainerView.addSubview(iconView)
   leftView = iconContainerView
   leftViewMode = .always
}
}