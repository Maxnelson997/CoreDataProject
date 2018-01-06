//
//  CreateCompanyController.swift
//  coredatacourse
//
//  Created by Max Nelson on 1/5/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyControllerDelegate {
    func didAddCompany(company: Company)
}

class CreateCompanyController: UIViewController {
    
    // not tightly-coupled
    var delegate: CreateCompanyControllerDelegate?
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "swag"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightBlue
        setupUI()

        navigationItem.title = "create company"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.handleSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.handleCancel))
    }
    
    fileprivate func setupUI() {
        
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightBlueBackgroundView)
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
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
    }
    
    @objc func handleSave() {
        //put in context
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        
        guard let nameText = nameTextField.text, nameText.count > 0 else { return }
        company.setValue(nameText, forKey: "name")
        
        //perform the save
        do {
            try context.save()
            //successfuly saved to coredata
            dismiss(animated: true) {
                self.delegate?.didAddCompany(company: company as! Company)
            }
        } catch let error {
            print("failed to save company context in coredata:",error)
        }


    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
}
