//
//  DetailViewController.swift
//  AnimeList
//
//  Created by 奥城健太郎 on 2019/01/29.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController, SFSafariViewControllerDelegate {
    
    let userDefaults = UserDefaults.standard

    var selectAnime:[String:String] = [:]
    
    //アニメのタイトル
    @IBOutlet weak var animeTitleLabel: UILabel!
    
    //公式ハッシュタグ
    @IBOutlet weak var hashtagLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectAnime = (userDefaults.object(forKey: "selectAnime") as? [String: String])!
        
        animeTitleLabel.text = selectAnime["title"]
        
        let hashtagText = selectAnime["twitter_hash_tag"]
        
        hashtagLabel.text = "#\(hashtagText!)"

        // Do any additional setup after loading the view.
    }
    
    //公式ホームページに飛ぶ
    @IBAction func didTouchBrowserBtn(_ sender: Any) {
        
        let browserViewController = SFSafariViewController(url: URL(string:selectAnime["public_url"]!)!)
        browserViewController.delegate = self
        present(browserViewController, animated: true, completion: nil)
        
    }
    
    //公式ツイッターに飛ぶ
    @IBAction func didTouchTwitterBtn(_ sender: Any) {
        
        let twitterUrl = "https://twitter.com/\(selectAnime["twitter_account"]!)"
        let twitterViewController = SFSafariViewController(url: URL(string:twitterUrl)!)
        twitterViewController.delegate = self
        present(twitterViewController, animated: true, completion: nil)
        
    }
    
    //閉じた時の処理
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
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
