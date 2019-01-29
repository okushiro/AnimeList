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

class ListTableViewController: UITableViewController {
    
    let userDefaults = UserDefaults.standard
    
    let setYear : [String] = ["2014年", "2015年", "2016年", "2017年", "2018年", "2019年"]
    let setSeason : [String] = ["冬アニメ", "春アニメ", "夏アニメ", "秋アニメ"]
    
    @IBOutlet weak var listTitleLabel: UINavigationItem!
    
    var animeList:[[String:String]] = [[:]]
    
    var selectAnime:[String:String] = [:]

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
        
        //前ページで設定したものを取得
        animeList = (userDefaults.object(forKey: "animeList") as? [[String: String]])!
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        
        cell.textLabel?.text = animeList[indexPath.row]["title"]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectAnime = animeList[indexPath.row]
        userDefaults.set(selectAnime, forKey: "selectAnime")
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
