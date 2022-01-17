//
//  SignUpNickName.swift
//  EggMeet
//
//  Created by asong on 2022/01/01.
//
import Alamofire
import Foundation
import UIKit

class SignUpNickNameVC: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var nicknameWarningLabel: UILabel!
    let nicknameKey = "nickname"
    let ud = UserDefaults.standard
    private var isNicknameSet = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "닉네임";
        self.navigationController?.navigationBar.tintColor = .black
        print("viewDidload")
    }
    
    @IBAction func windSignUpLocationView(_ sender: Any){
        if isNicknameSet {
            ud.set(self.nicknameTextField.text, forKey: nicknameKey)
            
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpAgeVC") as? SignUpAgeVC else {return}
            print("실행")
            self.navigationController?.pushViewController(nextVC, animated: true)
        }else {
            self.nicknameWarningLabel.text = "닉네임 중복 확인을 진행해주세요."
            self.nicknameWarningLabel.textColor = .red
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nicknameTextField.endEditing(true)
        }
}

extension SignUpNickNameVC {
    @IBAction func checkNicknameAvailable(_ sender: Any)  {
        var name: String = "오감자"
        print("textField : \(self.nicknameTextField.text!)")
        if nicknameTextField.text != nil {
            name = nicknameTextField.text!
            if nicknameTextField.text == "" {
                self.nicknameWarningLabel.text = "닉네임을 입력해주세요."
                self.nicknameWarningLabel.textColor = .red
                self.isNicknameSet = false
                return
            }
        }

        let url = getAPI_URL(target: "/auth/user/name")+"?name=\(name)"
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        NSLog("api URL : \(url)")
        
        var request = URLRequest(url: URL(string: encodedString)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        AF.request(request).responseData { (dataResponse) in
            switch dataResponse.result {
            case .success(let value):
                do {
                    print(dataResponse.debugDescription)
                    let isExistNickname = try JSONSerialization.jsonObject(with: value, options: .allowFragments) as! Bool
                    print(isExistNickname)
                    if isExistNickname == false {
                        self.nicknameWarningLabel.text = "이 닉네임은 사용할 수 있어요! :)"
                        self.nicknameWarningLabel.textColor = .green
                        self.isNicknameSet = true
                    }else{
                        self.nicknameWarningLabel.text = "이 닉네임은 다른 사람이 사용하고 있어요! :("
                        self.nicknameWarningLabel.textColor = .red
                        self.isNicknameSet = false
                    }
                } catch {print(error)}
            case .failure(let error):
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let data = dataResponse.data, let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Server Error: " + str)
                }
                debugPrint(error as Any)
            }
        }
    }
    
    func getAPI_URL(target: String) -> String{
        let mainAddress: String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
        let apiURL: String = "http://"+mainAddress + target
        return apiURL
    }
}
