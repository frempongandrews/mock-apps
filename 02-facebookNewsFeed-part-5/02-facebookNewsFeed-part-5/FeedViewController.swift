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
        
        //print(posts.count)
        
    } //<!-- end viewDidLoad-->
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomFeedCell
        cell.backgroundColor = .white
        let post = posts[indexPath.item]
        cell.post = post
        return cell
    }
    
    //sizes
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let knownHeight = 380
        let statusText = posts[indexPath.item].statusText
        let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)], context: nil)
        
        let totalHeight = CGFloat(knownHeight) + rect.height
        return CGSize(width: view.frame.width, height: totalHeight)
        
    }
    
    func setupView() {
        
        let zucPost = Post(profileName: "Mark Zuckerberg", profileImage: #imageLiteral(resourceName: "zuck"), date: "October 31", city: "Manchester",
                           statusText: "Meanwhile, Beats turns to the dark side",
                           statusImage: #imageLiteral(resourceName: "zuck-dog"), statusImageUrl: "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/mark_zuckerberg_background.jpg", likesNumber: 100, commentsNumber: 65)
        
        let stevePost = Post(profileName: "Steve Jobs", profileImage: #imageLiteral(resourceName: "steve_profile"), date: "November 1", city: "San Francisco",
                             statusText: "Design is not just how it looks like. Design is how it works. Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me. Sometimes when you innovate, you make mistakes. It is best to admit them quickly and get on with it. Design is not just how it looks like. Design is how it works. Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me. Sometimes when you innovate, you make mistakes. It is best to admit them quickly and get on with it. Design is not just how it looks like. Design is how it works. Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me. Sometimes when you innovate, you make mistakes. It is best to admit them quickly and get on with it. Design is not just how it looks like. Design is how it works. Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me. Sometimes when you innovate, you make mistakes. It is best to admit them quickly and get on with it.",
                             statusImage: #imageLiteral(resourceName: "steve_status"),
                             statusImageUrl: "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/steve_jobs_background.jpg",
                             likesNumber: 98,
                             commentsNumber: 64)
        
        let gandhiPost = Post(profileName: "Mahatma Gandhi",
                              profileImage: #imageLiteral(resourceName: "gandi_profile"), date: "November 3", city: "New Delhi", statusText: "Live as if you were to die tomorrow; learn as if you were to live forever. The weak can never forgive. Forgiveness is the attribute of the strong. Happiness is when what you think, what you say and what you do are in harmony.", statusImage: #imageLiteral(resourceName: "gandhi_status"),
                              statusImageUrl: "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/gandhi_status.jpg", likesNumber: 558, commentsNumber: 2000)
        
        posts.append(zucPost)
        posts.append(stevePost)
        posts.append(gandhiPost)
    }


}//<!-- end FeedViewController-->


//<-------------------------------------------------------------------------------------------->


//custom Feedcell

class CustomFeedCell: UICollectionViewCell {

    var post: Post? {
        didSet {
            
            //profile image
            if let profileImage = post?.profileImage {
                profileImageView.image = profileImage
                
            }
            
            //profile name
            if let profileName = post?.profileName {
                profileNameLabel.text = profileName
                
            }
 
            //dateLocation label(defined below)
            
            if let date = post?.date, let city = post?.city {
                let attributedText = NSMutableAttributedString(string: "\(date)  ·  \(city)  ·  ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12, weight: .medium)])
                let attachment = NSTextAttachment()
                attachment.image = #imageLiteral(resourceName: "globe")
                //shapping globe image otherwise too big
                attachment.bounds = CGRect(x: 0, y:-2, width: 12, height: 12)
                attributedText.append(NSAttributedString(attachment: attachment))
                dateLocationLabel.attributedText = attributedText
                
            }
            
            //status text
            if let statusText = post?.statusText {
                statusTextLabel.text = statusText
            }
            
            //status image
            if let statusImage = post?.statusImage {
                statusImageView.image = statusImage
            }
            
            //likes and comments
            
            if let numberOfLikes = post?.likesNumber, let numberOfComments = post?.commentsNumber {
                let attributedText = NSMutableAttributedString(string: "\(numberOfLikes) Likes   \(numberOfComments) Comments", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10), NSAttributedStringKey.foregroundColor: UIColor.gray])
                likesAndCommentsLabel.attributedText = attributedText
            }
            

        }//end didSet
    }
    
    //<!-- Components -->
    
    let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let profileNameLabel: UILabel = {
        //START HERE
        let label = UILabel()
        //label.text = "Test Name"
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //define dateLocation label ouside like this, assign attributed text based on
    //what we get from post
    var dateLocationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    
    let statusTextLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = .green
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
    
    let divider: UIView = {
       let v = UIView()
        v.backgroundColor = .gray
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    
    
    //<!-- End Components -->
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createButtonByTitle (title: String, icon: UIImage) {
        
    }
    
    func setupViews() {
        
        //add to screen
        addSubview(profileImageView)
        addSubview(profileNameLabel)
        addSubview(dateLocationLabel)
        addSubview(statusTextLabel)
        addSubview(statusImageView)
        addSubview(likesAndCommentsLabel)
        addSubview(divider)
        
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
        statusTextLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        
        statusImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        statusImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        statusImageView.topAnchor.constraint(equalTo: statusTextLabel.bottomAnchor, constant: 8).isActive = true
        statusImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        likesAndCommentsLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        likesAndCommentsLabel.topAnchor.constraint(equalTo: statusImageView.bottomAnchor, constant: 8).isActive = true
        
        divider.topAnchor.constraint(equalTo: likesAndCommentsLabel.bottomAnchor, constant: 8).isActive = true
        divider.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        divider.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        
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
    var statusImageUrl: String
    var likesNumber: Int
    var commentsNumber: Int
    
    init(profileName: String, profileImage: UIImage, date: String, city: String, statusText: String, statusImage: UIImage, statusImageUrl: String, likesNumber: Int, commentsNumber: Int) {
        
        self.profileName = profileName
        self.profileImage = profileImage
        self.date = date
        self.city = city
        self.statusText = statusText
        self.statusImage = statusImage
        self.statusImageUrl = statusImageUrl
        self.likesNumber = likesNumber
        self.commentsNumber = commentsNumber
        
    }
}



























