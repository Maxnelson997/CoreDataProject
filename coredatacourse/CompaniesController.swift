//
//  ViewController.swift
//  coredatacourse
//
//  Created by Max Nelson on 1/5/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController, CreateCompanyControllerDelegate {
    
    var cellId:String = "cellId"
    var companies = [Company]()
    
    func didAddCompany(company: Company) {
        companies.append(company)
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    private func fetchCompanies() {
        //attempt core data fetch
        let persistentContainer = NSPersistentContainer(name: "IntermediateTraining")
        persistentContainer.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("loading of store failed: \(err)")
            }
        }
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            companies.forEach({ (company) in
                print(company.name ?? "")
            })
            self.companies = companies
            self.tableView.reloadData()
        } catch let error {
            print("faailed to fetch companies from core data:",error)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCompanies()
        tableView.backgroundColor = UIColor.darkBlue
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorColor = .white
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.handleAddCompany))
    }
    
    @objc func handleAddCompany() {
        print("adding company")
        
        let createCompanyController = CreateCompanyController()
        let navController = CustomNavigationController(rootViewController: createCompanyController)
        createCompanyController.delegate = self
        present(navController, animated: true  , completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .tealColor
        let company = companies[indexPath.row]
        cell.textLabel?.text = company.name
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
}

