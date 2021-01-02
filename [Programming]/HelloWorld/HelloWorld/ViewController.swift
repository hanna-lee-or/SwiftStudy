//
//  ViewController.swift
//  HelloWorld
//
//  Created by Hanna on 2020/12/29.
//

import UIKit

class ViewController: UIViewController {
    
    var labelFlag : Bool = false
    var LFlags : Array = [false, false, false, false, false]

    @IBOutlet var uiTitle: UILabel!
    
    @IBAction func sayHello(_ sender: Any) {
        if !self.labelFlag {
            self.labelFlag = true
            self.uiTitle.text = "Hello, World!"
        } else {
            self.labelFlag = false
            self.uiTitle.text = "Page 1"
        }
    }
    
    // 실습 2 라벨
    @IBOutlet var alertText: UILabel!
    @IBOutlet var uiTitle02: UILabel!
    @IBOutlet var uiTitle03: UILabel!
    @IBOutlet var uiTitle04: UILabel!
    @IBOutlet var uiTitle05: UILabel!
    
    // 실습 2 버튼
    @IBAction func alert(_ sender: Any) {
        
        // 알림창 객체 생성
        let alert = UIAlertController(title: "선택", message: "항목을 선택해주세요.", preferredStyle: .alert)
        
        // 알림창 버튼 객체 생성
        let cancel = UIAlertAction(title: "취소", style: .cancel){ (_) in
            self.alertText.text = "취소"
        }
        let ok = UIAlertAction(title: "확인", style: .default){ (_) in
            self.alertText.text = "확인"
        }
        let exec = UIAlertAction(title: "실행", style: .destructive){ (_) in
            self.alertText.text = "실행"
        }
        let stop = UIAlertAction(title: "중지", style: .default){ (_) in
            self.alertText.text = "중지"
        }
        
        // 버튼을 컨트롤러에 등록
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addAction(exec)
        alert.addAction(stop)
        
        // 메시지 창 실행
        self.present(alert, animated: false)
               
    }
    /*
    @IBAction func clickBtn02(_ sender: Any) {
        if !self.LFlags[1] {
            self.LFlags[1] = true
            self.uiTitle02.text = "버튼2 클릭"
        } else {
            self.LFlags[1] = false
            self.uiTitle02.text = "Label 2"
        }
    }
    */
    @IBAction func clickBtn03(_ sender: Any) {
        if !self.LFlags[2] {
            self.LFlags[2] = true
            self.uiTitle03.text = "버튼3 클릭"
        } else {
            self.LFlags[2] = false
            self.uiTitle03.text = "Label 3"
        }
    }
    @IBAction func clickBtn04(_ sender: Any) {
        if !self.LFlags[3] {
            self.LFlags[3] = true
            self.uiTitle04.text = "버튼4 클릭"
        } else {
            self.LFlags[3] = false
            self.uiTitle04.text = "Label 4"
        }
    }
    @IBAction func clickBtn05(_ sender: Any) {
        if !self.LFlags[4] {
            self.LFlags[4] = true
            self.uiTitle05.text = "버튼5 클릭"
        } else {
            self.LFlags[4] = false
            self.uiTitle05.text = "Label 5"
        }
    }
    
    // 실습 3 (화면 전환)
    @IBAction func moveNext(_ sender: Any) {
        
        // 이동할 뷰 컨트롤러 객체를 StoryboardID 정보를 이용하여 참조. (guard 구문으로 필터링.)
        // let uvc = self.storyboard!.instantiateViewController(withIdentifier: "SecondVC")
        // ㄴ 옵셔널 강제 해제 (!) 사용. 오류 여지 있으므로 아래와 같이 guard 구문 활용. 이때는 (?) 연산자 사용.
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
            return
        }
        
        // 화면 전환할 때의 애니메이션 타입.
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        // 인자값으로 뷰 컨트롤러 인스턴스를 넣고 프레젠트 메소드 호출.
        self.present(uvc, animated: true)
        
    }
    
    // unwind segue 메소드.
    // custom segue로 페이지 이동 시, unwind segue 작동X.
    @IBAction func unwindToFirstVC(_ segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

