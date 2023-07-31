//
//  ViewController.swift
//  Registration Form Assignment
//
//  Created by Neosoft1 on 28/07/23.
//

import UIKit

class RegistrationVC: UIViewController ,UIPickerViewDataSource, UIPickerViewDelegate {
  
    
    
        
    

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
    
    @IBOutlet weak var viewDOB: UIView!
    @IBOutlet weak var viewEducation: UIView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    
    enum Educations: String, CaseIterable{
        case PostGraduate = "Post Graduate"
        case Graduate = "Graduate"
        case HSCDiploma = "HSC/Diploma"
        case SSC = "SSC"
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setInitDelegates()
        
        for v in containerViews{
            v.layer.borderWidth = 1
            v.layer.borderColor = UIColor.black.cgColor
        }
        
        let dateSelector = UITapGestureRecognizer(target: self, action: #selector(dateSelection(sender:)))
        viewDOB.isUserInteractionEnabled = true
        viewDOB.addGestureRecognizer(dateSelector)
        
        let educationSelector = UITapGestureRecognizer(target: self, action: #selector(educationSelection(sender:)))
        viewEducation.isUserInteractionEnabled = true
        viewEducation.addGestureRecognizer(educationSelector)
        
        
        maleRadio.setImage(UIImage(systemName: "circle"), for: .normal)
        maleRadio.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        femaleRadio.setImage(UIImage(systemName: "circle"), for: .normal)
        femaleRadio.setImage(UIImage(systemName: "circle.fill"), for: .selected)
    }
    
    func setInitDelegates(){
        tfFirstName.becomeFirstResponder()
        tfFirstName.delegate = self
        tfLastName.delegate = self
        tfPhoneNo.delegate = self
        tfEmail.delegate = self
        tfPassword.delegate = self
        tfConfirmPassword.delegate = self
        tfEducation.delegate = self
        tfDOB.delegate = self
        
        pickerView.dataSource = self
        pickerView.delegate = self
     }
    
    
    
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
//        print("The selected education is \(education)")
    }
    
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
    
    @IBAction func submitTapped(_ sender: UIButton) {
        if(tfFirstName.text?.isEmpty ?? false || tfLastName.text?.isEmpty ?? false || tfPhoneNo.text?.isEmpty ?? false || tfEmail.text?.isEmpty ?? false || tfPassword.text?.isEmpty ?? false || tfConfirmPassword.text?.isEmpty ?? false || tfEducation.text?.isEmpty ?? false || tfDOB.text?.isEmpty ?? false || (!maleRadio.isSelected && !femaleRadio.isSelected)) {
            alertmsg(msg: "Please fill all the details")
              }
              else{
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
    func alertmsg(msg:String){
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    }
    
extension RegistrationVC: UITextFieldDelegate {
      
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == tfPhoneNo){
            let currrentCharacterCount = textField.text?.count ?? 0
            if range.length + range.location > currrentCharacterCount {
                return false
            }
            for character in textField.text ?? "" {
                if character.isLetter {
                    textField.text = ""
                    alertmsg(msg: "Phone Number only expects Numbers")
                        return false
                    }
            }
            let newLength = currrentCharacterCount + string.count - range.length
            return newLength <= 10
        }
        else if(textField == tfFirstName){

            for character in textField.text ?? "" {
                if !character.isLetter {
                        return false
                    }
            }
            return textField.text?.count ?? 0 < 3
        }
//        else if(textField == tfLastName){
//
//            for character in textField.text ?? "" {
//                if !character.isLetter {
//                        return false
//                    }
//            }
//            return textField.text?.count ?? 0 < 3
//        }
//        else if(textField == tfEmail){
//            let currentText = textField.text ?? ""
//            let newText = currentText + string
//
//            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
//
//            if !emailPredicate.evaluate(with: newText) {
//                return false
//            }
//
//            return newText.count > 3
//        }
//        else if(textField == tfPassword){
//            let currentText = textField.text ?? ""
//            let newText = currentText + string
//
//            var containsNumber = false
//            for character in newText {
//                if character.isWholeNumber {
//                    containsNumber = true
//                    break
//                }
//            }
//            if !containsNumber {
//                return false
//            }
//
//            var containsSpecialCharacter = false
//            let specialCharacters = ["@", "#", "%", "*", "(", ")", "<", ">", "/", "|", "{", "~", "?"]
//            for character in newText {
//            if specialCharacters.contains(String(character)) {
//            containsSpecialCharacter = true
//            break
//            }
//            }
//            if !containsSpecialCharacter {
//            return false
//            }
//            return newText.count > 8
//        }
//        else if (textField == tfConfirmPassword){
//            return tfConfirmPassword.text == tfPassword.text
//        }
//        else{
//        return true
//        }
        return true
    }
}
