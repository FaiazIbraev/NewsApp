//
//  MainViewController.swift
//  NewsApp
//
//  Created by Student on 2/8/22.
//

import UIKit

class MainViewController: UIViewController{
    
    private lazy var mainLabel:UILabel = {
        let label = UILabel ()
        label.text = "Text"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    private lazy var searchTextField:UITextField = {
       let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 24, weight: .black)
        tf.placeholder = "Type a keyword"
        tf.textAlignment = .center
        tf.backgroundColor = .lightGray
        tf.delegate = self
        
        
        return tf
    }()
    
    private lazy var  mainTableView : UITableView = {
        let tv = UITableView()
        
        tv.dataSource = self
        tv.delegate = self
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        mainLabelSetup()
      searchTextFieldSetup()
        mainTableViewSetup()
    }
    
    func mainLabelSetup(){
        view.addSubview(mainLabel)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        let mainLabelConstraints = [
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(mainLabelConstraints)
    }
    
    func searchTextFieldSetup(){
    
        view.addSubview(searchTextField)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let tfConstraints = [
            searchTextField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 60)
        ]
        NSLayoutConstraint.activate(tfConstraints)
    }
    
    func mainTableViewSetup(){
        view.addSubview(mainTableView)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        let contraints = [
            mainTableView.topAnchor.constraint(equalTo: searchTextField.topAnchor, constant: 20),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(contraints)
    }
    
}

extension MainViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    
}

extension MainViewController:UITextFieldDelegate{
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
