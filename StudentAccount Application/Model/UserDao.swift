
import Foundation
import CoreData

class UserDao {
    
    var appDelegate: AppDelegate?
    
    init(delegate: AppDelegate) {
        appDelegate = delegate
    }
    
    func getManageContext() -> NSManagedObjectContext? {
        guard let context = appDelegate?.persistentContainer.viewContext else{return nil}
        return context
    }
    
    func getUsers(attributeName:String, attributeValue:String) -> [User]? {
        if let context = getManageContext() {
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "User")
        request.predicate = NSPredicate(format: "\(attributeName) = %@", attributeValue)
        
        do{
            return try context.fetch(request) as? [User]
        }catch{
            print("error in fetching data!", error.localizedDescription)
            return nil
          }
        }else{
            return nil
        }
    }
    
    func getUserByUsername(username:String) -> User? {
        if let user = getUsers(attributeName: "username", attributeValue: username) {
            if user.count > 1 {
                print("\(username) is exist!")
            }
            return user.first
        }else{
            print("\(username) is not exist!")
            return nil
        }
    }
    
    func getAllUsers() -> [User]? {
        if let context = getManageContext(){
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "User")
        do{
            return try context.fetch(request) as? [User]
        }catch{
            print("Error in fetching info", error.localizedDescription)
            return nil
        }
            } else{
                return nil
            }
    }
    
    func saveUser(userCreateForm: UserCreateForm) -> Bool {
        
        if let existantUser = getUserByUsername(username: userCreateForm.username) {
            print("\(existantUser) is already exist!")
            return false
        }
            if let context = getManageContext() {
                let user = User(context: context)
                user.username = userCreateForm.username
                
                let setting = Setting(context: context)
                setting.belongsTo = user
                user.hasSetting = setting
                
                user.hasSetting?.loanInterest = userCreateForm.setting.loanInterest
                user.hasSetting?.studentAccount = userCreateForm.setting.studentAccount
                
                do{
                    try context.save()
                    return true
                }catch{
                    print("Cannot save data", error.localizedDescription)
                    return false
                }
            } else {
                print("Cannot communicate with coredata!")
                return false
        }
    }
    
    func removeUser(username: String)-> Bool {
        if let user = getUserByUsername(username: username) {
            if let context = getManageContext() {
                context.delete(user)
                return true
            } else{
                print("Cannot communicate with data base!")
                return false
            }
        }else{
            print("\(username) is not exist!")
            return false
        }
    }
    
    
}
