//
//  ViewController.swift
//  RealmCloudKit
//
//  Created by Bell App Lab on 08/11/2015.
//  Copyright (c) 2015 Bell App Lab. All rights reserved.
//

import UIKit
import RealmSwift
import RealmCloudKit
import CloudKit

class Test: Object {
  dynamic var date = Test.stringDate
  
  static var stringDate: String = {
    return "\(NSDate())"
  }()
}

class ViewController: UIViewController {
    var realm = try! Realm()
    let publicDB = CKContainer.defaultContainer().publicCloudDatabase

    override func viewDidLoad() {
        super.viewDidLoad()
      print(realm.path)
        try! realm.write {
          realm.add(Test(value: [Test.stringDate]))
        }
      
        print(realm.objects(Test))

        let query = CKQuery(recordType: "Test", predicate: NSPredicate(value: true))
        publicDB.performQuery(query, inZoneWithID: nil) { (records, error) -> Void in
          print(records)
          print(error)
        }
      
        // Uncomment the following and see a wonderful Infinite Loop :-) Why?
        RealmCloudKit.start(realmToBeSynced: realm) { (resultRealm, error) -> Void in
          print(resultRealm!.path)
          print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

