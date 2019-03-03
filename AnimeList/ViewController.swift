//
//  ViewController.swift
//  AnimeList
//
//  Created by 奥城健太郎 on 2019/01/26.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PKHUD

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // UIPickerViewの列の数
    func numberOfComponents(in yearPicker: UIPickerView) -> Int {
        return 2
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return setYear.count
        }else{
            return setSeason.count
        }
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        if component == 0{
            return setYear[row]
        }else{
            return setSeason[row]
        }
    }
    
    
    @IBOutlet weak var yearPicker: UIPickerView!
    
    let userDefaults = UserDefaults.standard
    
    //PickerViewの内容
    let setYear : [String] = ["2014年", "2015年", "2016年", "2017年", "2018年", "2019年"]
    let setSeason : [String] = ["冬アニメ", "春アニメ", "夏アニメ", "秋アニメ"]
    
//    let yearKey = "year_value"
//    let seasonKey = "season_value"
    
    var yearRow:Int = 0
    var seasonRow:Int = 0
    
    var animeList : [(
        title:String, twitter_hash_tag:String, public_url:String, twitter_account:String
        )] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yearPicker.delegate = self
        yearPicker.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func didTouchSearchBtn(_ sender: Any) {
        
        HUD.show(.progress)
        
        // 1列目の選択されているrowの取得
        yearRow = yearPicker.selectedRow(inComponent: 0)
        userDefaults.set(yearRow, forKey: "yearKey")
        // 2列目の選択されているrowの取得
        seasonRow = yearPicker.selectedRow(inComponent: 1)
        userDefaults.set(seasonRow, forKey: "seasonKey")
        
        //URL
        let url:String = "https://api.moemoe.tokyo/anime/v1/master/\(yearRow+2014)/\(seasonRow+1)"
        
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
                
                //辞書型に変更して保存
                let saveData: [[String: Any]] = self.animeList.map {[
                    "title": $0.title,
                    "twitter_hash_tag": $0.twitter_hash_tag,
                    "public_url": $0.public_url,
                    "twitter_account": $0.twitter_account
                    ]}
                self.userDefaults.set(saveData, forKey: "animeList")
                self.performSegue(withIdentifier: "toList", sender: nil)
        }
        
        //リスト表示ページへ
//        if animeList.isEmpty {return}
//        self.userDefaults.set(self.animeList, forKey: "animeList")
//        performSegue(withIdentifier: "toList", sender: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let next = segue.destination as? ListTableViewController
//        let _ = next?.view
//        next?.yearRow = yearRow
//        next?.seasonRow = seasonRow
//    }
    
}

