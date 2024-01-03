//
//  ViewController.swift
//  Combine_TestAPI
//
//  Created by Александра Макей on 03.01.2024.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
     
         let button2 = createButton(title: "Exercise 4+6", tag: 1)
         let button3 = createButton(title: "Exercise 5", tag: 2)

         view.addSubview(button2)
         view.addSubview(button3)

         NSLayoutConstraint.activate([
             button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             button2.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),

             button3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 20)
         ])
     }
    func createButton(title: String, tag: Int) -> UIButton {
           let button = UIButton(type: .system)
           button.setTitle(title, for: .normal)
           button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
           button.tag = tag
           return button
       }

    @objc func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            let viewController = TestAPIViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 2:
            let viewController = EmojiSlotViewController()
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}
