//
//  BWComposeViewController.swift
//  BTStudioWeiBo
//
//  Created by hadlinks on 2019/4/19.
//  Copyright © 2019 BTStudio. All rights reserved.
//

import UIKit

class BWComposeViewController: BWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orange
        
        title = "微博"
        
        navigationItemCustom.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(dismissVC), isBack: true)
        
        let attriStr = BWEmoticonManager.shared.emoticonString(string: "[爱你]哈哈哈[马上有对象][12412]", font: UIFont.systemFont(ofSize: 17))
        print(attriStr)
    }
    
    @objc func dismissVC() {
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
