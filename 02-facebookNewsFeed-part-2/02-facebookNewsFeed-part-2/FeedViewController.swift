//
//  ViewController.swift
//  02-facebookNewsFeed-part-2
//
//  Created by Andrews Frempong on 13/10/2017.
//  Copyright © 2017 Andrews Frempong. All rights reserved.
//part-2

import UIKit
import Foundation

class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Facebook Feed"
        
        
        collectionView?.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        
        collectionView?.register(CustomFeedCell.self, forCellWithReuseIdentifier: cellId)
        
    } //<!-- end view did load -->
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomFeedCell
        return cell
    }
    
    //size of cells
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 450)
    }
    

}//<!-- end FeedViewController -->

class CustomFeedCell: UICollectionViewCell {
    

    
    static func createButtonWithTitle (title: String, icon: UIImage) -> UIButton {
        let button = { () -> UIButton in
            let b = UIButton()
            b.setTitle(title, for: .normal)
            b.setImage(icon, for: .normal)
            b.setTitleColor(UIColor.gray, for: .normal)
            //b.backgroundColor = .red
            b.translatesAutoresizingMaskIntoConstraints = false
            
            b.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
            
            return b
        }()
        return button
    }
    
    let likeButton = CustomFeedCell.createButtonWithTitle(title: "Like", icon: #imageLiteral(resourceName: "like"))
    let commentsButton = CustomFeedCell.createButtonWithTitle(title: "Comments", icon: #imageLiteral(resourceName: "comment"))
    let shareButton = CustomFeedCell.createButtonWithTitle(title: "Share", icon: #imageLiteral(resourceName: "share"))
    
    let buttonsContainerView = { () -> UIView in
        
        let container = UIView()
        //container.backgroundColor = .red
//        container.layer.borderColor = UIColor.red.cgColor
//        container.layer.borderWidth = 1
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
        
    }()
    
    
    
    let profileImageImageView = { () -> UIImageView in
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30 //height/2; height is set to 60 below
        //remove un-necessary pixels
        imageView.layer.masksToBounds = true
        imageView.image = #imageLiteral(resourceName: "zuck")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let profileNameLabel = { () -> UILabel in
        
        let label = UILabel()
        //NSMutableAttributedString
        //NSAttributedString
        //NSAttributedStringKey
        label.numberOfLines = 2
        let attributedText = NSMutableAttributedString(string: "Mark Zuckerberg", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        attributedText.append(NSAttributedString(string: "\nDecember  18  •  San Francisco  •  ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        //Solution: paragraph spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedText.addAttributes([NSAttributedStringKey.paragraphStyle : paragraphStyle], range: NSMakeRange(0, attributedText.length))
        
        
        //solution image attachment
        let attachment = NSTextAttachment()
        attachment.image = #imageLiteral(resourceName: "globe")
        //set width and height
        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        attributedText.append(NSAttributedString(attachment: attachment))
        label.attributedText = attributedText
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let statusTextLabel = { () -> UILabel in
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "Meanwhile, Beast turned to the dark side", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        //make text expand based on content
        label.numberOfLines = 0
        label.attributedText = attributedText
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusImageImageView = { () -> UIImageView in
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "zuck-dog")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let likesAndCommentsLabel = { () -> UILabel in
        
        let label = UILabel()
        //label.backgroundColor = .green
        
        label.text = "400 Likes     10.7K Comments"
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textColor = UIColor.customRgb(r: 155, g: 161, b: 171)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dividerView = { () -> UIView in
        
        let v = UIView()
        v.backgroundColor = UIColor.customRgb(r: 226, g: 228, b: 232)
        //v.backgroundColor = .red
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
        
    }()
    
    //CREATE 3 BUTTON: LIKE, COMMENT, SHARE
    
    
    
    func setupViews() {
        
        //profile image
        addSubview(profileImageImageView)
        
        profileImageImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        profileImageImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        profileImageImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //profile name
        addSubview(profileNameLabel)
        
        profileNameLabel.leftAnchor.constraint(equalTo: profileImageImageView.rightAnchor, constant: 8).isActive = true
        profileNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        
        
        //status text
        
        addSubview(statusTextLabel)
        
        statusTextLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        statusTextLabel.topAnchor.constraint(equalTo: profileImageImageView.bottomAnchor, constant: 8).isActive = true
        
        
        //statusImageImageView
        
        addSubview(statusImageImageView)
        
        statusImageImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        statusImageImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        statusImageImageView.topAnchor.constraint(equalTo: statusTextLabel.bottomAnchor, constant: 8).isActive = true
            //create space below image
        statusImageImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80).isActive = true
        
        
        
        //likesAndCommentsLabel
        addSubview(likesAndCommentsLabel)
        
        likesAndCommentsLabel.topAnchor.constraint(equalTo: statusImageImageView.bottomAnchor, constant: 4).isActive = true
        likesAndCommentsLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        likesAndCommentsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //dividerView
        addSubview(dividerView)
        
        dividerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        dividerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        dividerView.topAnchor.constraint(equalTo: likesAndCommentsLabel.bottomAnchor, constant: 4 ).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
        
        //buttonsContainerView
        
        addSubview(buttonsContainerView)
        buttonsContainerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        buttonsContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        buttonsContainerView.widthAnchor.constraint(equalTo: widthAnchor, constant: 0).isActive = true
        buttonsContainerView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 4).isActive = true
        buttonsContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        buttonsContainerView.addSubview(likeButton)
        buttonsContainerView.addSubview(commentsButton)
        buttonsContainerView.addSubview(shareButton)
        //like button
        
        likeButton.leftAnchor.constraint(equalTo: buttonsContainerView.leftAnchor, constant: 0).isActive = true
        likeButton.topAnchor.constraint(equalTo: buttonsContainerView.topAnchor, constant: 0).isActive = true
        //likeButton.heightAnchor.constraint(equalToConstant: NSLayoutDimension(buttonsContainerView.heightAnchor))
        let oneThirdScreen = self.frame.size.width/CGFloat(3)
        likeButton.bottomAnchor.constraint(equalTo: buttonsContainerView.bottomAnchor, constant: 0).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant:oneThirdScreen ).isActive = true
        
        
        //comments button
        
        commentsButton.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: 0).isActive = true
        commentsButton.topAnchor.constraint(equalTo: buttonsContainerView.topAnchor, constant: 0).isActive = true
        commentsButton.bottomAnchor.constraint(equalTo: buttonsContainerView.bottomAnchor, constant: 0).isActive = true
        commentsButton.widthAnchor.constraint(equalToConstant:oneThirdScreen ).isActive = true
        
        //share button
        
        shareButton.leftAnchor.constraint(equalTo: commentsButton.rightAnchor, constant: 0).isActive = true
        shareButton.topAnchor.constraint(equalTo: buttonsContainerView.topAnchor, constant: 0).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: buttonsContainerView.bottomAnchor, constant: 0).isActive = true
//        commentsButton.widthAnchor.constraint(equalToConstant:oneThirdScreen ).isActive = true
        shareButton.rightAnchor.constraint(equalTo: buttonsContainerView.rightAnchor, constant: 0).isActive = true
        
    }// <!-- End of setupViews-->
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




























































