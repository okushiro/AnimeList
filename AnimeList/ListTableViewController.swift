//
//  ListTableViewController.swift
//  AnimeList
//
//  Created by 奥城健太郎 on 2019/01/27.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PKHUD

class ListTableViewController: UITableViewController {
    
    let userDefaults = UserDefaults.standard
    
    let setYear : [String] = ["2014年", "2015年", "2016年", "2017年", "2018年", "2019年"]
    let setSeason : [String] = ["冬アニメ", "春アニメ", "夏アニメ", "秋アニメ"]
    
    @IBOutlet weak var listTitleLabel: UINavigationItem!
    
    var animeList : [(
        title:String, twitter_hash_tag:String, public_url:String, twitter_account:String
        )] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //選択したクールを取得
        guard let yearIndex:Int = userDefaults.object(forKey: "yearKey") as? Int else{
            return
        }
        guard let seasonIndex:Int = userDefaults.object(forKey: "seasonKey") as? Int else{
            return
        }
        
        //タイトルにクール名を入れる
        listTitleLabel.title = "\(setYear[yearIndex]) \(setSeason[seasonIndex])"
        
        //URL
        let url:String = "https://api.moemoe.tokyo/anime/v1/master/\(yearIndex+2014)/\(seasonIndex+1)"
        
        //APIの取得
        Alamofire.request(
            url,
            method: .get,
            parameters: [:],
            encoding: URLEncoding.default,
            headers: nil
            )
            .responseJSON{(response: DataResponse<Any>) in
                
                let json = JSON(response.result.value as Any)
                
                self.animeList = []
                for item in 0 ..< json.count {
                    if let title = json[item]["title"].string,
                        let twitter_hash_tag = json[item]["twitter_hash_tag"].string,
                        let public_url = json[item]["public_url"].string,
                        let twitter_account = json[item]["twitter_account"].string {
                        let animeInfo = (title, twitter_hash_tag, public_url, twitter_account)
                        self.animeList.append(animeInfo)
                    }
                }
                
                //データを更新
                self.tableView.reloadData()
                HUD.hide()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return animeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = animeList[indexPath.row].title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectAnime = animeList[indexPath.row]
        
        //辞書型に変更して保存
        let saveData: [String: Any] = [
            "title": selectAnime.title,
            "twitter_hash_tag": selectAnime.twitter_hash_tag,
            "public_url": selectAnime.public_url,
            "twitter_account": selectAnime.twitter_account
            ]
        
        userDefaults.set(saveData, forKey: "selectAnime")
    }
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
