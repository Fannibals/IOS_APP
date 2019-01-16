**1. as，as! and as?**

+ as : upcasts

```swift
class Person {
    var name : String
    
    init(_ name: String){
        self.name = name
    }
    
    func myAge() {
        print("my age is: \(0)");
    }
    func myName() {
        print("my name is: \(self.name)")
    }

}

// 定义学生类
class Student : Person {
    var age : Int = 10
    
    override func myAge() {
        print("my age is: \(self.age)")
    }
    
    override func myName() {
        print("my name is: \(self.name)")
    }
}

// 定义教师类
class Teacher : Person {
    var age : Int = 40
    
    override func myAge() {
        print("my age is: \(self.age)");
    }
    override func myName() {
        print("my name is: \(self.name)")
    }
}

func showPersonName(_ people : Person){
    let name = people.name
    print("这个人的名字是: \(name)")
}


var tom = Student("Tom");
var kevin = Student("Kevin Jakson");

// 先把学生对象向上转型为一般的人员对象
let person1 = tom as Person
let person2 = kevin as Person

// 再调用通用的处理人员对象的showPersonName函数
showPersonName(person1)
showPersonName(person2)

// option: 2
func info() {
    show(person: Student("Ethan"))
    show(person: Teacher("Kitty"))
}

func show(person: Person){
    person.myAge()
    person.myName()
}
info()

// 向上转型 upcast
// 1- What happens if running child class's specific functions?
// Answer : cannot run methods that are not exist in the father class
```

+ switch 语句中进行模式匹配

```swift
switch person1 {
    case let person1 as Student:
        print("是Student类型，打印学生成绩单...")
    case let person1 as Teacher:
        print("是Teacher类型，打印老师工资单...")
    default: break
}
```



2. as！

+ using as Downcasting

3. as? 

+ Same as as!, but it returns nil when it is false

