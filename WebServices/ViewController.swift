//
//  ViewController.swift
//  WebServices
//
//  Created by Mac on 05/01/24.
//


import UIKit
import Kingfisher

class ViewController: UIViewController {

    var users : [Users] = []
    var usersDetailCollectionViewCell : UsersDetailCollectionViewCell?
    var usersDetailViewController : UsersDetailViewController?
    @IBOutlet weak var usersCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        registerXIBWithCollectionView()
        initializeCollectionView()
    }
    func fetchData()
       {
           let userUrl = URL(string: "https://reqres.in/api/users?page=2")
           var userUrlRequest = URLRequest(url: userUrl!)
           let userUrlSession = URLSession(configuration: .default)
           let userUrlDatatask = userUrlSession.dataTask(with: userUrlRequest) { userData, userResponse, userError in
               let userResponse = try! JSONSerialization.jsonObject(with: userData!) as! [String : Any]
               
                   
                   let userDictionary = userResponse as! [String : Any]
                   let userPage = userResponse["page"] as! Int
                   let userPerPage = userResponse["per_page"] as! Int
                   let userTotal = userResponse["total"] as! Int
                   let userTotalPages = userResponse["total_pages"] as! Int
                   let data = userResponse["data"] as! [[String : Any]]
                   
                   for dataresponse in data
                   {

                       let userId = dataresponse["id"] as! Int
                       let userEmail = dataresponse["email"] as! String
                       let userFirstName = dataresponse["first_name"] as! String
                       let userLastName = dataresponse["last_name"] as! String
                       let userAvatar = dataresponse["avatar"] as! String
                       
                       let dataObject = Data(id: userId, first_name: userFirstName, last_name: userLastName, avatar: userAvatar)
                       
                       let usersObject = Users(page: userPage, per_page: userPerPage, total: userTotal, total_pages: userTotalPages, data: [dataObject])
                       
                       self.users.append(usersObject)
                       print(self.users)
   
               }
               DispatchQueue.main.async {
                   self.usersCollectionView.reloadData()
               }
               
           }
           userUrlDatatask.resume()
       }
       func registerXIBWithCollectionView()
       {
           usersCollectionView.dataSource = self
           usersCollectionView.delegate = self
       }
       func initializeCollectionView()
       {
           let uinib = UINib(nibName: "UsersDetailCollectionViewCell", bundle: nil)
           usersCollectionView.register(uinib, forCellWithReuseIdentifier: "UsersDetailCollectionViewCell")
       }
       
   }
   extension ViewController : UICollectionViewDelegate
   {
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           usersDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "UsersDetailViewController") as! UsersDetailViewController
           
           usersDetailViewController?.userContainer = users[indexPath.row]
           
           navigationController?.pushViewController(usersDetailViewController!, animated: true)
       }
   }
   extension ViewController : UICollectionViewDataSource
   {
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           users.count
       }
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           usersDetailCollectionViewCell = self.usersCollectionView.dequeueReusableCell(withReuseIdentifier: "UsersDetailCollectionViewCell", for: indexPath) as! UsersDetailCollectionViewCell
           
           
           usersDetailCollectionViewCell?.userPageLabel.text = String(users[indexPath.row].page)
           
           for i in 0...users[indexPath.row].data.count-1
           {
               usersDetailCollectionViewCell?.firstNameLabel.text = users[indexPath.row].data[i].first_name.description.codingKey.stringValue
               
               usersDetailCollectionViewCell?.lastNameLabel.text = users[indexPath.row].data[i].last_name.description.codingKey.stringValue
           }
           
           return usersDetailCollectionViewCell!
       }
   }
   extension ViewController : UICollectionViewDelegateFlowLayout
   {
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let flowlayout = collectionViewLayout as! UICollectionViewFlowLayout
           
           let spaceBetweenTheCells : CGFloat = (flowlayout.minimumInteritemSpacing ?? 0.0) + (flowlayout.sectionInset.left ?? 0.0) + (flowlayout.sectionInset.right ?? 0.0)
           
           let size = (usersCollectionView.frame.width - spaceBetweenTheCells) / 2.0
           
           return CGSize(width: size, height: size)
       }
   }
