
import UIKit

class Food: NSObject, NSCoding {
    
    var foodName: String
    var calories: Int
    var location: String?
    let dateCreated: NSDate
    let foodKey: String
    
    init(foodName: String, calories: Int, location: String?) {
    self.foodName = foodName
    self.calories = calories
    self.location = location
    self.dateCreated = NSDate()
    self.foodKey = NSUUID().UUIDString
    
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
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(foodName, forKey: "foodName")
        aCoder.encodeObject(dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(foodKey, forKey: "foodKey")
        aCoder.encodeObject(location, forKey: "location")
        
        aCoder.encodeInteger(calories, forKey: "calories")
    }
    
    required init(coder aDecoder: NSCoder) {
        foodName = aDecoder.decodeObjectForKey("foodName") as! String
        dateCreated = aDecoder.decodeObjectForKey("dateCreated") as! NSDate
        foodKey = aDecoder.decodeObjectForKey("foodKey") as! String
        location = aDecoder.decodeObjectForKey("location") as! String?
        
        calories = aDecoder.decodeIntegerForKey("calories")
        
        super.init()
    }
    
}