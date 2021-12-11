
import UIKit

class TableViewCell: UITableViewCell {
    var filename = ""
    private let myTitle:UILabel = {
        let label =  UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize : 20)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    private let myCon:UILabel = {
        let label =  UILabel()
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize : 14)
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return label
    }()
    private let deleteBtn:UIButton={
        let button=UIButton()
        button.setImage(UIImage(named: "delete"), for: .normal)
        button.addTarget(self, action: #selector(deleteHandle), for: .touchUpInside)
        return button
    }()
    
    @objc func deleteHandle(){
        /*let filepath = FMS.getDocDir().appendingPathComponent("\(filename).txt")
         
         do{
         try FileManager.default.removeItem(at: filepath)
         FileArray.remove(at: indexPath.row)
         fileTableView.deleteRows(at: [indexPath], with: .automatic)
         }catch {
         
         print(error)
         }*/
        print("btn press")
    }
    private let SubView = UIView()
    
    func setupCityCellWith(title name: String , c cont: String){
        contentView.addSubview(SubView)
        SubView.addSubview(myTitle)
        SubView.addSubview(deleteBtn)
        SubView.addSubview(myCon)
        SubView.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.1450980392, blue: 0.3176470588, alpha: 1)
        SubView.layer.borderWidth = 1.0
        SubView.layer.borderColor = #colorLiteral(red: 0.3647058824, green: 0.3529411765, blue: 0.4941176471, alpha: 1)
        SubView.layer.cornerRadius = 5
        SubView.frame = CGRect(x: 0, y: 10, width: contentView.width , height:  contentView.height - 10)
        deleteBtn.frame = CGRect(x: 300, y: 15, width: 20 , height: 20)
        myTitle.frame = CGRect(x: 20, y: 3, width: SubView.width - 40 , height: 48)
        myCon.frame = CGRect(x: 20, y: myTitle.bottom - 20, width: SubView.width - 40, height: 60)
        myTitle.text = name
        filename = name
        myCon.text = cont
       
    }
}
