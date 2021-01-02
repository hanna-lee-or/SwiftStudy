//
//  NewSegue.swift
//  HelloWorld
//
//  Created by Hanna on 2021/01/02.
//

import UIKit

class NewSegue: UIStoryboardSegue {
    
    override func perform() {
        // 세그웨이 출발지 뷰 컨트롤러
        let srcUVC = self.source
        // 세그웨이 목적지 뷰 컨트롤러
        let destUVC = self.destination
        // fromView에서 toView로 뷰 전환
        UIView.transition(from: srcUVC.view, to: destUVC.view, duration: 3, options: .transitionCurlDown)
    }
    
}
