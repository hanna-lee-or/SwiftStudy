//
//  AppDelegate.swift
//  HelloWorld
//
//  Created by Hanna on 2020/12/29.
//

import UIKit
import UserNotifications // 로컬 알람, 서버 알람

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    // 값을 전달받을 프로퍼티들
    var paramEmail : String?
    var paramUpdate : Bool?
    var paramInterval: Double?

    // 앱이 처음 실행될 때, 필요한 시스템적 처리를 모두 끝내고 메인 화면을 표시하기 직전에 호출. (시작 화면 제어 가능)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        sleep(1) // 시작 화면 표시 시간 증가
        
        if #available(iOS 10.0, *) {
            // 경고창, 배지, 사운드를 사용하는 알림 환경 정보를 생성하고, 사용자 동의 여부 창을 시행
            // UserNotifications 프레임워크를 사용하는 방법
            let notiCenter = UNUserNotificationCenter.current()
            notiCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (didAllow, e) in }
            notiCenter.delegate = self
        } else {
            // 경고창, 배지, 사운드를 사용하는 알림 환경 정보를 생성(+사용자 동의 여부 창 실행)하고, 이를 애플리케이션에 저장
            // UserNotifications 프레임워크가 아닌 UILocalNotification 객체를 이용하는 방법
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(setting)
        }
        
        return true
    }
    
    // 앱이 비활성화 되기 직전에 호출. (전화나 문자가 도중에 온 경우, 홈 버튼으로 백그라운드화 시킨 경우 등등)
    func applicationWillResignActive(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            // 알림 동의 여부 확인
            UNUserNotificationCenter.current().getNotificationSettings { setting in
                if setting.authorizationStatus == UNAuthorizationStatus.authorized {
                    DispatchQueue.main.async {
                        // 알림 콘텐츠 객체
                        let nContent = UNMutableNotificationContent()
                        nContent.badge = 1
                        nContent.title = "로컬 알림 메시지"
                        nContent.subtitle = "준비된 내용이 아주 많아요! 얼른 다시 앱을 열어주세요!!"
                        nContent.body = "앗! 왜 나갔어요??? 어서 들어오세요!!"
                        nContent.sound = UNNotificationSound.default
                        nContent.userInfo = ["name" : "홍길동"]
                        
                        // 알림 발송 조건 객체
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
                        
                        // 알림 요청 객체
                        let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
                        
                        // 알림 센터에 추가
                        UNUserNotificationCenter.current().add(request) { (_) in
                            print("wakeup 알람을 알림센터에 추가했습니다.")
                        }
                    }
                } else {
                    print("사용자가 동의하지 않음!!!")
                }
            }
        } else {
            // 알림 설정 확인 (UILocalNotification 객체 활용하는 방법)
            let setting = application.currentUserNotificationSettings
            
            // 알림 설정이 되어 있지 않으면 로컬 알림을 보내도 받을 수 없으므로 종료
            guard  setting?.types != Optional.none else {
                print("Can't Schedule")
                return
            }
            
            // 로컬 알람 인스턴스 생성
            let noti = UILocalNotification()
            noti.fireDate = Date(timeIntervalSinceNow: 10) // 10초 후 발송
            noti.timeZone = TimeZone.autoupdatingCurrent // 현재 위치에 따라 타임존 설정
            noti.alertBody = "얼른 다시 접속하세요!!!" // 표시될 메시지
            noti.alertAction = "학습하기" // 잠금 상태일 때 표시될 액션
            noti.applicationIconBadgeNumber = 1 // 앱 아이콘 모서리에 표시될 뱃지
            noti.soundName = UILocalNotificationDefaultSoundName // 로컬 알람 도착시 사운드
            noti.userInfo = ["name" : "홍길동"] // 알람 실행 시 함께 전달하고 싶은 값. 화면 표시 X.
            
            // 생성된 알람 객체를 스케줄러에 등록
            application.scheduleLocalNotification(noti)
            
            // 생성된 알람 객체를 스케줄러에 등록
            
        }
    }
    
    // 앱 실행되는 도중 알림 메시지 도착 후 자동 호출
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 알림 종류에 따른 처리 (식별자로 구분)
        if notification.request.identifier == "wakeup" {
            let userInfo = notification.request.content.userInfo
            print("willPresent : \(userInfo["name"]!)")
        }
        else {
            print(notification.request.identifier)
        }
        // 알림 배너 띄워주기
        completionHandler([.alert, .badge, .sound])
    }
    
    // 사용자가 알림 메시지 클릭 시 자동 호출 (로컬 알림, 서버 알림)
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // 알림 메시지에 대한 정보는 두번째 인자인 response로부터 옴.
        if response.notification.request.identifier == "wakeup" {
            let userInfo = response.notification.request.content.userInfo
            print("didReceive : \(userInfo["name"]!)")
        }
    }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

