//
//  SinglePostCell.swift
//  02-facebookNewsFeed-part-4
//
//  Created by Andrews Frempong on 22/10/2017.
//  Copyright © 2017 Andrews Frempong. All rights reserved.
//

import UIKit

class SinglePostCell: UICollectionViewCell {
    
    
    
    var post: Post? {
        didSet {
            profileImageView.image = post?.profileImage
            
            
        }
    }
    
    let profileImageView = { () -> UIImageView in
        
        let imageView = UIImageView()
        
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30 //half of height
        imageView.layer.masksToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    let profileNameLabel = { () -> UILabel in
        
        let label = UILabel()
        
//        label.backgroundColor = .red
        label.numberOfLines = 2
        
        let attributedText = NSMutableAttributedString(string: "Mark Zuckerberg", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        
        attributedText.append(NSAttributedString(string: "\nDecember 18 · San Francisco · " , attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)]))
        
        //paragraph space
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        
        //globe image
        
        let attachment = NSTextAttachment()
        attachment.image = #imageLiteral(resourceName: "globe")
        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        
        attributedText.append(NSAttributedString(attachment: attachment))
        
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let statusTextLabel = { () -> UILabel in
        
        let label = UILabel()
        label.text = "Meanwhile, Beast turns to the dark side"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let statusImageView = { () -> UIImageView in
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "zuck-dog")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dividerView = { () -> UIView in
        
        let div = UIView()
        div.backgroundColor = .gray
        div.translatesAutoresizingMaskIntoConstraints = false
        return div
    }()
    
    let likesAndCommentsLabel = { () -> UILabel in
        
        let label = UILabel()
        label.text = "200 Likes      1000 Comments"
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buttonsContainerView = { () -> UIView in
        let v = UIView()
//        v.layer.borderColor = UIColor.black.cgColor
//        v.layer.borderWidth = 1
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
        
    }()
    
    let likeButton = SinglePostCell.createButtonByTitle(title: "Like", icon: #imageLiteral(resourceName: "like"))
    let commentButton = SinglePostCell.createButtonByTitle(title: "Comments", icon: #imageLiteral(resourceName: "comment"))
    let shareButton = SinglePostCell.createButtonByTitle(title: "Share", icon: #imageLiteral(resourceName: "share"))
    
    func setupViews () {
        
        addSubview(profileImageView)
        addSubview(profileNameLabel)
        addSubview(statusTextLabel)
        addSubview(statusImageView)
        addSubview(likesAndCommentsLabel)
        addSubview(dividerView)
        addSubview(buttonsContainerView)
        buttonsContainerView.addSubview(likeButton)
        buttonsContainerView.addSubview(commentButton)
        buttonsContainerView.addSubview(shareButton)
        
        
        //profile image
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //profile name
        profileNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        profileNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        
        //profile status text
        statusTextLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        statusTextLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8).isActive = true
        
        //status image
        statusImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        statusImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        statusImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        statusImageView.topAnchor.constraint(equalTo: statusTextLabel.bottomAnchor, constant: 10).isActive = true
        
        //likes and comments label
        likesAndCommentsLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        likesAndCommentsLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        likesAndCommentsLabel.topAnchor.constraint(equalTo: statusImageView.bottomAnchor, constant: 8).isActive = true
        
        //divider
        dividerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        dividerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
        dividerView.topAnchor.constraint(equalTo: likesAndCommentsLabel.bottomAnchor, constant: 8).isActive = true
        
        
        //3 buttons container
        buttonsContainerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        buttonsContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        buttonsContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        buttonsContainerView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 0).isActive = true
        
        //3 buttons: like, comment, share
        //likeButton
        
        let oneThirdWidth = self.frame.size.width/3
        
        likeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: oneThirdWidth).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: buttonsContainerView.centerYAnchor, constant: 0).isActive = true
        
        //comment button
        
        commentButton.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: 0).isActive = true
        commentButton.widthAnchor.constraint(equalToConstant: oneThirdWidth).isActive = true
        commentButton.centerYAnchor.constraint(equalTo: buttonsContainerView.centerYAnchor, constant: 0).isActive = true
        
        //share button

        shareButton.leftAnchor.constraint(equalTo: commentButton.rightAnchor, constant: 0).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: oneThirdWidth).isActive = true
        shareButton.centerYAnchor.constraint(equalTo: buttonsContainerView.centerYAnchor, constant: 0).isActive = true
        
    }//End setupViews
    
    
    //func to create like, comment and share buttons
    static func createButtonByTitle(title:String, icon: UIImage) -> UIButton {
        let resultButton = { () -> UIButton in
            
            let button = UIButton()
            
            button.setImage(icon, for: .normal)
            button.setTitleColor(.gray, for: .normal)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium), NSAttributedStringKey.foregroundColor: UIColor.gray])
            
            button.setAttributedTitle(attributedText, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        return resultButton
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


