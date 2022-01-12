//
//  Constants.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 21/08/2021.
//

import UIKit
import Alamofire

//if let appDomain = Bundle.main.bundleIdentifier {
//UserDefaults.standard.removePersistentDomain(forName: appDomain)
// }

typealias Parameters = [String: String]
typealias alertHandler = ((UIAlertAction)->Void)?
struct Endpoint {
    
    static var baseURL: String {
        #if DEBUG
        let url = "http://18.119.55.236:2000/api/v1/denetkas/"
        #else
        let url = "http://18.119.55.236:2000/api/v1/denetkas/"
        #endif
        return  url
    }
    static var authToken: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "authToken")
        } get {
            UserDefaults.standard.value(forKey: "authToken") as? String
        }
    }
    static var headers: HTTPHeaders {
        return [HTTPHeader(name: "Authorization", value: authToken ?? "")]
    }
    
    
    static var register: URL {
        return URL(string: baseURL + Path.register.rawValue)!
    }
    
    static var login: URL {
        return URL(string: baseURL + Path.login.rawValue)!
    }
    
    static var profile: URL {
        return URL(string: baseURL + Path.profile.rawValue)!
    }
    
    static var allDanetkas: URL {
        return URL(string: baseURL + Path.allDanetkas.rawValue)!
    }
    
    static var myDanetka: URL{
        if Endpoint.authToken != nil {
            return URL(string: baseURL + Path.myDanetkas.rawValue)!
        } else {
            return URL(string: baseURL + Path.myDanetkasFree.rawValue)!
        }
        
    }
    
    static var makeDanetkas: URL {
        return URL(string: baseURL + Path.makeDanetkas.rawValue)!
    }
    
    static var baseURLImage: URL {
        return URL(string: "http://18.119.55.236:2000/images/")!
    }
    
    static var moreDanetka: URL{
        return URL(string: baseURL + Path.moreDanetkas.rawValue)!
    }
    
    enum Path: String {
        case register = "add/user/email"
        case login = "login"
        case profile = "add/user/profile"
        case allDanetkas = "fetch/danetkas"
        case myDanetkasFree = "fetch/free/danetkas"
        case myDanetkas = "fetch/user/danetkas"
        case moreDanetkas = "fetch/all/danetkas"
        case makeDanetkas = "add/master/danetkas"
    }
    
}


//MARK:- ALL STORYBOARD IDENTIFIERS
enum StoryboardIdentifiers: String {
    case LoginVC
    case SignupVC
    case MainDashboardVC
    case SettingsVC
    case PlayVC
    case DanetkasVC
    case DictionaryVC
    case RatingVC
    case ContactVC
    case AboutUsVC
    case LanguageVC
    case FAQVC
    case PrivacyVC
    case MyDanetkaVC
    case PaymentVC
    case CreditCardVC
    case ProfileVC
    case RulesVC
    case LearnMoreVC
    case AnswerVC
    case BundleDiscountVC
}

//MARK:- STORYBOARD NAMES
enum Storyboards: String {
    case Authentication
    case Dashboard
    case Play
    case Settings
    case Payment
    case Profile
}

struct Constant {
    
    //MARK:- APP CONSTANTS
    static let title = "Danetkas"
    
    //MARK:- APP THEME COLOR
    static let orange = UIColor(red: 232/255, green: 145/255, blue: 81/255, alpha: 1)
    static let blue = UIColor(red: 26/255, green: 88/255, blue: 118/255, alpha: 1)
    static let red = UIColor(red: 157/255, green: 54/255, blue: 48/255, alpha: 1)
    //fb4197350706969500
    
    
    static let GOOGLE_CLIENT_ID = "1088908408118-fgjg9rpn21jf95jbect9fuqjfl3fb7hn.apps.googleusercontent.com"
    static let APPLE_PAY_MERCHANT_IDENTIFIER = "merchant.com.armoomragames.denketa"
    //MARK:- FACEBOOK PERMISSIONS
    static let facebookLoginPermissions = ["public_profile","email"]
    
    static let Gender: [String] = ["Male","Female","Other"]
    
    static let Nationality: [String] = ["Afghanistan", "Aland Islands", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Ascension Island", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia & Herzegovina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "British Virgin Islands", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Canary Islands", "Cape Verde", "Caribbean Netherlands", "Cayman Islands", "Central African Republic", "Ceuta", "Chad", "Chile", "China", "Christmas Island", "Clipperton Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo - Brazzaville", "Congo - Kinshasa", "Cook Islands", "Costa Rica", "Cote d'Ivoire", "Croatia","Cuba", "Curacao", "Cyprus", "Czech Republic", "Denmark", "Diego Garcia Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands", "Faroe Islands", "Fiji", "Finland", "France", "French Guiana", "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guernsey", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Heard & McDonald Islands", "Honduras", "Hong Kong (China)", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Isle of Man", "Israel", "Italy", "Jamaica", "Japan", "Jersey", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kosovo", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Melilla", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Myanmar (Burma)", "Namibia", "Nauru", "Nepal", "Netherlands", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "North Korea", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Palestinian Territories", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn Islands", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russia", "Rwanda", "St. Helena", "St. Pierre & Miquelon", "St. Kitts & Nevis", "St. Lucia", "St. Vincent & Grenadines", "Samoa", "San Marino", "Sao Tome & Prfncipe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Sint Maarten", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "So. Georgia & So. Sandwich Isl.", "South Africa", "South Korea", "South Sudan", "Spain", "Sri Lanka", "St. Barthelemy", "Sudan", "Suriname", "Svalbard & Jan Mayen", "Swaziland", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tokelau", "Tonga", "Trinidad & Tobago", "Tristan da Cunha", "Tunisia", "Turkey", "Turkmenistan", "Turks & Caicos Islands", "Tuvalu", "U.S. Virgin Islands", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "Uruguay", "United States", "U.S. Outlying Islands", "Uzbekistan", "Vanuatu", "Vatican City", "Venezuela", "Vietnam", "Wallis & Futuna", "Western Sahara", "Yemen", "Zambia", "Zimbabwe"]
}


enum Poppins: String {
    case Regular          = "Poppins-Regular"
    case Italic           = "Poppins-Italic"
    case Thin             = "Poppins-Thin"
    case ThinItalic       = "Poppins-ThinItalic"
    case ExtraLight       = "Poppins-ExtraLight"
    case ExtraLightItalic = "Poppins-ExtraLightItalic"
    case Light            = "Poppins-Light"
    case LightItalic      = "Poppins-LightItalic"
    case Medium           = "Poppins-Medium"
    case MediumItalic     = "Poppins-MediumItalic"
    case SemiBold         = "Poppins-SemiBold"
    case SemiBoldItalic   = "Poppins-SemiBoldItalic"
    case Bold             = "Poppins-Bold"
    case BoldItalic       = "Poppins-BoldItalic"
    case ExtraBold        = "Poppins-ExtraBold"
    case ExtraBoldItalic  = "Poppins-ExtraBoldItalic"
    case Black            = "Poppins-Black"
    case BlackItalic      = "Poppins-BlackItalic"
}
