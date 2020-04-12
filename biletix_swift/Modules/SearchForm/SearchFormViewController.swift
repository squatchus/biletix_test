//
//  ViewController.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 08.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import UIKit

protocol SearchFormDisplayLogic: class {
    func display(viewModel: SearchForm.ViewModel)
}

protocol SearchFormRoutingLogic {
    func show(fares: [Fare])
    func show(message: String)
}

class SearchFormViewController: UIViewController {

    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var outboundButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var adultsLabel: UILabel!
    @IBOutlet weak var adultsStepper: UIStepper!
    @IBOutlet weak var searchButton: UIButton!
    var datePickerButton: UIButton!
    var defaultBlueColor: UIColor!
    
    let interactor: SearchFormBusinessLogic
    let initialState: SearchForm.InitialState
    
    init(interactor: SearchFormBusinessLogic, initialState: SearchForm.InitialState) {
        self.interactor = interactor
        self.initialState = initialState
        super.init(nibName: "SearchFormViewController", bundle: nil)
        self.title = "Search From"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.display(state: .initial)
    }
    
    // MARK: - Actions
    
    @IBAction func onOutboundButtonPressed(sender: UIButton) {
        fromTextField.endEditing(true)
        toTextField.endEditing(true)
        let date = outboundButton.titleLabel!.text!.asDate
        editOutbound(date: date)
    }

    @IBAction func onReturnButtonPressed(sender: UIButton) {
        fromTextField.endEditing(true)
        toTextField.endEditing(true)
        let date = returnButton.titleLabel!.text!.asDate
        editReturn(date: date)
    }

    @IBAction func onDatePickerValueChanged(sender: UIDatePicker) {
        datePickerButton.setTitle(sender.date.dateString, for: .normal)
    }

    @IBAction func onAdultsStepperValueChanged(sender: UIStepper) {
        adultsLabel.text = "Adults: \(Int(sender.value))"
    }
    
    @IBAction func onSearchButtonPressed(sender: UIButton) {
        display(state: .loading)
        let request = requestFromForm()
        interactor.fetchFares(request: request)
    }
    
    // MARK: - Helpers
    
    func editOutbound(date: Date) {
        datePickerButton = outboundButton
        outboundButton.setTitleColor(.orange, for: .normal)
        returnButton.setTitleColor(defaultBlueColor, for: .normal)
        datePicker.setDate(outboundButton.titleLabel!.text!.asDate, animated: true)
        outboundButton.setTitle(Date.oneWeekFromNow.dateString, for: .normal)
    }
    
    func editReturn(date: Date) {
        datePickerButton = returnButton
        outboundButton.setTitleColor(defaultBlueColor, for: .normal)
        returnButton.setTitleColor(.orange, for: .normal)
        datePicker.setDate(date, animated: true)
        returnButton.setTitle(date.dateString, for: .normal)
    }
    
    func displayInitialState() {
        fromTextField.text = initialState.departurePoint
        toTextField.text = initialState.arrivalPoint
        outboundButton.setTitle(initialState.outboundDate.dateString, for: .normal)
        returnButton.setTitle(initialState.returnDate.dateString, for: .normal)
        datePickerButton = outboundButton
        defaultBlueColor = returnButton.titleColor(for: .normal)!
        adultsStepper.value = Double(initialState.adultCount)
        datePicker.minimumDate = initialState.outboundDate
    }
    
    func showLoader() {
        searchButton.isHidden = true
        activityIndicator.isHidden = false
    }
    
    func hideLoader() {
        searchButton.isHidden = false
        activityIndicator.isHidden = true
    }
    
    func requestFromForm() -> Fares.Show.Request {
        Fares.Show.Request(departurePoint: fromTextField.text!,
                           arrivalPoint: toTextField.text!,
                           outboundDate: outboundButton.titleLabel!.text!.asDate,
                           returnDate: returnButton.titleLabel!.text!.asDate,
                           adultCount: Int(adultsStepper.value))
    }
}

extension SearchFormViewController: SearchFormDisplayLogic {
    
    func display(viewModel: SearchForm.ViewModel) {
        display(state: viewModel.state)
    }
    
    func display(state: SearchForm.State) {
        switch state {
        case .initial:
            displayInitialState()
        case .loading:
            showLoader()
        case .error(let message):
            hideLoader()
            show(message: message)
        case .faresNotFound(let message):
            hideLoader()
            show(message: message)
        case .show(let fares):
            hideLoader()
            show(fares: fares)
        }
    }
}

extension SearchFormViewController: SearchFormRoutingLogic {
    
    func show(fares: [Fare]) {
        let faresVC = FaresBuilder().set(fares: fares).build()
        self.navigationController?.pushViewController(faresVC, animated: true)
    }
    
    func show(message: String) {
        self.present(message.asAlert, animated: true)
    }
}

