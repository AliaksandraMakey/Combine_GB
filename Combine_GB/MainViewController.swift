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
        for i in 4...8 {
            guard i != 6 else { continue }
            let button = UIButton(type: .system)
            button.setTitle("Exercise \(i)", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.tag = i
            view.addSubview(button)

            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(i * 70 + 40))
            ])
        }
    }

    @objc func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            let viewController = TestAPIViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 2:
            let viewController = EmojiSlotViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 3:
            let viewController = TestAPIViewController()
            navigationController?.pushViewController(viewController, animated: true) 
        case 4:
            let viewController = TestAPIViewController()
            navigationController?.pushViewController(viewController, animated: true) 
        case 5:
            let viewController = TestAPIViewController()
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}
