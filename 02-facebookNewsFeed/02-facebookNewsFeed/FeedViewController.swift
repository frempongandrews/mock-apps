//
//  ViewController.swift
//  02-facebookNewsFeed
//
//  Created by Andrews Frempong on 11/10/2017.
//  Copyright © 2017 Andrews Frempong. All rights reserved.
//

import UIKit

class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView?.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        navigationItem.title = "Facebook"
        collectionView?.alwaysBounceVertical = true
        
        //register cell
        
        collectionView?.register(CustomCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomCell
        //cell.backgroundColor = .white
        
        return cell
    }
    //<!-- size of individual items-->
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Look dimensions of profileImageImageView: 76 = 60 + top(8) + bottom(8)
        return CGSize(width: view.frame.width, height: 500)
    }
    
    
    
    
    
}//<!-- End of FeedController -->



//<!---------------------------------CustomCollectionCell-------------------------------------------------------->

class CustomCell: UICollectionViewCell {
    
    //runs immediately
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let profileImageImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "zuck")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    let profileNameLabel: UILabel = {
       let label = UILabel()
        //label.backgroundColor = .yellow
        label.numberOfLines = 2
        let attributedText = NSMutableAttributedString(string: "Mark Zuckerberg", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.append(NSAttributedString(string: "\nDecember 18  • San Francisco •  ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)]))
        
        
        
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
        
        //globe image
        
        let attachment = NSTextAttachment()
        attachment.image = #imageLiteral(resourceName: "globe")
        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        attributedText.append(NSAttributedString(attachment: attachment))
        
        
        label.attributedText = attributedText
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //status text
    
    let statusTextLabel = { () -> UILabel in
        let label = UILabel()
        //to let it expand as its content
        label.numberOfLines = 0
        let attributedText = NSMutableAttributedString(string: "Meanwhile, Beast turned to the dark side", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.attributedText = attributedText
        return label
    }()
    
    //status image
    
    let profileStatusImageView = { () -> UIImageView in
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "zuck-dog")
        imageView.contentMode = .scaleToFill
        //remove pixels that we don't want
        imageView.layer.masksToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    func setupViews () {
       
        //profileImageImageView
        addSubview(profileImageImageView)
        
        
        
        profileImageImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        profileImageImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        //================> remove bottom constraint or change priority when cell height changes
        let profileImagebottomConstraint = profileImageImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        profileImagebottomConstraint.isActive = true
        profileImagebottomConstraint.priority = UILayoutPriority(1)
        //================> end remove bottom constraint
        
        profileImageImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            //make image rounded
        profileImageImageView.layer.cornerRadius = 30
        profileImageImageView.layer.masksToBounds = true
        
        
        //profileTextLabel
        addSubview(profileNameLabel)
        
        profileNameLabel.leftAnchor.constraint(equalTo: profileImageImageView.rightAnchor, constant: 8).isActive = true
        profileNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14).isActive = true
        profileNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        //profileNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        
        //status text
        
        addSubview(statusTextLabel)
        
        statusTextLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        //================> Higher priority than bottom constraint of profile image if cell height changes
        let statusTextLabelConstraint = statusTextLabel.topAnchor.constraint(equalTo: profileImageImageView.bottomAnchor, constant: 8)
        statusTextLabelConstraint.isActive = true
        statusTextLabelConstraint.priority = UILayoutPriority(10)
        
        statusTextLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = true
        
        
        //status image
        
        addSubview(profileStatusImageView)
        
        profileStatusImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        profileStatusImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        profileStatusImageView.topAnchor.constraint(equalTo: statusTextLabel.bottomAnchor, constant: 10).isActive = true
        
    }
}















































