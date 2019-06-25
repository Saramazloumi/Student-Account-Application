

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "StepperCell") as? StepperCell {
                cell.titleTextField.text = "Loan Interest"
                cell.valueLabel.text = String(userDao!.getUserByUsername(username: "Sara")!.hasSetting!.loanInterest)
                cell.stepper.value = userDao!.getUserByUsername(username: "Sara")!.hasSetting!.loanInterest
                return cell
            }else{
                return StepperCell()
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as? SwitchCell {
                cell.studentLabel.text = "Student Account"
                cell.switchAccount.isOn = (userDao?.getUserByUsername(username: "Sara")!.hasSetting!.studentAccount)!
                return cell
            }else{
                return SwitchCell()
            }
        }
    }
    
    
    
}

