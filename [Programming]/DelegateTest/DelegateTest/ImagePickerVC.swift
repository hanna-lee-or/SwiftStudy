//
//  ImagePickerVC.swift
//  DelegateTest
//
//  Created by Hanna on 2021/01/03.
//

import UIKit

class ImagePickerVC: UIViewController {
    
    @IBOutlet var imgView: UIImageView!
    
    // 이미지 피커 사용
    @IBAction func pick(_ sender: Any) {
        // 이미지 피커 컨트롤러 인스턴스 생성
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        // 델리게이트 지정
        picker.delegate = self
        
        // 이미지 피커 컨트롤러 실행
        self.present(picker, animated: false)
    }
    
    // 첫번째 페이지로 복귀
    @IBAction func gotoHome(_ sender: UIButton){
        performSegue(withIdentifier: "unwindHome", sender: self)
    }
    
    
}

//MARK: - 이미지 피커 컨트롤러 델리게이트 메소드
extension ImagePickerVC: UIImagePickerControllerDelegate {
    
    // 이미지 피커에서 이미지를 선택하지 않고 취소했을 때 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // 이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: false) {() in
            // 알림창 호출 - 이미지 피커 컨트롤러 창이 닫히기 전에 알림창 호출되면,
            // 충돌로 인한 알림창 실행안되는 버그 발생 가능
            let alert = UIAlertController(title: "", message: "이미지 선택이 취소되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
        }
        
    }
    
    // 이미지 피커에서 이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: false) {() in
            // 이미지를 이미지 뷰에 표시
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.imgView.image = img
        }
        
    }
}

//MARK: - 내비게이션 컨트롤러 델리게이트 메소드
extension ImagePickerVC: UINavigationControllerDelegate {
    
}
