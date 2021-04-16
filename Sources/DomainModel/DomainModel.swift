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
    
    static func toUSD(_ amt: Double, _ currency: String) -> Double {
        var usd: Double = amt;
        switch currency {
        case "GBP":
            usd = amt * 2.0
        case "EUR":
            usd = amt * 2.0/3.0
        case "CAN":
            usd = amt * 4.0/5.0
        default:
            break
        }
        return usd
    }
    
    func convert(_ newCurrency: String) -> Money {
        var newAmt = Money.toUSD(Double(self.amount), self.currency)
        switch newCurrency {
        case "GBP":
            newAmt *= 0.5
        case "EUR":
            newAmt *= 1.5
        case "CAN":
            newAmt *= 1.25
        default:
            break
        }
        newAmt.round()
        return Money(amount: Int(newAmt), currency: newCurrency)
    }
    
    func add(_ toAdd: Money) -> Money {
        let converted = self.convert(toAdd.currency)
        return Money(amount: converted.amount + toAdd.amount, currency: toAdd.currency)
    }
    
    func subtract(_ toSubtract: Money) -> Money {
        let converted = self.convert(toSubtract.currency)
        return Money(amount: converted.amount - toSubtract.amount, currency: toSubtract.currency)
    }

}

////////////////////////////////////
// Job
//
public class Job {
    let title: String
    var type: JobType
    
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
        case .Salary (let salary):
            return Int(salary)
        case .Hourly (let wage):
            var income = wage * Double(hours)
            income.round()
            return Int(income)
        }
    }
    
    func raise(byAmount: Double) {
        switch self.type {
        case .Salary (let salary):
            var newSalary = Double(salary) + byAmount
            newSalary.round()
            self.type = JobType.Salary(UInt(newSalary))
        case .Hourly (let wage):
            self.type = JobType.Hourly(wage + byAmount)
        }
    }
    
    func raise(byPercent: Double) {
        switch self.type {
        case .Salary (let salary):
            var newSalary = Double(salary) + Double(salary) * byPercent
            newSalary.round()
            self.type = JobType.Salary(UInt(newSalary))
        case .Hourly (let wage):
            self.type = JobType.Hourly(wage + wage * byPercent)
        }
    }
}

////////////////////////////////////
// Person
//
public class Person {
    var firstName: String
    var lastName: String
    var age: Int
    var job: Job? {
        didSet {
            if (age < 16) {
                job = nil
            }
        }
    }
    var spouse: Person? {
        didSet {
            if (age < 18) {
                spouse?.spouse = nil
                spouse = nil
            }
        }
    }
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.job = nil
        self.spouse = nil
    }
    
    func toString() -> String {
        return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job?.title ?? "nil") spouse:\(self.spouse?.toString() ?? "nil")]"
    }
    
}

////////////////////////////////////
// Family
//
public class Family {
    var members: Array<Person>
    
    init(spouse1: Person, spouse2: Person) {
        members = []
        if (spouse1.spouse == nil && spouse2.spouse == nil) {
            members = [spouse1, spouse2]
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
        }
    }
    
    func haveChild(_ child: Person) -> Bool {
        if (members.count == 2 && (members[0].age > 21 || members[1].age > 21)) {
            members.append(child)
            return true
        }
        return false
    }
    
    func householdIncome() -> Int {
        var income = 0;
        for person in members {
            income += person.job?.calculateIncome(2000) ?? 0
        }
        return income
    }
}
