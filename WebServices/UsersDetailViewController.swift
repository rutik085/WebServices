//
//  UsersDetailViewController.swift
//  WebServices
//
//  Created by Mac on 05/01/24.
//

import UIKit

class UsersDetailViewController: UIViewController {

    @IBOutlet weak var usersImage: UIImageView!
    @IBOutlet weak var userPage: UILabel!
    @IBOutlet weak var perPageImage: UILabel!
    @IBOutlet weak var userTotal: UILabel!
    @IBOutlet weak var userTotalPage: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userFirstName: UILabel!
    @IBOutlet weak var userLastName: UILabel!
    
    var userContainer : Users?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        bindImage()
        
    }
    func fetchData()
    {
        userPage.text = userContainer?.page.description.codingKey.stringValue
        perPageImage.text = userContainer?.per_page.description.codingKey.stringValue
        userTotal.text = userContainer?.total.description.codingKey.stringValue
        userTotalPage.text = userContainer?.total_pages.description.codingKey.stringValue
        
        for i in 0...(userContainer?.data.count)!-1
        {
            userId.text = userContainer?.data[i].id.description.codingKey.stringValue
            userFirstName.text = userContainer?.data[i].first_name.description.codingKey.stringValue
            userLastName.text = userContainer?.data[i].last_name.description.codingKey.stringValue

        }
        
    }
    func bindImage()
    {
        for i in 0...(userContainer?.data.count)!-1
        {
            if let image = userContainer?.data[i].avatar,
               let imageUrl = URL(string: image)
            {
                usersImage.kf.setImage(with: imageUrl)
            }
        }
    }

}
