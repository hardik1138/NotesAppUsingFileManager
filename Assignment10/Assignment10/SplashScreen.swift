
import UIKit

class SplashScreen: UIViewController {
    
    private let BgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "SplashScreen")
        iv.clipsToBounds = true
        
        return iv
    }()
    private let label : UILabel = {
        let lb = UILabel ()
        lb.text = "Swipe to login..."
        lb.font = UIFont(name: "San Francisco", size: 10)
        lb.textColor = #colorLiteral(red: 0.08235294118, green: 0.0431372549, blue: 0.5098039216, alpha: 1)
        lb.textAlignment = .center
        return lb
    }()
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        //view.backgroundColor = .blue
        super.viewDidLoad()
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didLeftSwipeview))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        view.addSubview(BgView)
        view.addSubview(label)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        BgView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        label.frame =  CGRect(x: 0, y: view.bottom - 68, width: view.width, height: 29)
    }
    @objc private func didLeftSwipeview(gesture:UISwipeGestureRecognizer){
        let vc = LoginScreen()
        navigationController?.pushViewController(vc, animated: true)
    }
}
