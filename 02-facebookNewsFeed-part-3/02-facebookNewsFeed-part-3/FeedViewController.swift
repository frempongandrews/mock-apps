//
//  ViewController.swift
//  02-facebookNewsFeed-part-3
//
//  Created by Andrews Frempong on 15/10/2017.
//  Copyright © 2017 Andrews Frempong. All rights reserved.
//

import UIKit

var cacheDictionary: [String: UIImage] = [:]

class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var posts: [Post] = []
    let cellId = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //increasing size of NSURL default cache size
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "path")
        URLCache.shared = urlCache
        
        
        collectionView?.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        navigationItem.title = "Facebook Feed"
        
        let zucPost = Post(profileName: "Mark Zuckerberg", statusText: "Meanwhile, Beats turns to the dark side", statusImageUrl: "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/mark_zuckerberg_background.jpg", profileImage: #imageLiteral(resourceName: "zuck"), numLikes: 400, numComments: 123)
        let jobsPost = Post(profileName: "Steve Jobs",
                            statusText: "Design is not just how it looks like. Design is how it works. Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me. Sometimes when you innovate, you make mistakes. It is best to admit them quickly and get on with it. Design is not just how it looks like. Design is how it works. Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me. Sometimes when you innovate, you make mistakes. It is best to admit them quickly and get on with it. Design is not just how it looks like. Design is how it works. Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me. Sometimes when you innovate, you make mistakes. It is best to admit them quickly and get on with it. Design is not just how it looks like. Design is how it works. Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me. Sometimes when you innovate, you make mistakes. It is best to admit them quickly and get on with it.",
                            statusImageUrl: "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/steve_jobs_background.jpg", profileImage: #imageLiteral(resourceName: "steve_profile"), numLikes: 1000, numComments: 55 )
        let gandhiPost = Post(profileName: "Mahatma Gandhi",
                              statusText: "Live as if you were to die tomorrow; learn as if you were to live forever. The weak can never forgive. Forgiveness is the attribute of the strong. Happiness is when what you think, what you say and what you do are in harmony.",
                              statusImageUrl: "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/gandhi_status.jpg",
                              profileImage: #imageLiteral(resourceName: "gandi_profile"), numLikes: 558, numComments: 2000)
        
        
        
        posts.append(zucPost)
        posts.append(jobsPost)
        posts.append(gandhiPost)
        
        
        //print(posts.count)
        //register cell
        collectionView?.register(CustomFeedCell.self, forCellWithReuseIdentifier: cellId)
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomFeedCell
        let post = posts[indexPath.item]
        cell.post = post
        return cell
    }
    
    //for size need flow layout delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //calculating exact size of status text that can vary
        
        let knownHeight = CGFloat(380)
        let statusText = posts[indexPath.item].statusText
        //we use the font size of the text to calculate the height
        //the first CGSize refers to constraints I decide:
        //this case, width: view.frame.size.width - 16
        //(16 because text has 8 padding on both sides)
        if let unwrappedStatusText = statusText {
            
            let rect = NSString(string: unwrappedStatusText).boundingRect(with: CGSize(width: view.frame.size.width - 16, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)], context: nil)
            
            //24 is just if 'bounding rect underestimates the length'
            let totalCellHeight = CGFloat(knownHeight + 24 + rect.height)
            
            return CGSize(width: view.frame.size.width, height: totalCellHeight)
        }
       
        
        return CGSize(width: 0, height: 0)
  
    }
    
} //<!-- End FeedViewController -->


class CustomFeedCell: UICollectionViewCell {
    
