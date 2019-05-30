//
//  ViewController.swift
//  AnimeList
//
//  Created by 奥城健太郎 on 2019/01/26.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import UIKit
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
    
    var yearRow:Int = 0
    var seasonRow:Int = 0
    
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
        
        performSegue(withIdentifier: "toList", sender: nil)
    }
    
}

