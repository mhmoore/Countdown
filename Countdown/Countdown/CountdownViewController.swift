//
//  CountdownViewController.swift
//  Countdown
//
//  Created by Michael Moore on 1/26/22.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class CountdownViewController: UIViewController {
    @IBOutlet private weak var longevityNumberLabel: UILabel!
    @IBOutlet private weak var lifeProgressView: UIProgressView!
    @IBOutlet private weak var birthDateStackView: UIStackView!
    @IBOutlet private weak var birthDateTextField: UITextField!
    @IBOutlet private weak var countdownContainerView: UIView!
    @IBOutlet private weak var yearsNumberLabel: UILabel!
    @IBOutlet private weak var monthsNumberLabel: UILabel!
    @IBOutlet private weak var weeksNumberLabel: UILabel!
    @IBOutlet private weak var daysNumberLabel: UILabel!
    @IBOutlet private weak var hoursNumberLabel: UILabel!
    @IBOutlet private weak var minutesNumberLabel: UILabel!
    @IBOutlet private weak var secondsNumberLabel: UILabel!
    @IBOutlet private weak var sliderStackView: UIStackView!
    @IBOutlet private weak var longevitySlider: UISlider!
    @IBOutlet private weak var longevitySliderNumberLabel: UILabel!
    @IBOutlet private weak var calculateResetButton: UIButton!
    
    let datePicker = UIDatePicker()
    
    private var isCalculated: Bool = false
    private var birthDate: Date = Date()
    private var longevityScore: Int = 75
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        setupInitialView()
    }
    
    @IBAction func longevitySliderChangedValue(_ sender: Any) {
        longevitySliderNumberLabel.text = "\(Int(longevitySlider.value))"
    }
    
    @IBAction func calculateResetButtonTapped(_ sender: Any) {
        isCalculated.toggle()
        
        if isCalculated {
            save { complete in
                if complete {
                    changeViewToCountdown()
                } else {
                    print("display error alert")
                }
            }
        } else {
            changeViewToCalculate()
        }
    }
    
    private func setupInitialView() {
        isCalculated ? changeViewToCountdown() : changeViewToCalculate()
        
        calculateResetButton.layer.cornerRadius = 8
        longevitySlider.minimumValue = 0
        longevitySlider.maximumValue = 123
        longevitySlider.value = Float(longevityScore)
        longevityNumberLabel.text = "\(longevityScore)"
        longevitySliderNumberLabel.text = "\(longevityScore)"
        lifeProgressView.progress = 0.75
    }
    
    private func changeViewToCountdown() {
        longevityScore = Int(longevitySlider.value)
        longevityNumberLabel.text = "\(Int(longevitySlider.value))"
        
        calculateResetButton.setTitle("Reset", for: .normal)
        
        birthDateStackView.isHidden = isCalculated
        sliderStackView.isHidden = isCalculated
        countdownContainerView.isHidden = !isCalculated
    }
    
    private func changeViewToCalculate() {
        calculateResetButton.setTitle("Calculate!", for: .normal)
        
        birthDateStackView.isHidden = isCalculated
        sliderStackView.isHidden = isCalculated
        countdownContainerView.isHidden = !isCalculated
    }
}

// MARK: - Core Data
private extension CountdownViewController {
    func save(completion: (_: Bool) -> ()) {
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        
        let longevity = Longevity(context: context)
        longevity.isCalculated = isCalculated
        longevity.birthDate = birthDate
        longevity.longevityScore = Int32(longevityScore)
        
        do {
            try context.save()
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }
}

// MARK: - Helper Methods
private extension CountdownViewController {
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        return toolbar
    }
    
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        birthDateTextField.text = dateFormatter.string(from: datePicker.date)
        birthDate = datePicker.date
        view.endEditing(true)
    }
    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        birthDateTextField.inputView = datePicker
        birthDateTextField.inputAccessoryView = createToolbar()
    }
    
    func avenirFont(size: CGFloat) -> UIFont {
        guard let avenirFont = UIFont(name: "AvenirNext-DemiBold", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return avenirFont
    }
}
