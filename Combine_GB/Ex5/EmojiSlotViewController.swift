//
//  EmojiSlotViewController.swift
//  Combine_TestAPI
//
//  Created by Александра Макей on 03.01.2024.
//

import UIKit
import Combine

class EmojiSlotViewController: UIViewController {
    //MARK: - Properties
    var emojis = ["🍎", "🍌", "🍒", "🍇", "🍊", "🍋", "🍓", "🍑", "🍍", "🍈", "🍏", "🍐", "🍉", "🍅", "🍆", "🥭"]
    var timer: AnyCancellable?
    //MARK: - UI components
    var labels: [UILabel] = []
    var startStopButton: UIButton!
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        setupButton()
    }
    //MARK: -  Setup UI
    func setupLabels() {
        for i in 0..<3 {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 50)
            label.translatesAutoresizingMaskIntoConstraints = false
            labels.append(label)
            view.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                label.widthAnchor.constraint(equalToConstant: 50),
                label.heightAnchor.constraint(equalToConstant: 50),
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: CGFloat(i * 70 - 70)),
            ])
        }
    }
    
    func setupButton() {
        startStopButton = UIButton(type: .system)
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        startStopButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startStopButton)
        
        NSLayoutConstraint.activate([
            startStopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startStopButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
    }
    //MARK: - Actions
    @objc func startStopButtonTapped() {
        if timer == nil {
            startSlotMachine()
            startStopButton.setTitle("Stop", for: .normal)
        } else {
            stopSlotMachine()
            startStopButton.setTitle("Start", for: .normal)
        }
    }
    
    func startSlotMachine() {
        var showIdenticalEmojis = false
        timer = Timer.publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .map { _ in self.emojis.shuffled() }
            .sink { [weak self] shuffledEmojis in
                self?.labels.enumerated().forEach { index, label in
                    if showIdenticalEmojis && index != 0 {
                        label.text = shuffledEmojis[0]
                    } else {
                        label.text = shuffledEmojis[index]
                    }
                }
                
                let randomValue = Int.random(in: 1...15)
                if randomValue == 3 {
                    showIdenticalEmojis.toggle()
                }
            }
    }
    
    func stopSlotMachine() {
        timer?.cancel()
        timer = nil
        checkForWin()
    }
    
    func checkForWin() {
        if Set(labels.map { $0.text ?? "" }).count == 1 {
            showAlert(title: "WINER!", message: "Congratulations!")
        } else {
            showAlert(title: "LOSER!", message: "Try again!")
        }
    }
    //MARK: - Alerts
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
