//
//  VC_UserList.swift
//  RandomUser
//
//  Created by Jun Jung on 9/15/19.
//  Copyright © 2019 JunJung. All rights reserved.
//

import UIKit

class VC_UserList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var userList : Array<User> = Array<User>()
    var pageNo : UInt = 1
    var itemPerPage : UInt = 30
    
    @IBOutlet var userListTableV: UITableView!
    
    // MARK: - ViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set table view delegates and data sources
        userListTableV.dataSource = self
        userListTableV.delegate = self
        
        // Request first data
        requestUsers()
    }
    
    // MARK: - TableView data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath) as! TV_UserCell
        cell.setData(user: userList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    // MARK: - TableView delegates
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // For infinite scrolling (Pagination)
        if(indexPath.row == self.userList.count - 3) { // pre-load next users list
            requestUsers()
        }
    }
    
    // MARK: - Server API Calls and Callbacks
    func requestUsers() {
        if(!APIManager.shared.isOnRequest()) {
            APIManager.shared.getUsersList(pageNo: pageNo, itemCnt: itemPerPage,
                                           onSuccess: successfullyRetrivedUserList(users:),
                                           onFail: failedToRetriveUserList(err:))
        }
    }
    
    func applyFilter() {
        userList.removeAll() // remove all downloaded data
        ImageManager.shared.cleanCache() // also remove all downloaded images
        
        // reset variables
        pageNo = 1
        APIManager.shared.resetSeed()
        
        userListTableV.reloadData() // clear all data (which is already feteched)
        requestUsers() // and re-request with filter
    }
    
    func successfullyRetrivedUserList(users : Array<User>) { // On Success
        pageNo += 1 // If success, Increase page no.
        userList.append(contentsOf: users) // add users to the data source
        userListTableV.reloadData() // reload data
        userListTableV.isHidden = false
    }
    
    func failedToRetriveUserList(err : Error) { // On Failure
        print(err.localizedDescription)
        userListTableV.isHidden = true
    }
    
    // MARK: - Button actions
    @IBAction func retryToLoad(_ sender: UIButton) {
        requestUsers()
    }
    
    // MARK: - Memory warning
    override func didReceiveMemoryWarning() {
        ImageManager.shared.cleanCache()
    }
    
    // MARK: - Transition to new VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "viewUserDetail") {
            (segue.destination as! VC_UserDetail).user = userList[userListTableV.indexPathForSelectedRow!.row]
        }
        if(segue.identifier == "filterView") {
            (segue.destination as! VC_SetFilter).applyFilter = applyFilter
        }
    }
}
