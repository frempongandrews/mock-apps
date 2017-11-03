//
//  ViewController.swift
//  02-facebookNewsFeed-part-5
//
//  Created by Andrews Frempong on 31/10/2017.
//  Copyright © 2017 Andrews Frempong. All rights reserved.
//

import UIKit


class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var posts: [Post] = []
    let cellId = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Facebook Feed"
        collectionView?.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        collectionView?.alwaysBounceVertical = true
        
        //register cell
        
        collectionView?.register(CustomFeedCell.self, forCellWithReuseIdentifier: cellId)
        
        setupView()
        
        print(posts.count)
        
    } //<!-- end viewDidLoad-->
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .white
        
        return cell
    }
    
    //sizes
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let knownHeight = 310
        let statusText = posts[indexPath.item].statusText
        let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.size.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
        
        let totalHeight = CGFloat(knownHeight) + rect.height
        
        return CGSize(width: view.frame.width, height: totalHeight )
        
    }
    
    func setupView() {
        
        let zucPost = Post(profileName: "Mark Zuckerberg", profileImage: #imageLiteral(resourceName: "zuck"), date: "October 31", city: "Manchester",
                           statusText: "Meanwhile, beast went on the other side",
                           statusImage: #imageLiteral(resourceName: "zuck-dog"), likesNumber: 100, commentsNumber: 65)
        
        let stevePost = Post(profileName: "Steve Jobs", profileImage: #imageLiteral(resourceName: "steve_profile"), date: "November 1", city: "San Francisco", statusText: "Meanwhile, beast went on the other side", statusImage: #imageLiteral(resourceName: "steve_status"), likesNumber: 98, commentsNumber: 64)
        
        posts.append(zucPost)
        posts.append(stevePost)
    }


}//<!-- end FeedViewController-->


//<-------------------------------------------------------------------------------------------->


//custom Feedcell

class CustomFeedCell: UICollectionViewCell {
    
    let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .red
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let profileNameLabel: UILabel = {
        //START HERE
        let label = UILabel()
        label.text = "Test Name"
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let dateLocationLabel: UILabel = {
        //START HERE
       let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "October 31  ·  Manchester  ·  ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12, weight: .medium)])
        let attachment = NSTextAttachment()
        attachment.image = #imageLiteral(resourceName: "globe")
        //shapping globe image otherwise too big
        attachment.bounds = CGRect(x: 0, y:-2, width: 12, height: 12)
        attributedText.append(NSAttributedString(attachment: attachment))
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusTextLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.text = "Meanwhile, beast turned to the dark side"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        //eliminate unneccesary pixels
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let likesAndCommentsLabel: UILabel = {
       let label = UILabel()
        
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        //add to screen
        addSubview(profileImageView)
        addSubview(profileNameLabel)
        addSubview(dateLocationLabel)
        addSubview(statusTextLabel)
        addSubview(statusImageView)
        
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        profileNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        profileNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        profileNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        
        dateLocationLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        dateLocationLabel.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: 2).isActive = true
        dateLocationLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        
        statusTextLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        statusTextLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8).isActive = true
        
        statusImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        statusImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        statusImageView.topAnchor.constraint(equalTo: statusTextLabel.bottomAnchor, constant: 8).isActive = true
        statusImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    
    
    
} //<!-- end CustomFeedCell-->



//<-------------------------------------------------------------------------------------------->


class Post {
    var profileName: String
    var profileImage: UIImage
    var date: String
    var city: String
    var statusText: String
    var statusImage: UIImage
    var likesNumber: Int
    var commentsNumber: Int
    
    init(profileName: String, profileImage: UIImage, date: String, city: String, statusText: String, statusImage: UIImage, likesNumber: Int, commentsNumber: Int) {
        
        self.profileName = profileName
        self.profileImage = profileImage
        self.date = date
        self.city = city
        self.statusText = statusText
        self.statusImage = statusImage
        self.likesNumber = likesNumber
        self.commentsNumber = commentsNumber
        
    }
}



























