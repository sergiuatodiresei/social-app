//
//  PostCell.swift
//  Social Network
//
//  Created by Sergiu Atodiresei on 05.12.2016.
//  Copyright © 2016 SergiuApps. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(post: Post) {
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
    }

}
