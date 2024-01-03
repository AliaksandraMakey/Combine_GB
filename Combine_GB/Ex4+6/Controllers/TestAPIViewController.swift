//
//  TestAPIViewController.swift
//  Combine_TestAPI
//
//  Created by Александра Макей on 03.01.2024.
//

import UIKit
import Combine

class TestAPIViewController: UIViewController {
    //MARK: - Properties
    let jsonPlaceholderClient = APIClientService()
    var cancellables: Set<AnyCancellable> = []
    var users: [User] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    //MARK: - UI components
    let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter User ID"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add User", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
   //MARK: -  Setup UI
    func setupUI() {
        view.addSubview(idTextField)
               view.addSubview(addButton)
               
               NSLayoutConstraint.activate([
                   idTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150), // изменено с 50 на 150
                   idTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                   idTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                   
                   addButton.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 10),
                   addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
               ])
               
               addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    //MARK: -  Setup TableView
    func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    //MARK: - Actions
    @objc func addButtonTapped() {
        guard let userIdString = idTextField.text,
              let userId = Int(userIdString) else {
            return
        }
        
        fetchUserData(userId: userId)
    }
    
    func fetchUserData(userId: Int) {
        let userPublisher = jsonPlaceholderClient.fetchUser(userId: userId)
        userPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("User \(userId) publisher finished")
                case .failure(let error):
                    print("User \(userId) publisher failed with error: \(error)")
                }
            }, receiveValue: { user in
                print("Received user \(userId): \(user)")
                self.users.append(user)
            })  
            .store(in: &cancellables)
    }
}
extension TestAPIViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = "User \(user.id): \(user.name)"
        return cell
    }
}
