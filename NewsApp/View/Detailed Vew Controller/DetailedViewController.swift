//
//  DetailedViewController.swift
//  NewsApp
//
//  Created by Student on 6/8/22.
//

import UIKit

class DetailedViewController: UIViewController {

    private lazy var mainTitle:UILabel = {
        let label = UILabel ()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subTitle:UILabel = {
        let label = UILabel ()
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    
    private lazy var textView:UITextView = {
       let tv = UITextView()
        tv.isEditable = false
        tv.textAlignment = .left
        tv.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        tv.textColor = .black
        tv.backgroundColor = .gray
        return tv
    }()
    
    private lazy var imageView:UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 10
        
        return image
    }()
    
    var article: Article?
    let imageDownloader = ImageManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        mainLabelSetup()
        subLabelSetup()
        textViewSetup()
        imageViewSetup()
        initialSetup()
 
        if let article = article {
            print(article)
        }
    }
    
    func mainLabelSetup(){
        view.addSubview(mainTitle)
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func subLabelSetup(){
        view.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            subTitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 20),
            subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func textViewSetup(){
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            textView.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -220)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func imageViewSetup(){
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func initialSetup(){
        mainTitle.text = article?.author
        subTitle.text = article?.title
        textView.text = article?.content
        
        if let urlImage = article?.urlToImage{
            imageDownloader.createRequest(urlString: urlImage) { [weak self] (data) in
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            }
        }
        
        

    }
    
}
