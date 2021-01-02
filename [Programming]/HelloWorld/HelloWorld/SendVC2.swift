//
//  SendVC2.swift
//  HelloWorld
//
//  Created by Hanna on 2021/01/02.
//

import UIKit

class SendVC2: UIViewController{
    
    // 전달할 값들이 올 변수
    @IBOutlet var email: UITextField!
    @IBOutlet var isUpdate: UISwitch!
    @IBOutlet var interval: UIStepper!
    @IBOutlet var isUpdateText: UILabel!
    @IBOutlet var intervalText: UILabel!
    
    @IBAction func onSubmit(_ sender: Any) {
        
        /*
        // 이전 화면 객체 참조. 타입 캐스팅.
        let preVC = self.presentingViewController
        guard let vc = preVC as? ResultVC1 else {
            return
        }
        
        // 값 전달
        vc.paramEmail = self.email.text
        vc.paramUpdate = self.isUpdate.isOn
        vc.paramInterval = self.interval.value
        */
        
        let ad = UIApplication.shared.delegate as? AppDelegate
        
        ad?.paramEmail = self.email.text
        ad?.paramUpdate = self.isUpdate.isOn
        ad?.paramInterval = self.interval.value        
        
        // 이전 화면으로 복귀
        self.presentingViewController?.dismiss(animated: true)
        
    }
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        
        if sender.isOn {
            self.isUpdateText.text = "갱신함"
        }
        else {
            self.isUpdateText.text = "갱신하지 않음"
        }
        
    }
    
    @IBAction func upStepper(_ sender: UIStepper) {
        let value = Int(sender.value)
        self.intervalText.text = "\(value)분 마다"
    }
    
}
