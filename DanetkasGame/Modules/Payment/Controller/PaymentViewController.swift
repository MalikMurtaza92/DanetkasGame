//
//  PaymentViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 25/10/2021.
//

import UIKit
import PassKit
import PayPalCheckout

class PaymentViewController: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet var buttonViews: [UIView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonViews.forEach { view in
            view.dropShadow()
            if view.tag == 4 {
                view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.48).cgColor
                view.layer.borderWidth = 0.5
            }
            view.layer.cornerRadius = view.frame.size.height / 2
        }
    }
    
    func setupUI() {
        
    }
    
    @IBAction func payPallButtonPressed(_ sender: UIButton) {
        
        Checkout.setCreateOrderCallback { createOrderAction in
             let amount = PurchaseUnit.Amount(currencyCode: .usd, value: "10.00")
             let purchaseUnit = PurchaseUnit(amount: amount)
             let order = OrderRequest(intent: .capture, purchaseUnits: [purchaseUnit])

             createOrderAction.create(order: order)
         }
        
        Checkout.setOnApproveCallback { approval in
             approval.actions.capture { (response, error) in
                print("Order successfully captured: \(response?.data)")
            }
        }
        
        Checkout.setOnErrorCallback { error in
            // Handle the error generated by the SDK
        }
    }
    
    @IBAction func payButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let VC = DanetkasHelper.getViewController(storyboard: .Payment, identifier: .CreditCardVC)
            self.present(to: VC, completion: nil)
        default:
            break
        }
    }
    
    @IBAction func applePayButtonPressed(_ sender: UIButton) {
        let paymentNetwork = [PKPaymentNetwork.amex,.discover,.visa,.masterCard]
        /*
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetwork) {
            
            let request = PKPaymentRequest()
            request.currencyCode = "EUR"
            request.countryCode = "US"
            request.merchantIdentifier = Constant.APPLE_PAY_MERCHANT_IDENTIFIER
            request.merchantCapabilities = PKMerchantCapability.capability3DS
            request.supportedNetworks = paymentNetwork
            request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Danetka", amount: NSDecimalNumber(value: 10.0))]
            
            guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request) else {
                return
            }
            
            paymentVC.delegate = self
            self.present(paymentVC, animated: true, completion: nil)
            
        } else {
            self.showSimpleAlert(title: Constant.title, message: "Unable to make apple pay transaction.")
        }
        */
        
        let request = PKPaymentRequest()
        request.currencyCode = "EUR"
        request.countryCode = "US"
        request.merchantIdentifier = Constant.APPLE_PAY_MERCHANT_IDENTIFIER
        request.merchantCapabilities = PKMerchantCapability.capability3DS
        request.supportedNetworks = paymentNetwork
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Danetka", amount: NSDecimalNumber(value: 10.0))]
        
        guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request) else {
            return
        }
        
        paymentVC.delegate = self
        self.present(paymentVC, animated: true, completion: nil)
    }

}

//MARK: APPLE PAY DELEGATE
extension PaymentViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
     
        dismiss(animated: true, completion: nil)
    }
    
//    @available(iOS 15.0.0, *)
//    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment) async -> PKPaymentAuthorizationResult {
//
//    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        dismiss(animated: true, completion: nil)
    }
}
