//
//  ViewController.swift
//  DelegateTest
//
//  Created by Hanna on 2021/01/03.
//

import UIKit

// Delegate 프로토콜 적용
class ViewController: UIViewController {

    // 아웃렛 변수
    @IBOutlet var tf: UITextField!
    
    
    @IBAction func confirm(_ sender: Any) {
        // 텍스트 필드를 최초 응답자 객체에서 해제
        self.tf.resignFirstResponder()
    }
    
    @IBAction func input(_ sender: Any) {
        // 텍스트 필드를 최초 응답자 객체로 지정
        self.tf.becomeFirstResponder()
    }
    
    // 뷰 컨트롤러가 메모리에 로드된 후 호출
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 델리게이트 지정
        self.tf.delegate = self
        
        // 텍스트 필드 속성 설정
        self.tf.placeholder = "값을 입력하세요" // 안내 메시지
        self.tf.keyboardType = UIKeyboardType.alphabet // 키보드 타입 영문자 패드로
        self.tf.keyboardAppearance = UIKeyboardAppearance.dark // 키보드 스타일 어둡게
        self.tf.returnKeyType = UIReturnKeyType.join // 리턴키 타입은 "JOIN"
        self.tf.enablesReturnKeyAutomatically = true // 리턴키 자동 활성화 "ON"
        
        /**
         * 스타일 설정
         */
        // 테두리 스타일 - 직선
        self.tf.borderStyle = UITextField.BorderStyle.line
        // 배경 색상
        self.tf.backgroundColor = UIColor(white: 0.87, alpha: 1.0)
        // 수직 방향으로 텍스트가 가운데 정렬되도록
        self.tf.contentVerticalAlignment = .center
        // 수평 방향으로 텍스트가 가운데 정렬되도록
        self.tf.contentHorizontalAlignment = .center
        // 테두리 색상을 회색으로
        // 일반적으로 iOS에서 색상 처리하는 객체는 UIColor지만,
        // 텍스트 필드의 테두리 색상은 그보다 저수준인 CGColor 타입이므로 변환 필요 (.cgColor)
        self.tf.layer.borderColor = UIColor.darkGray.cgColor
        // 테두리 두께 설정 (단위: pt)
        self.tf.layer.borderWidth = 2.0
        
        // 텍스트 필드를 최초 응답자로 지정
        self.tf.becomeFirstResponder()
        
    }
    
    // unwind (첫번째 화면으로 복귀)
    @IBAction func unwindHome(segue: UIStoryboardSegue){
        
    }

}

//MARK: - 텍스트 필드 컨트롤러 델리게이트 메소드
extension ViewController: UITextFieldDelegate {
    
    // 텍스트 필드의 편집을 시작할 때 호출
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("텍스트 필드의 편집 시작")
    }
    
    // 텍스트 필드의 내용이 삭제될 때 호출
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 내용 삭제")
        return true // false를 리턴하면 삭제되지 않는다.
    }
    
    // 텍스트 필드의 내용이 변경될 때 호출
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("텍스트 필드의 내용이 \(string)으로 입력", terminator: " => ")
        if Int(string) == nil {
            // 현재 텍스트 필드에 입력된 길이와 더해질 문자열 길이의 합이
            // 10을 넘는다면 텍스트 필드에 입력 내용 반영하지 않음.
            if (textField.text?.count)! + string.count > 10 {
                print("X")
                return false // false를 리턴하면 삭제되지 않는다.
            } else {
                print("O")
                return true
            }
        } else {
            // 입력된 값이 숫자라면 false를 리턴
            print("X")
            return false // false를 리턴하면 삭제되지 않는다.
        }
        
    }
    
    // 텍스트 필드의 리턴키가 눌러졌을 때 호출
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("텍스트 필드의 리턴키가 눌림")
        return true
    }
    
    // 텍스트 필드 편집이 종료될 때 호출
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 종료됩니다.")
        return true // false를 리턴하면 편집이 종료되지 않는다.
    }
    
    // 텍스트 필드의 편집이 종료되었을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("텍스트 필드의 편집이 종료되었습니다.")
    }
}
