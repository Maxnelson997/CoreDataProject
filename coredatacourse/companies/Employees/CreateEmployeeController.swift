//
//  CreateEmployeeController.swift
//  coredatacourse
//
//  Created by Max Nelson on 1/22/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

protocol CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee)
}

class CreateEmployeeController: UIViewController {
    
    var company: Company?
    
    var delegate: CreateEmployeeControllerDelegate?
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Employee name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let birthdayLabel:UILabel = {
        let label = UILabel()
        label.text = "Birthday"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let birthdayTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "MM/dd/yyyy"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlue
        navigationItem.title = "Add Employee"
        setupCancelButton()
        rightButton(title: "save", selector: #selector(handleSave))
        
        setupUI()
    }
    
    func setupUI() {
        _ = setupLightBlueBackgroundView(height: 100)
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        
        view.addSubview(birthdayLabel)
        birthdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        birthdayLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        birthdayLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        birthdayLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(birthdayTextField)
        birthdayTextField.leftAnchor.constraint(equalTo: birthdayLabel.rightAnchor).isActive = true
        birthdayTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        birthdayTextField.bottomAnchor.constraint(equalTo: birthdayLabel.bottomAnchor).isActive = true
        birthdayTextField.topAnchor.constraint(equalTo: birthdayLabel.topAnchor).isActive = true
    }
    

    
    @objc func handleSave() {
        guard let empName = nameTextField.text else { return }
        guard let company = company else { return }
        
        guard let birthdayText = birthdayTextField.text else { return }
    
        if birthdayText.isEmpty {
            view.showError(title: "Day of birth empty", message: "Enter that junk ASAP.")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        guard let birthdayDate = dateFormatter.date(from: birthdayText) else {
            view.showError(title: "Garbage Date", message: "You ever learn to format a date properly, boi?")
            return
        }
        
        let tuple = CoreDataManager.shared.createEmployee(name: empName, birthday: birthdayDate, company: company)
        if let err = tuple.1 {
            //tell dat user wtf is up.
            print(err)
        } else if let emp = tuple.0 {
            //save
            dismiss(animated: true, completion: {
                self.delegate?.didAddEmployee(employee: emp)
            })
        }
    }
    

}