    var post:Post? {
        didSet {
            //Checking if we have properties on the post object and assigning their values to the various ui components
            
            //setting the profile name
                let attributedText = NSMutableAttributedString(string: post?.profileName ?? "", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
                
                attributedText.append(NSAttributedString(string: "\nDecember  18  ‧  San Francisco  ‧  ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)]))
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
                
                //globe image
                let attachment = NSTextAttachment()
                attachment.image = #imageLiteral(resourceName: "globe")
                attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                attributedText.append(NSAttributedString(attachment: attachment))
                
                profileNameLabel.attributedText = attributedText
                
                profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            //setting the profile image
            if let profileImage = post?.profileImage {
                profileImageView.image = profileImage
            }
            
            //setting status text
            
            if let statusText = post?.statusText {
                statusTextView.text = statusText
            }
            
            if let statusImageUrl = post?.statusImageUrl {
                //do network request
                
                let requestedUrl = URL(string: statusImageUrl)
                let task = URLSession.shared.dataTask(with: requestedUrl!, completionHandler: { (data, response, error) in
                    
                    if error == nil {
                        
                       
                            
                            if let data = data {
                                
                                let image = UIImage(data: data)
                                
                                //cache
                                
                                cacheDictionary["statusImage"] = image
                                
                                DispatchQueue.main.async {
                                    self.statusImageView.image = image
                                
                            }
                            
                        }
                        
                        

                    }
                    
                })//end of task
                
                task.resume()
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews () {
        
        //adding subviews
        addSubview(profileImageView)
        addSubview(profileNameLabel)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesAndCommentsLabel)
        addSubview(divider)
        addSubview(likeCommentShareContainer)
        likeCommentShareContainer.addSubview(likeButton)
        likeCommentShareContainer.addSubview(commentsButton)
        likeCommentShareContainer.addSubview(shareButton)
        
        
        //profileImageView
        
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //profileNameLabel
        
        
        profileNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        profileNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        
        //statusTextLabel
        statusTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8).isActive = true
        statusTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        statusTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        statusTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8).isActive = true
        
        //statusImageView
        statusImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        statusImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        statusImageView.topAnchor.constraint(equalTo: statusTextView.bottomAnchor, constant: 15).isActive = true
        //set image fix height to 200
        statusImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        //likesAndCommentsLabel
        
       likesAndCommentsLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
       likesAndCommentsLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
       likesAndCommentsLabel.topAnchor.constraint(equalTo: statusImageView.bottomAnchor, constant: 10).isActive = true
        
        
        //divider
        
        divider.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        divider.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        divider.topAnchor.constraint(equalTo: likesAndCommentsLabel.bottomAnchor, constant: 8).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
//
        
        //likeCommentShareContainer
        likeCommentShareContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        likeCommentShareContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        likeCommentShareContainer.topAnchor.constraint(equalTo: likesAndCommentsLabel.bottomAnchor, constant: 8).isActive = true
        likeCommentShareContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        
        //likeButton
        let oneThirdWidth = self.frame.size.width/3
        likeButton.leftAnchor.constraint(equalTo: likeCommentShareContainer.leftAnchor, constant: 0).isActive = true
        likeButton.topAnchor.constraint(equalTo: likeCommentShareContainer.topAnchor, constant: 0).isActive = true
        likeButton.bottomAnchor.constraint(equalTo: likeCommentShareContainer.bottomAnchor, constant: 0).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: oneThirdWidth).isActive = true
        
        //print(oneThirdWidth)
        
        //comments button
        
        commentsButton.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: 0).isActive = true
        commentsButton.widthAnchor.constraint(equalToConstant: oneThirdWidth).isActive = true
        commentsButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor, constant: 0).isActive = true



        //share button
        
        shareButton.leftAnchor.constraint(equalTo: commentsButton.rightAnchor, constant: 0).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: oneThirdWidth).isActive = true
        shareButton.centerYAnchor.constraint(equalTo: commentsButton.centerYAnchor, constant: 0).isActive = true
        
    }// end setupViews



    let profileNameLabel = { () -> UILabel in
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()

    let profileImageView = { () -> UIImageView in
        
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        //imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    let statusTextView = {() -> UITextView in
        
        let textView = UITextView()
        //label.text = "Meanwhile, Beast turned to the dark side"
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
       return textView
    }()
    
    let statusImageView = {() -> UIImageView in
        
        let imageview = UIImageView()
        //imageview.image = #imageLiteral(resourceName: "zuck-dog")
        imageview.contentMode = .scaleAspectFill
        //!!very important: set masksToBounds to true -> cuts of unnecessary pixels
        //from image and sets its height to one defined in constraints
        imageview.layer.masksToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let likesAndCommentsLabel = {() -> UILabel in
        
        let label = UILabel()
        label.text = "458 Likes   10.7K comments"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 10)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let divider = { () -> UIView in
        
        let v = UIView()
        v.backgroundColor = .gray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
        
    }()
    
    let likeCommentShareContainer = { () -> UIView in
        
        let v = UIView()
        //v.backgroundColor = .green
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
        
    }()
    
    
    //function to create like, comment and share buttons
    static func createButtonWithTitle (title: String, icon: UIImage) -> UIButton {
        
        let resultButton = {() -> UIButton in
            let button = UIButton()
            //button.setTitleColor(.gray, for: .normal)
            button.setImage(icon, for: .normal)
            button.setAttributedTitle(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.gray]), for: .normal)
            
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            
            //=======> END ANKI
            
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
            
        }()
        
        return resultButton
    }
    
    
    let likeButton = CustomFeedCell.createButtonWithTitle(title: "Like", icon: #imageLiteral(resourceName: "like"))
    let commentsButton = CustomFeedCell.createButtonWithTitle(title: "Comments", icon: #imageLiteral(resourceName: "comment"))
    let shareButton = CustomFeedCell.createButtonWithTitle(title: "Share", icon: #imageLiteral(resourceName: "share"))
    

    
}

/////////////---Extension for uicolor--------------------//////////////////

extension UIColor {
    static func customRgb (r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor.init(red: r/CGFloat(255), green: g/CGFloat(255), blue: b/CGFloat(255), alpha: 1)
    }
    
}

/////////////---Post data model--------------------//////////////////

class Post {
    
    var profileName: String?
    var statusText: String?
    var statusImageUrl: String?
    var profileImage: UIImage?
    var numLikes: Int?
    var numComments: Int?
    
    init (profileName: String, statusText: String, statusImageUrl: String?, profileImage: UIImage, numLikes: Int, numComments: Int) {
        self.profileName = profileName
        self.statusText = statusText
        self.statusImageUrl = statusImageUrl
        self.profileImage = profileImage
        self.numLikes = numLikes
        self.numComments = numComments
    }
    
}







































