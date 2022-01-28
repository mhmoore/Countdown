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
    
    private var isCalculated: Bool = false
    private var birthDate: Double?
    private var longevityScore: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        longevityScore = 75
        birthDate = Date().timeIntervalSince1970
        
        calculateResetButton.layer.cornerRadius = 8
        longevitySlider.minimumValue = 0
        longevitySlider.maximumValue = 123
        longevitySlider.value = Float(longevityScore!)
        longevityNumberLabel.text = "\(longevityScore!)"
        longevitySliderNumberLabel.text = "\(longevityScore!)"
        lifeProgressView.progress = 0.75
        
    }
    
    @IBAction func longevitySliderChangedValue(_ sender: Any) {
        longevitySliderNumberLabel.text = "\(Int(longevitySlider.value))"
    }
    
    @IBAction func calculateResetButtonTapped(_ sender: Any) {
        save { complete in
            if complete {
                isCalculated ? changeViewToCalculate() : changeViewToCountdown()
                birthDateStackView.isHidden = isCalculated
                sliderStackView.isHidden = isCalculated
                countdownContainerView.isHidden = !isCalculated
            } else {
                print("display error alert")
            }
        }
    }
    
    func setupInitialView() {
        isCalculated ? changeViewToCalculate() : changeViewToCountdown()
    }
    
    func changeViewToCountdown() {
        isCalculated.toggle()
        calculateResetButton.setTitle("Reset", for: .normal)
        longevityScore = Int(longevitySlider.value)
        longevityNumberLabel.text = "\(longevityScore!)"
    }
    
    func changeViewToCalculate() {
        isCalculated.toggle()
        calculateResetButton.setTitle("Calculate!", for: .normal)
    }
    
    func avenirFont(size: CGFloat) -> UIFont {
        guard let avenirFont = UIFont(name: "AvenirNext-DemiBold", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return avenirFont
    }
    
    func save(completion: (_: Bool) -> ()) {
        guard let context = appDelegate?.persistentContainer.viewContext,
              let birthDate = birthDate,
              let longevityScore = longevityScore
        else {
            return
        }
        
        let longevity = Longevity(context: context)
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

