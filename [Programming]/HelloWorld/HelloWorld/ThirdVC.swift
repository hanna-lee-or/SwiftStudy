//
//  ThirdVC.swift
//  HelloWorld
//
//  Created by Hanna on 2021/01/01.
//

import UIKit

class ThirdVC: UIViewController {
    
    // 값 전달하기 실습
    @IBOutlet var email: UITextField!
    @IBOutlet var isUpdate: UISwitch!
    @IBOutlet var interval: UIStepper!
    @IBOutlet var isUpdateText: UILabel!
    @IBOutlet var intervalText: UILabel!
    
    // 값 넘기기
    @IBAction func onSubmit(_ sender: Any) {
        
        // 인스턴스 생성
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondNaviVC") as? SecondNaviViewController else {
            return
        }
        
        // 값 전달
        rvc.paramEmail = self.email.text!
        rvc.paramUpdate = self.isUpdate.isOn
        rvc.paramInterval = self.interval.value
        
        // 화면 이동
        self.navigationController?.pushViewController(rvc, animated: true)
        
    }
    
    // 자동 갱신 여부. 스위치 조작.
    @IBAction func onSwitch(_ sender: UISwitch) {
        
        /*
         // sender 타입이 Any인 경우 다운 캐스팅 (옵셔널 캐스팅)
         guard let obj = sender as? UISwitch else {
            return
         }
         */
        
        if sender.isOn {
            self.isUpdateText.text = "갱신함"
        }
        else {
            self.isUpdateText.text = "갱신하지 않음"
        }
    }
    
    // 갱신 주기 설정. 스텝퍼 조작.
    @IBAction func onStepper(_ sender: UIStepper) {
        let value = Int(sender.value)
        self.intervalText.text = "\(value)분 마다"
    }
    
    // 네비게이션 바 버튼을 통한 페이지 이동.
    @IBAction func MoveByNavi(_ sender: Any) {
        
        // 인스턴스 생성
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondNaviVC") as? SecondNaviViewController else {
            return
        }
        
        // 값 전달
        rvc.paramEmail = self.email.text!
        rvc.paramUpdate = self.isUpdate.isOn
        rvc.paramInterval = self.interval.value
        
        // 화면을 전환한다.
        self.navigationController?.pushViewController(rvc, animated: true)
        
    }
    
}
