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
        label.text = "Путешествуйте"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subMainLabel:UILabel = {
        let subLabel = UILabel ()
        subLabel.text = "Почувствуйте прилив энергии"
        subLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        subLabel.textAlignment = .center
        
        return subLabel
    }()
    
    private lazy var detailLabel:UILabel = {
        let detailLabel = UILabel ()
        detailLabel.text = "Мы поможем вам исследовать, сравнить и забронировать впечатления - все в одном месте."
        detailLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        detailLabel.textAlignment = .center
        detailLabel.numberOfLines = 0
        
        return detailLabel
    }()
    
    private lazy var searchTextField:UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Куда хотите поехать?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
        tf.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        tf.textAlignment = .left
        tf.backgroundColor = .clear
        tf.delegate = self
        
        
        tf.layer.cornerRadius = 5
        tf.layer.borderColor = UIColor(red: 0.762, green: 0.762, blue: 0.762, alpha: 1).cgColor
        tf.layer.borderWidth = 0.5
        
        return tf
    }()
    
    let searchImage = UIImageView(image: UIImage(named: "search")!)
    
    
    private lazy var  mainTableView : UITableView = {
        let tv = UITableView()
        
        tv.dataSource = self
        tv.delegate = self
        tv.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tv.rowHeight = 230
        tv.separatorStyle = .none
        
        return tv
    }()
    
    var newsNetworkManager = NewsNetworkManager.shared
    var newsData: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mainLabelSetup()
        subLabelSetup()
        detailLabelSetup()
        searchTextFieldSetup()
        mainTableViewSetup()
        searchImageSetup()
        newsNetworkManager.newsDelegate = self
        
    }
    
    func mainLabelSetup(){
        view.addSubview(mainLabel)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        let mainLabelConstraints = [
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 58),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(mainLabelConstraints)
    }
    
    func subLabelSetup(){
        view.addSubview(subMainLabel)
        
        subMainLabel.translatesAutoresizingMaskIntoConstraints = false
        let subMainLabelConstraints = [
            subMainLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 0),
            subMainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(subMainLabelConstraints)
    }
    
    func detailLabelSetup(){
        view.addSubview(detailLabel)
        
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        let detailLabelConstraints = [
            detailLabel.topAnchor.constraint(equalTo: subMainLabel.bottomAnchor, constant: 11),
            detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            detailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
            detailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(detailLabelConstraints)
    }
    
    func searchTextFieldSetup(){
        
        view.addSubview(searchTextField)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let tfConstraints = [
            searchTextField.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 60)
        ]
        NSLayoutConstraint.activate(tfConstraints)
    }
    
    func searchImageSetup(){
        searchTextField.addSubview(searchImage)
        searchImage.translatesAutoresizingMaskIntoConstraints = false
        
        let imageConstraints = [
            searchImage.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: -15),
            searchImage.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            searchImage.heightAnchor.constraint(equalToConstant: 24),
            searchImage.widthAnchor.constraint(equalToConstant: 24)
            
        ]
        NSLayoutConstraint.activate(imageConstraints)
    }
    
    func mainTableViewSetup(){
        view.addSubview(mainTableView)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        let contraints = [
            mainTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 27),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(contraints)
    }
    
}

extension MainViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        let article = newsData[indexPath.row]
        
        cell.setup(article: article)
        
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        
        cell.mainImageView.image = UIImage(named: "photo1")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let article = newsData[indexPath.row]
        
        let vc = DetailedViewController()
        vc.article = article
        present(vc, animated: true)
    }
    
    
}

extension MainViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text{
            newsNetworkManager.getNews(keyWord: text, language: "en")
        }
        
        return true
    }
}

extension MainViewController: NewsNetworkDelegate{
    func fetchNews(news: NewsModelAPI) {
        self.newsData = news.articles
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
    
    func errorFetchingNews(error: Error) {
        print(error)
    }
    
    
}
