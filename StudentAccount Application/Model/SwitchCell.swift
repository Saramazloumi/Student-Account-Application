

import UIKit

class SwitchCell: UITableViewCell {
    
    @IBOutlet weak var studentLabel: UILabel!
    @IBOutlet weak var switchAccount: UISwitch!
    
    
    
    @IBAction func `switch`(_ sender: UISwitch) {
        userDao?.getUserByUsername(username: "Sara")?.hasSetting?.studentAccount = sender.isOn
        
        do{
            try userDao?.getManageContext()?.save()
        }catch{
           print("Error in saving account info", error.localizedDescription)
        }
    }
    
}
