//
//  JWNewsVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by 李青松 on 2023/7/22.
//  Copyright © 2023 Redrock. All rights reserved.
//

//import UIKit
//import FluentDarkModeKit
//
//class JWZXNewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
////    var jwzxNewsModel: JWZXNewsModel?
////    var topView: 
//    var jwzxNewsTableView: UITableView?
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.view.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#F2F3F8") ?? .white , dark: UIColor(hexString: "#000000") ?? .black)
//        self.navigationController?.navigationBar.isHidden = true
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
////        self.view.addSubview(self.topView!)
//        self.view.addSubview(self.jwzxNewsTableView!)
//        
//        self.requestData()
//    }
//    
//    init(rootModel: JWZXSectionNews) {
//        self.jwzxNewsModel = JWZXNewsModel(rootNews: rootModel)
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func requestData() {
//        self.jwzxNewsModel?.requestMoreSuccess({ (hadMore) in
//            if hadMore {
//                self.jwzxNewsTableView?.reloadData()
//            }
//        }) { (error) in
//            
//        }
//    }
//    
//    func JWZXNewVC_pop() {
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    // MARK: - UITableViewDataSource
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.jwzxNewsModel?.sectionNewsAry?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.jwzxNewsModel?.sectionNewsAry?[section].newsAry?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let aNew = self.jwzxNewsModel?.sectionNewsAry?[indexPath.section].newsAry?[indexPath.row]
//        
//        let cell = self.jwzxNewsTableView?.dequeueReusableCell(withIdentifier: JWZXNewsCellReuseIdentifier) as? JWZXNewsCell
//        if cell == nil {
//            let newCell = JWZXNewsCell(style: .default, reuseIdentifier: JWZXNewsCellReuseIdentifier)
//            return newCell
//        }
//        
//        if let aNew = aNew {
//            cell?.showNews(withTimeString: aNew.date, withDetail: aNew.title)
//        }
//        
//        return cell!
//    }
//    
//    // MARK: - UITableViewDelegate
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let aNew = self.jwzxNewsModel?.sectionNewsAry?[indexPath.section].newsAry?[indexPath.row] {
//            let vc = NewDetailViewController(newsID: aNew.NewsID, date: aNew.date, title: aNew.title)
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 86
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let sectionNewsAry = self.jwzxNewsModel?.sectionNewsAry, indexPath.section == sectionNewsAry.count - 1,
//           let newsAry = sectionNewsAry[indexPath.section].newsAry, indexPath.row == newsAry.count - 1 {
//            self.requestData()
//        }
//    }
//}
