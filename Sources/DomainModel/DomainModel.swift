struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    let amount: Int
    let currency: String
    
    init(amount amt: Int, currency curr: String) {
        amount = amt
        currency = curr
    }
    
    func convert(_ newCurrency: String) -> Money {
//        var newAmt: Double = Double(convert("USD").amount)
        var newAmt = Double(self.amount)
        switch newCurrency {
        case "GBP":
            newAmt = newAmt * 0.5
        case "EUR":
            newAmt = newAmt * 1.5
        case "CAN":
            newAmt = newAmt * 1.25
        default:
            break
        }
        newAmt.round()
        return Money(amount: Int(newAmt), currency: newCurrency)
    }
    
    func add(_ toAdd: Money) -> Money {
        return self
    }
}

////////////////////////////////////
// Job
//
public class Job {
    let title: String
    let type: JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
    init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    
    func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
        case .Salary:
            print("salary")
        default:
            print("hourly")
        }
        return -1
    }
    
    func raise(byAmount: Double) {
        
    }
    
    func raise(byPercent: Double) {
        
    }
}

////////////////////////////////////
// Person
//
public class Person {
    var firstName: String
    var lastName: String
    var age: Int
    var job: Job?
    var spouse: Person?
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.job = nil
        self.spouse = nil
    }
    
    func toString() -> String {
        return "";
    }
    
}

////////////////////////////////////
// Family
//
public class Family {
    var members: Array<Person>
    
    init(spouse1: Person, spouse2: Person) {
        members = [spouse1, spouse2]
    }
    
    func haveChild(_ child: Person) {
        
    }
    
    func householdIncome() -> Int {
        return -1
    }
}
