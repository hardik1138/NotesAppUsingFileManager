
import UIKit

class NewNote: UIViewController {
    
    var filename: String?

    private let BackBtn:UIButton={
        let button=UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(backHandle), for: .touchUpInside)
        return button
    }()
    
    private let DoneBtn:UIButton={
        let button=UIButton()
        button.setImage(UIImage(named: "Done"), for: .normal)
        button.addTarget(self, action: #selector(doneHandle), for: .touchUpInside)
        return button
    }()
    public let Title:UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.08235294118, green: 0.0431372549, blue: 0.5098039216, alpha: 1)])
        textField.textColor = #colorLiteral(red: 0.08235294118, green: 0.0431372549, blue: 0.5098039216, alpha: 1)
        textField.font = UIFont.systemFont(ofSize: 22)
        textField.textAlignment = .left
        return textField
    }()
    
    private let contentView : UITextView = {
        let cv = UITextView()
        cv.textColor = #colorLiteral(red: 0.08235294118, green: 0.0431372549, blue: 0.5098039216, alpha: 1)
        cv.text = ""
        cv.font = UIFont.systemFont(ofSize: 16)
        cv.textAlignment = .left
        return cv
    }()
    @objc func backHandle()
    {
        navigationController?.popViewController(animated: true)
    }
    @objc func doneHandle()
    {
        let name = Title.text!
        let content = contentView.text!
        let filepath = FMS.getDocDir().appendingPathComponent("\(name).txt")
        do{
            try content.write(to: filepath, atomically: true, encoding: .utf8)
            resetField()
            navigationController?.popViewController(animated: true)
        }catch {
            print(error)
        }
    }
    func resetField()
    {
        Title.text = ""
        contentView.text = ""
        filename = ""
        
    }
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        view.addSubview(BackBtn)
        view.addSubview(DoneBtn)
        view.addSubview(Title)
        view.addSubview(contentView)
    }
    override func viewWillAppear(_ animated: Bool) {
        if let s1 = filename {
            Title.text = s1
            Title.isEnabled = false
            do{
                let filepath = FMS.getDocDir().appendingPathComponent("\(s1).txt")
                let fetchContent =  try String(contentsOf: filepath)
                contentView.text = fetchContent
                print(fetchContent)
            }catch{
                print(error)
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        BackBtn.frame = CGRect(x: 20, y: 50, width: 64, height: 22)
        DoneBtn.frame = CGRect(x: 310, y: 50, width: 45, height: 22)
        Title.frame = CGRect(x: 20, y: 90, width: view.width - 40, height: 45)
        contentView.frame = CGRect(x: 19, y: Title.bottom , width: view.width - 38, height: view.height - 50)
        
    }
}
