//
//  ViewController.swift
//  GCD
//
//  Created by Robo-Vikas on 02/02/18.
//  Copyright © 2018 scio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let inActiveQueue = DispatchQueue(label: "com.gcd.inActiveQueue", qos: .userInitiated, attributes: .initiallyInactive)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. User defined Queue
//        self.simpleQueue()
        
        // 2. Async execution of task in Queue
//        self.executeAsync()
        
        // 3. Sync execution of task in Queue
//        self.executeSync()
        
        // 4. What is QoS
//        self.checkQos()
        
        // 5. Serial & Concurrent execuation
//        self.serialExecution()
        
        // 6. InActiveQueue
//        self.inActiveQueueExecuation()
//        self.inActiveQueue.activate()
        
        // 7. Delayed Execution
//        self.delayedExecution(),
        
        // 8. DispatchWorkItem
//        self.testWorkItem()
        
        // 9. ConcurrentPerform
        self.concurrentPerform()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


// MARK: DispatchQueue

extension ViewController {
    
    /// Creates user defined dispatch queue to print some message
    func simpleQueue() {
        
        let queue = DispatchQueue(label: "com.gcd.simpleQueue")
        
        queue.async {
            for _ in 1 ... 5 {
                print("clap..clap .. 👏")
            }
        }
    }
}


// MARK: Sync / Async Execution

extension ViewController {
    
    func executeAsync() {
        
        let queue = DispatchQueue(label: "com.gcd.simpleQueue")
        
        print("Start Race:")
        
        queue.async {
            for i in 0 ..< 5 {
                print("🐢 @ \(i+1) Km.")
            }
        }
        
        for i in 0 ..< 5 {
            print("🐇 @ \(i+1) Km.")
        }
    }
    
    func executeSync() {
        
        let queue = DispatchQueue(label: "com.gcd.simpleQueue")
        
        print("Start Race:")
        
        // Run on queue in sync mode
        queue.sync {
            for i in 0 ..< 5 {
                print("🐢 @ \(i+1) Km.")
            }
        }
        
        // Run on UI thread
        for i in 0 ..< 5 {
            print("🐇 @ \(i+1) Km.")
        }
    }
}

// MARK: QoS

extension ViewController {
    
    func checkQos() {
        
        let queue1 = DispatchQueue(label: "com.gcd.simpleQueue1", qos: .userInitiated)
        let queue2 = DispatchQueue(label: "com.gcd.simpleQueue2", qos: .background)
        
        print("Start Race:")
        
        queue1.async {
            for i in 0 ..< 5 {
                print("🐢 @ \(i+1) Km.")
            }
        }
        
        queue2.async {
            
            for i in 0 ..< 5 {
                print("🐇 @ \(i+1) Km.")
            }
        }
    }
}

// MARK: Serial / Concurrent Execution

extension ViewController {
    
    func serialExecution() {
        
        let queue = DispatchQueue(label: "com.gcd.simpleQueue")
        
        print("Start Race:")
        
        queue.async {
            for i in 0 ..< 5 {
                print("🐢 @ \(i+1) Km.")
            }
        }
        
        queue.async {
            for i in 0 ..< 5 {
                print("🐇 @ \(i+1) Km.")
            }
        }
    }
    
    func concurrentExecution() {
        
        let queue = DispatchQueue(label: "com.gcd.simpleQueue", qos: .userInitiated, attributes: .concurrent)
        
        print("Start Race:")
        
        queue.async {
            for i in 0 ..< 5 {
                print("🐢 @ \(i+1) Km.")
            }
        }
        
        queue.async {
            for i in 0 ..< 5 {
                print("🐇 @ \(i+1) Km.")
            }
        }
    }
    
    
    func inActiveQueueExecuation() {
        
        self.inActiveQueue.async {
            print("Queue Activated")
        }
        
        print("After task execution")
    }
}

// MARK: Global Queue & Main Queue

extension ViewController {
    
    func globalQueue() {
        
        let globalQueue = DispatchQueue.global()
//        let globalQueue = DispatchQueue.global(qos: .userInitiated)
        
        globalQueue.async {
            
            for i in 0 ..< 5 {
                print("\(i)")
            }
        }
    }
    
    func mainQueue() {
        
        DispatchQueue.main.async {
            self.view.backgroundColor = UIColor.red
        }
    }
}

// MARK: Delayed Execution

extension ViewController {
    
    func delayedExecution() {
        
        let queue = DispatchQueue(label: "com.gcd.simpleQueue")
        let delayedInteraval = DispatchTimeInterval.seconds(5)
        
        
        print(Date())
        
        // Execute after the delay of 5 seconds
        queue.asyncAfter(deadline: .now() + delayedInteraval) {
            print(Date())
        }
    }
}

// MARK: DispatchWorkItem
extension ViewController {
    
    func testWorkItem() {
        
        let dispatchWorkItem = DispatchWorkItem {
            print("WorkItem Executed")
        }
        
        dispatchWorkItem.perform()
        
        DispatchQueue.global().async(execute: dispatchWorkItem)
    }
}

// MARK: Concurrent Perform

extension ViewController {
    
    func concurrentPerform() {
        
        DispatchQueue.concurrentPerform(iterations: 5) { (i) in
            print("Iteration: \(i)")
        }
    }
}


