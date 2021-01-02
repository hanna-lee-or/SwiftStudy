//
//  ResultVC1.swift
//  HelloWorld
//
//  Created by Hanna on 2021/01/02.
//

import UIKit

class ResultVC1: UIViewController {
    
    // 값을 화면에 표시할 아웃렛 변수들
    @IBOutlet var resultEmail: UILabel!
    @IBOutlet var resultUpdate: UILabel!
    @IBOutlet var resultInterval: UILabel!
    
    /*
    // 값을 전달받을 프로퍼티들
    var paramEmail : String?
    var paramUpdate : Bool?
    var paramInterval: Double?
    */
    
    // 화면이 표시될 때마다 실행되는 메소드
    override func viewWillAppear(_ animated: Bool) {
        
        let ad = UIApplication.shared.delegate as? AppDelegate
        
        if let email = ad?.paramEmail {
            resultEmail.text = email
        }
        if let update = ad?.paramUpdate {
            resultUpdate.text = update == true ? "자동갱신" : "자동갱신 안함"
        }
        if let interval = ad?.paramInterval {
            resultInterval.text = "\(Int(interval))분마다"
        }
    }
    
}
