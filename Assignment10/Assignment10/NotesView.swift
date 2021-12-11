

import UIKit

class NotesView: UIViewController {
    
    private let WUlabel : UILabel = {
        let lb = UILabel ()
        lb.text = ""
        lb.font = UIFont.systemFont(ofSize: 20)
        lb.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lb.textAlignment = .center
        return lb
    }()
    
    private let LogoutBtn:UIButton={
        let button=UIButton()
        button.setImage(UIImage(named: "logout"), for: .normal)
        button.addTarget(self, action: #selector(logoutHandle), for: .touchUpInside)
        return button
    }()
    @objc func logoutHandle (){
        UserDefaults.standard.setValue(nil, forKey: "username")
        checkAuth()
    }
    
    public let SearchBar:UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Search notes", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3960784314, green: 0.3843137255, blue: 0.4823529412, alpha: 1)])
        textField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.3176470588, alpha: 1)
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = #colorLiteral(red: 0.3647058824, green: 0.3529411765, blue: 0.4941176471, alpha: 1)
        textField.layer.cornerRadius = 5
        textField.textAlignment = .left
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(45, 0, 0)
        return textField
    }()
    
    private let searchIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "search")
        iv.clipsToBounds = true
        return iv
    }()
    
    private let SubTitle : UILabel = {
        let lb = UILabel ()
        lb.text = "List notes"
        //lb.font = UIFont.systemFont(ofSize: 20)
        lb.font = UIFont.boldSystemFont(ofSize:20)
        lb.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lb.textAlignment = .left
        return lb
    }()
    private let SubTitleVal : UILabel = {
        let lb = UILabel ()
        lb.text = "(25)"
        //lb.font = UIFont.systemFont(ofSize: 20)
        lb.font = UIFont.boldSystemFont(ofSize:20)
        lb.textColor = #colorLiteral(red: 0.3098039216, green: 0.3215686275, blue: 1, alpha: 1)
        lb.textAlignment = .left
        return lb
    }()
    
    private let newBtn:UIButton={
        let button=UIButton()
        button.setImage(UIImage(named: "+"), for: .normal)
        button.addTarget(self, action: #selector(newHandle), for: .touchUpInside)
        return button
    }()
    
    @objc func newHandle (){
       let vc = NewNote()
        navigationController?.pushViewController(vc, animated: true)
    }

    private let myTableView = UITableView()
    
    private var noteArray = [String]()
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = #colorLiteral(red: 0.03529411765, green: 0.02352941176, blue: 0.1333333333, alpha: 1)
        super.viewDidLoad()
        view.addSubview(WUlabel)
        view.addSubview(LogoutBtn)
        view.addSubview(SearchBar)
        view.addSubview(searchIcon)
        view.addSubview(SubTitle)
        view.addSubview(SubTitleVal)
        view.addSubview(myTableView)
        view.addSubview(newBtn)
        myTableView.backgroundColor = .clear
        myTableView.separatorColor = .clear
        myTableView.showsVerticalScrollIndicator = false
        myTableView.showsHorizontalScrollIndicator = false
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        noteArray = []
        for fname in FMS.getFileList()
        {
            let index = fname.firstIndex(of: ".")!
            if String(fname[index...]) == ".txt" {
                noteArray.append(String(fname[..<index]))
            }
        }
        myTableView.reloadData()
        
        checkAuth()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        WUlabel.frame = CGRect(x: 0, y: 50, width: view.width, height: 24)
        LogoutBtn.frame = CGRect(x: 330, y: 53, width: 25, height: 19)
        SearchBar.frame = CGRect(x: 20, y: 100, width: view.width - 40, height: 45)
        searchIcon.frame = CGRect(x: 35, y: 112 , width: 20, height: 20)
        SubTitle.frame = CGRect(x: 20, y: SearchBar.bottom + 30, width: 100, height: 24)
        SubTitleVal.frame = CGRect(x: 114, y: SearchBar.bottom + 30, width: 50, height: 24)
        myTableView.frame = CGRect(x: 20,
                                   y: SubTitle.bottom + 20,
                                   width: view.width - 40,
                                   height: view.height -  SubTitle.bottom - 20 - view.safeAreaInsets.bottom  )
        newBtn.frame = CGRect(x: 158, y: view.bottom - 80, width: 60, height: 60)
    }
    private func checkAuth()
    {
        if let uname = UserDefaults.standard.string(forKey: "username"){
            WUlabel.text = "Welcome \(uname)"
        }else{
            let cv = SplashScreen()
            navigationController?.pushViewController(cv, animated: true)
        }
    }
}
extension NotesView : UITableViewDataSource, UITableViewDelegate {
    private func setupTableView() {
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(TableViewCell.self, forCellReuseIdentifier: "CityCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tempc = ""
        do{
            let filepath = FMS.getDocDir().appendingPathComponent("\(noteArray[indexPath.row]).txt")
            let fetchContent =  try String(contentsOf: filepath)
            tempc = fetchContent
        }catch{
            print(error)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! TableViewCell
        cell.setupCityCellWith(title: noteArray[indexPath.row], c: tempc)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewNote()
        vc.filename  = noteArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        print("preess")
    }
}
