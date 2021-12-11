
import UIKit

class LoginScreen: UIViewController {
    
    private let BgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "LoginScreen")
        iv.clipsToBounds = true
        return iv
    }()
    public let tfView1 = UIView()
    public let myTextField1:UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.08235294118, green: 0.0431372549, blue: 0.5098039216, alpha: 1)])
        textField.textColor = #colorLiteral(red: 0.08235294118, green: 0.0431372549, blue: 0.5098039216, alpha: 1)
        textField.textAlignment = .left
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        return textField
    }()
    
    public let tfView2 = UIView()
    public let myTextField2:UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.08235294118, green: 0.0431372549, blue: 0.5098039216, alpha: 1)])
        textField.isSecureTextEntry = true
        textField.textColor = #colorLiteral(red: 0.08235294118, green: 0.0431372549, blue: 0.5098039216, alpha: 1)
        textField.textAlignment = .left
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        return textField
    }()
    private let Forgotlabel : UILabel = {
        let lb = UILabel ()
        lb.text = "Forgot Password?"
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textColor = #colorLiteral(red: 0.08235294118, green: 0.0431372549, blue: 0.5098039216, alpha: 1)
        lb.textAlignment = .left
        return lb
    }()
     private let LoginBtn:UIButton = {
        let button=UIButton()
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(OnbtnClick), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.08235294118, green: 0.0431372549, blue: 0.5098039216, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        return button
    }()
    @objc func OnbtnClick()
    {
        if(myTextField1.text == "Hardik123" && myTextField2.text == "hardik123")
        {
            UserDefaults.standard.setValue(myTextField1.text, forKey: "username")
            let cv = NotesView()
            navigationController?.pushViewController(cv, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(BgView)
        view.addSubview(tfView1)
        view.addSubview(tfView2)
        view.addSubview(Forgotlabel)
        view.addSubview(LoginBtn)
        
        tfView1.backgroundColor = UIColor(patternImage: UIImage(named: "textfieldbg")!)
        tfView1.addSubview(myTextField1)
        tfView2.backgroundColor = UIColor(patternImage: UIImage(named: "textfieldbg")!)
        tfView2.addSubview(myTextField2)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        BgView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        
        tfView1.frame = CGRect(x: 35, y: 391, width: 310, height: 58)
        myTextField1.frame = CGRect(x: 0, y: 0, width: tfView1.width , height: tfView1.height )
        
        tfView2.frame = CGRect(x: 35, y: tfView1.bottom + 10, width: 310, height: 58)
        myTextField2.frame = CGRect(x: 0, y: 0, width: tfView2.width , height: tfView2.height )
        Forgotlabel.frame = CGRect(x: 226, y: 520, width: 120, height: 17)
        LoginBtn.frame = CGRect(x: 39, y: tfView2.bottom + 50, width: 305, height: 45)
    }
}
		
