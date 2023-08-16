//
//  ViewController.swift
//  Registration Form Assignment
//
//  Created by Neosoft1 on 28/07/23.
//

import UIKit

//MARK: - ViewController
class RegistrationVC: UIViewController ,UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: - IBOutlets
    // Views for Border
    @IBOutlet var containerViews: [UIView]!
    
    //TextFields
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfPhoneNo: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var tfEducation: UITextField!
    @IBOutlet weak var tfDOB: UITextField!
    
    // Button
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var maleRadio: UIButton!
    @IBOutlet weak var femaleRadio: UIButton!
    
    // View
    @IBOutlet weak var viewDOB: UIView!
    @IBOutlet weak var viewEducation: UIView!

    //DatePicker
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //PickerView
    @IBOutlet weak var pickerView: UIPickerView!
    
    //Education Enum
    enum Educations: String, CaseIterable{
        case PostGraduate = "Post Graduate"
        case Graduate = "Graduate"
        case HSCDiploma = "HSC/Diploma"
        case SSC = "SSC"
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setInitDelegates()
        setDateSelector()
        setEducationSelector()
        setUI()
        
    }
    
    //MARK: - Setup Functions
    func setUI(){
        
        //Views Border
        for v in containerViews{
            v.layer.borderWidth = 1
            v.layer.borderColor = UIColor.black.cgColor
        }
        
        //Radio Buttons
        maleRadio.setImage(UIImage(systemName: "circle"), for: .normal)
        maleRadio.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        femaleRadio.setImage(UIImage(systemName: "circle"), for: .normal)
        femaleRadio.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        
    }
    
    func setInitDelegates(){
        
        //TextFields
        tfFirstName.becomeFirstResponder()
        tfFirstName.delegate = self
        tfLastName.delegate = self
        tfPhoneNo.delegate = self
        tfEmail.delegate = self
        tfPassword.delegate = self
        tfConfirmPassword.delegate = self
        tfEducation.delegate = self
        tfDOB.delegate = self
        
        //PickerView
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    func setDateSelector(){
        
        let dateSelector = UITapGestureRecognizer(target: self, action: #selector(dateSelection(sender:)))
        viewDOB.isUserInteractionEnabled = true
        viewDOB.addGestureRecognizer(dateSelector)
        
    }
    
    func setEducationSelector(){
        
        let educationSelector = UITapGestureRecognizer(target: self, action: #selector(educationSelection(sender:)))
        viewEducation.isUserInteractionEnabled = true
        viewEducation.addGestureRecognizer(educationSelector)
        
    }
    
    //MARK: - @objc Functions
    @objc func dateSelection(sender: UITapGestureRecognizer) {
        
        datePicker.maximumDate = Date()
        datePicker.contentHorizontalAlignment = .left
        datePicker.isHidden = false
        datePicker.preferredDatePickerStyle = .inline
        print("date Picker")
        
    }
    
    @objc func educationSelection(sender: UITapGestureRecognizer) {
        
        tfEducation.text = tfEducation.text == "" ? "Select One" : tfEducation.text
        pickerView.isHidden = false
        
    }
    
    //MARK: - PickerView Datasource Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Educations.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Educations.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let education = Educations.allCases
        tfEducation.text = education[row].rawValue
        pickerView.isHidden = true
    }
    
    //MARK: - IBActions
    @IBAction func dateChange(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        self.tfDOB.text = dateFormatter.string(from: datePicker.date)
        datePicker.isHidden = true
    }
    
    @IBAction func radioTapped(_ sender: UIButton) {
        if sender == maleRadio{
            maleRadio.isSelected = true
            femaleRadio.isSelected = false
        }
        else{
            maleRadio.isSelected = false
            femaleRadio.isSelected = true
        }
    }
    
    //MARK: - Submit Button Validations
    @IBAction func submitTapped(_ sender: UIButton) {
        if(tfFirstName.text?.isEmpty ?? false || tfLastName.text?.isEmpty ?? false || tfPhoneNo.text?.isEmpty ?? false || tfEmail.text?.isEmpty ?? false || tfPassword.text?.isEmpty ?? false || tfConfirmPassword.text?.isEmpty ?? false || tfEducation.text?.isEmpty ?? false || tfDOB.text?.isEmpty ?? false || !(maleRadio.isSelected || femaleRadio.isSelected)) {
            alertmsg(msg: "Please fill all the details")
        }
        else{
            
            //First Name Validation
            if  let verifyText = tfFirstName.text{
                
                if verifyText.count < 3{
                    alertmsg(msg: "First Name should be 3 charactors")
                }
            }
            
            //Last Name Validation
            if let verifyText = tfLastName.text{
                
                if verifyText.count < 3{
                    alertmsg(msg: "Last Name should be 3 charactors")
                }
            }
            
            //Email Validation
            if let verifyText = tfEmail.text{
                
                if verifyText.count < 3{
                    alertmsg(msg: "Email Should Contain Atleast 3 letters")
                }
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
                
                if !emailPredicate.evaluate(with: verifyText) {
                    alertmsg(msg: "Not Followed Standard Email Requirements")
                }
                
            }
            
            //Password Validation
            if let verifyText = tfPassword.text{
                
                
                if verifyText.count < 8{
                    alertmsg(msg: "Password Should Contain Atleast 3 letters")
                }
                
                var containsNumber = false
                for character in verifyText {
                    if character.isWholeNumber {
                        containsNumber = true
                        break
                    }
                }
                if !containsNumber {
                    alertmsg(msg: "Password Should Contain atleast one Number")
                }
                
                var containsSpecialCharacter = false
                let specialCharacters = ["@", "#", "%", "*", "(", ")", "<", ">", "/", "|", "{", "~", "?"]
                for character in verifyText {
                    if specialCharacters.contains(String(character)) {
                        containsSpecialCharacter = true
                        break
                    }
                }
                if !containsSpecialCharacter {
                    alertmsg(msg: "Password Should Contain atleast one Special Charactor")
                }
            }
            
            //Confirm Password Validation
            if let verifyText = tfConfirmPassword.text{
                
                if verifyText != tfPassword.text{
                    alertmsg(msg: "Confirm Password Should be same as Password")
                }
                
            }
            
            // Printing Data
            print(tfFirstName.text)
            print(tfLastName.text)
            print(tfPhoneNo.text)
            print(tfEmail.text)
            print(maleRadio.isSelected ? "male" : "female")
            print(tfPassword.text)
            print(tfConfirmPassword.text)
            print(tfEducation.text)
            print(tfDOB.text)
            
            alertmsg(msg: "Registered Successfully")
        }
    }
    
    //Alert msg Function
    func alertmsg(msg:String){
        
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
}

//MARK: - TextField Delegate
extension RegistrationVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == tfPhoneNo){
            
            let currrentCharacterCount = textField.text?.count ?? 0
            let newLength = currrentCharacterCount + string.count - range.length
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            if newLength > 10{
                return false
            }
            if range.length + range.location > currrentCharacterCount {
                return false
            }
            for character in newText {
                if character.isLetter {
                    textField.text = ""
                    alertmsg(msg: "Phone Number only expects Numbers")
                    return false
                }
            }
            
            return true
        }
        else if(textField == tfFirstName){
            for character in textField.text ?? "" {
                if !character.isLetter {
                    textField.text = ""
                    alertmsg(msg: "First Name only expects Charactors")
                    return false
                }
            }
            return true
        }
        else if(textField == tfLastName){
            
            for character in textField.text ?? "" {
                if !character.isLetter {
                    textField.text = ""
                    alertmsg(msg: "Last Name only expects Charactors")
                    return false
                }
            }
            return true
        }
        return true
    }
}
