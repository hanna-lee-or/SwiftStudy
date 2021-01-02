//
//  SecondViewController.swift
//  HelloWorld
//
//  Created by Hanna on 2021/01/01.
//

import UIKit

class SecondViewController: UIViewController {
    
    // 이전 페이지로 되돌아감.
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    // 세그웨이 실행.
    @IBAction func wind(_ sender: Any) {
        self.performSegue(withIdentifier: "ManualWind", sender: self)
    }
    
    @IBAction func unwindToVC(_ segue: UIStoryboardSegue){
        
    }
    
    // 세그웨어 전처리 함수.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("세그웨이가 곧 실행됩니다. (두번째 화면 -> 세번째 화면)")
        print(">>> /(segue.identifier!)")
    }
    
    // 액션 시트 띄우기
    override func viewDidAppear(_ animated: Bool) {
        // 알림창 객체 생성
        let alert = UIAlertController(title: "화면 전환", message: "현재 페이지는 화면 전환 테스트 페이지입니다.", preferredStyle: .alert)
        
        // 알림창 버튼 객체 생성
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            if let tf = alert.textFields?[0] {
                print("입력된 값은 \(tf.text!) 입니다.")
            } else {
                print("입력된 값이 없습니다.")
            }
        }
        
        // 텍스트 필드, 버튼 알림창에 추가
        alert.addTextField(configurationHandler: { (tf) in
            tf.placeholder = "암호" // 안내 메시지
            tf.isSecureTextEntry = true // 비밀번호 처리
        })
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: false)
        
    }
    
}
