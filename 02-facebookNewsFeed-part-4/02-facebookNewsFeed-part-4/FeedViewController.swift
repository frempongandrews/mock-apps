//
//  ViewController.swift
//  02-facebookNewsFeed-part-4
//
//  Created by Andrews Frempong on 22/10/2017.
//  Copyright © 2017 Andrews Frempong. All rights reserved.
//

import UIKit

class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cell"
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView?.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        
        navigationItem.title = "Facebook"
        
        
        
        let zucPost = Post(profileName: "Mark Zuckerberg", profileImage: #imageLiteral(resourceName: "zuck"), statusText: "Meanwhile, Beast turns to the dark side", statusImageUrl: "", numberOfLikes: 300, numberOfComments: 1000)
        
        let zucPost1 = Post(profileName: "Mark Zuckerberg", profileImage: #imageLiteral(resourceName: "zuck"), statusText: "Meanwhile, Beast turns to the dark side", statusImageUrl: "", numberOfLikes: 300, numberOfComments: 1000)
        
        let zucPost2 = Post(profileName: "Mark Zuckerberg", profileImage: #imageLiteral(resourceName: "zuck"), statusText: "Meanwhile, Beast turns to the dark side", statusImageUrl: "", numberOfLikes: 300, numberOfComments: 1000)

        posts.append(zucPost)
        posts.append(zucPost1)
        posts.append(zucPost2)
        
        //print(posts.count)
        
        //register cell
        collectionView?.register(SinglePostCell.self, forCellWithReuseIdentifier: cellId)

    }//end viewDidLoad
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SinglePostCell
        cell.backgroundColor = .white
        let post = posts[indexPath.item]
        cell.post = post
        return cell
    }
    
    //collectionViewDelegateFlowLayout: size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 380)
    }

} //<!-- End feedController-->


//<!-- Post class -->
class Post {
    var profileName: String?
    var profileImage: UIImage?
    var statusText: String?
    var statusImageUrl: String?
    var numberOfLikes: Int?
    var numberOfComments: Int?
    
    init(profileName: String, profileImage: UIImage, statusText: String, statusImageUrl: String, numberOfLikes: Int, numberOfComments: Int) {
        self.profileName = profileName
        self.profileImage = profileImage
        self.statusText = statusText
        self.statusImageUrl = statusImageUrl
        self.numberOfLikes = numberOfLikes
        self.numberOfComments = numberOfComments
    }
    
}

let zucPost = Post(profileName: "Mark Zuckerberg", profileImage: (UIImage(named: "") ?? nil)!, statusText: "Meanwhile, Beast turns to the dark side", statusImageUrl: "", numberOfLikes: 300, numberOfComments: 1000)






































