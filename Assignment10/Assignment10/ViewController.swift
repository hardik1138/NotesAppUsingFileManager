//
//  ViewController.swift
//  MyUserDefaults
//
//  Created by DCS on 03/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let usernameLabel:UILabel={
        let label=UILabel()
        label.textAlignment = .center
        return label
        
    }()
    private let logoutButton:UIButton={
        let button=UIButton()
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(LogoutTapped), for: .touchUpInside)
        button.backgroundColor = .green
        button.layer.cornerRadius = 6
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(usernameLabel)
        view.addSubview(logoutButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        checkAuth()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        usernameLabel.frame = CGRect(x: 40, y: 200, width: view.width-80 , height: 40)
        logoutButton.frame = CGRect(x: 40, y: usernameLabel.bottom + 20, width:     view.width-80, height: 40)
    }
    
    private func checkAuth()
    {
        if let uname = UserDefaults.standard.string(forKey: "usrename"){
            usernameLabel.text = "Welcome \(uname)"
        }else{
            let vc = LoginVC()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(true, animated: false)
            present(nav,animated: false)
        }
    }
    @objc private func LogoutTapped(){
       UserDefaults.standard.setValue(nil, forKey: "username")
        checkAuth()
    }
}

