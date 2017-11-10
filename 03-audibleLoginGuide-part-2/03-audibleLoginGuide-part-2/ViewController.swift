//
//  ViewController.swift
//  03-audibleLoginGuide-part-2
//
//  Created by Andrews Frempong on 10/11/2017.
//  Copyright © 2017 Andrews Frempong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cell"
    lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        
        //to make ViewController the datasource
        cv.delegate = self
        cv.dataSource = self
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    func setupView () {
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .red
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
    //from UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //register cell
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        
        setupView()
        
    }

}//end ViewController

//<!-----------PageCell------------->

class PageCell: UICollectionViewCell {
    
    let pageImageView: UIImageView = {
        let iv = UIImageView()
        
        iv.image = #imageLiteral(resourceName: "page1")
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    func setupCell () {
        
        addSubview(pageImageView)
        
        pageImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        pageImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        pageImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        pageImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

























