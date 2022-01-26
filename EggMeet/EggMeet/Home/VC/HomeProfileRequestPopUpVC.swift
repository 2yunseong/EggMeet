//
//  HomeProfileRequestPopUpVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/26.
//

import Foundation
import UIKit

class HomeProfileRequestPopUpVC: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    
    var requestMentorNickname: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func dismissView(){
        dismiss(animated:true, completion: nil)
    }
    
    @IBAction func showMentorRequestAlert(){
        let alert = UIAlertController(title: "\(requestMentorNickname)님께 멘토 신청을 하시겠습니까?",message: " ",preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "취소", style: .default, handler: nil)
        //확인 버튼 만들기
        let ok = UIAlertAction(title: "확인", style: .destructive, handler: {
            action in
            //특정기능 수행
            self.dismissView()
        })
        alert.addAction(cancel)
        //확인 버튼 경고창에 추가하기
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
    }
    
    @IBAction func touchCloseButton(){
        self.dismissView()
    }
}
