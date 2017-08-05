
import UIKit

class Food: NSObject, NSCoding {
    
    // MARK: Properties
    
    var foodName: String
    var calories: Int
    var location: String?
    let dateCreated: Date
    let foodKey: String
    
    // MARK: Initiliaztion
    
    init(foodName: String, calories: Int, location: String?) {
    self.foodName = foodName
    self.calories = calories
    self.location = location
    self.dateCreated = Date()
    self.foodKey = UUID().uuidString
    
    super.init()
        
    }
    
    convenience init(random: Bool = false) {
        if random {
            let foodName2 = "New food!"
            let calories2 = 0
            let location2 = "Where did you eat?"
            
            self.init(foodName: foodName2,
                      calories: calories2,
                      location: location2)
        }
        else {
            self.init(foodName: "", calories: 0, location: "")
        }
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(foodName, forKey: "foodName")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(foodKey, forKey: "foodKey")
        aCoder.encode(location, forKey: "location")
        
        aCoder.encode(calories, forKey: "calories")
    }
    
    required init(coder aDecoder: NSCoder) {
        foodName = aDecoder.decodeObject(forKey: "foodName") as! String
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
        foodKey = aDecoder.decodeObject(forKey: "foodKey") as! String
        location = aDecoder.decodeObject(forKey: "location") as! String?
        
        calories = aDecoder.decodeInteger(forKey: "calories")
        
        super.init()
    }
    
}
