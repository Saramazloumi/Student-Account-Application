

import UIKit

class StepperCell: UITableViewCell {
    
    @IBOutlet weak var titleTextField: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBAction func step(_ sender: UIStepper) {        
        userDao?.getUserByUsername(username: "Sara")?.hasSetting?.loanInterest = sender.value
        valueLabel.text = String(sender.value)
        do{
            try userDao?.getManageContext()?.save()
        }catch{
            print("Error is saving data", error.localizedDescription)
        }
    }
    
}
