//
//  DetailViewController.swift
//  AnimeList
//
//  Created by 奥城健太郎 on 2019/01/29.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard

    var selectAnime:[String:String] = [:]
    
    @IBOutlet weak var animeTitleLabel: UILabel!
    
    
    @IBOutlet weak var hashtagLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectAnime = (userDefaults.object(forKey: "selectAnime") as? [String: String])!
        
        animeTitleLabel.text = selectAnime["title"]
        
        let hashtagText = selectAnime["twitter_hash_tag"]
        
        hashtagLabel.text = "#\(hashtagText!)"

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
