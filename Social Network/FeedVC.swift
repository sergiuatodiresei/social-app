//
//  FeedVC.swift
//  Social Network
//
//  Created by Sergiu Atodiresei on 03.12.2016.
//  Copyright © 2016 SergiuApps. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutBtnTapped(_ sender: Any) {
        let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("A fost inlaturat cu succes din keychain:", removeSuccessful)
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: SEGUE_LOGGED_OUT, sender: nil)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
