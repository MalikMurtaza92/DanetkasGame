//
//  ProfileViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 05/11/2021.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var DOBTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var nationalityTextField: UITextField!
    
    @IBOutlet weak var getStartedButton: UIButton!
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    //MARK:- PROPERTIES
    
    //MARK:- PROPERTIES
    lazy var viewModel: ProfileViewModel = {
        return ProfileViewModel(viewController: self)
    }()
    
    let GenderPicker = UIPickerView()
    let NationalityPicker = UIPickerView()
    let DOBPicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        getStartedButton.layer.cornerRadius = getStartedButton.frame.size.height / 2
        scrollViewHeight.constant = safeArea().height
    }
    
    func setupUI() {
        
        GenderPicker.delegate = self
        GenderPicker.dataSource = self
        
        NationalityPicker.delegate = self
        NationalityPicker.dataSource = self
        
        DOBPicker.datePickerMode = .date
        DOBPicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        if #available(iOS 13.4, *) {
            DOBPicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        genderTextField.inputView = GenderPicker
        nationalityTextField.inputView = NationalityPicker
        DOBTextField.inputView = DOBPicker

    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        DOBTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func getStartedButtonPressed(_ sender: UIButton) {
        
        guard nameTextField.text != "" else {
            self.showSimpleAlert(title: Constant.title, message: "Please Enter Name.")
            return
        }
        
        guard userNameTextField.text != "" else {
            self.showSimpleAlert(title: Constant.title, message: "Please Enter Username.")
            return
        }
        
        guard DOBTextField.text != "" else {
            self.showSimpleAlert(title: Constant.title, message: "Please Enter Date of Birth.")
            return
        }
        
        guard genderTextField.text != "" else {
            self.showSimpleAlert(title: Constant.title, message: "Please Enter Gender.")
            return
        }
        
        guard nationalityTextField.text != "" else {
            self.showSimpleAlert(title: Constant.title, message: "Please Enter Nationality.")
            return
        }
        
        let params = ["name": nameTextField.text ?? "",
                      "userName": userNameTextField.text ?? "",
                      "dateOfBirth": DOBTextField.text ?? "",
                      "gender": genderTextField.text ?? "",
                      "nationality": nationalityTextField.text ?? "",
                      "email": Utility.shared.user?.email ?? ""]
                        
        
        showProgress()
        viewModel.setupUserProfile(parameters: params) { user, error in
            self.hideProgress()
            if error == nil {
                Utility.shared.user?.isProfileSet = true
                self.popToRoot()
            } else {
                Utility.shared.user?.isProfileSet = false
                self.showSimpleAlert(title: Constant.title, message: error?.localizedDescription ?? "")
            }
        }
        
    }

}

//MARK:- PICKERVIEW DELEGATE DATASOURCE
extension ProfileViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == GenderPicker {
            return 1
        } else if pickerView == NationalityPicker {
            return 1
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == GenderPicker {
            return Constant.Gender.count
        } else if pickerView == NationalityPicker {
            return Constant.Nationality.count
        }
        return 0
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == GenderPicker {
            return Constant.Gender[row]
        } else if pickerView == NationalityPicker {
            return Constant.Nationality[row]
        }
        return ""
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == GenderPicker {
            genderTextField.text =  Constant.Gender[row]
        } else if pickerView == NationalityPicker {
            nationalityTextField.text = Constant.Nationality[row]
        }
    }
}
