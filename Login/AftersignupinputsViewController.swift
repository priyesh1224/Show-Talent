//
//  AftersignupinputsViewController.swift
//  ShowTalent
//
//  Created by maraekat on 05/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import CoreLocation
import NetworkExtension

 struct InterfaceNames {
    static let wifi = ["en0"]
    static let wired = ["en2", "en3", "en4"]
    static let cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
    static let supported = wifi + wired + cellular
}

class AftersignupinputsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
  
    
    @IBOutlet weak var firstname: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var genderselectedvalue: UILabel!
    
    
    @IBOutlet weak var dobselectedvalue: UILabel!
    
    
    @IBOutlet weak var submitbtn: UIButton!
    
    
    @IBOutlet weak var popupview: UIView!
    
    @IBOutlet weak var popupviewokbtn: UIButton!
    
    
    @IBOutlet weak var dobpicker: UIDatePicker!
    
    @IBOutlet weak var genderpicker: UIPickerView!
    
    
    var choosengender = ""
    var choosendate = ""
    var genders = ["male","female"]
    
    var senddetails : ((_ latt : CLLocationDegrees,_ lon : CLLocationDegrees,_ city :String,_ coun : String ) -> Void)?
    
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.submitbtn.layer.cornerRadius = 20
        self.popupviewokbtn.layer.cornerRadius = 20
        self.popupview.isHidden = true
        genderpicker.delegate = self
        genderpicker.dataSource = self
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
        var d = Date()
        
        self.dobpicker.setDate(d, animated: true)
        
        if let fn = UserDefaults.standard.value(forKey: "firstname") as? String {
            self.firstname.text = fn
        }
        
        if let ln = UserDefaults.standard.value(forKey: "lastname") as? String {
            self.lastname.text = ln
        }
        
        if let gen = UserDefaults.standard.value(forKey: "gender") as? String {
            self.choosengender = gen.lowercased()
            if choosengender == "male" {
                self.genderpicker.selectRow(0, inComponent: 0, animated: true)
            }
            else if choosengender == "female" {
                self.genderpicker.selectRow(1, inComponent: 0, animated: true)

            }
            self.genderselectedvalue.text = self.choosengender.capitalized
        }
        
        if let d = UserDefaults.standard.value(forKey: "dob") as? String {
            var usefuldate = ""
                if d != "" || d != " " {
                    var arr = d.components(separatedBy: "T")
                    if arr.count == 2 {
                        usefuldate = arr[0]
                    }
                    else if d.count == 10 {
                        usefuldate = d
                    }
                }
            
            var d = ""
            var m = ""
            var y = ""
            if usefuldate != "" {
                var darr = usefuldate.components(separatedBy: "-")
                y = darr[0]
                m = darr[1]
                d = darr[2]
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/yyyy/dd"
            if let cusdate = formatter.date(from: "\(m)/\(y)/\(d)") as? Date {
                self.dobselectedvalue.text = "\(d)/\(m)/\(y)"
                self.dobpicker.date = cusdate
            }
        }
        
        


       
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.genders.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.genders[row].capitalized
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
    
    @IBAction func changegenderpressed(_ sender: UIButton) {
        self.genderpicker.isHidden = false
        self.dobpicker.isHidden = true
        self.popupview.isHidden = false
    }
    
    
    @IBAction func changedobpressed(_ sender: UIButton) {
        var d = Date()
        
        self.dobpicker.setDate(d, animated: false)
        self.genderpicker.isHidden = true
        self.dobpicker.isHidden = false
        self.popupview.isHidden = false
    }
    

    @IBAction func submitbtnpressed(_ sender: UIButton) {
        if firstname.text == "" || lastname.text == "" || choosengender == "" || choosendate == "" {
                   print("All fields are required")
                   return
               }
        
        
        var lat = CLLocationDegrees(exactly: 0)
               var longi = CLLocationDegrees(exactly: 0)
               
               locationManager.requestWhenInUseAuthorization()
               var currentLoc: CLLocation?
               if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
               CLLocationManager.authorizationStatus() == .authorizedAlways) {
                  currentLoc = locationManager.location
                if let ll = currentLoc as? CLLocation {
                    if let cc = currentLoc?.coordinate as? CLLocationCoordinate2D {
                       if let l = cc.latitude as? CLLocationDegrees {
                           lat = l
                       }
                       if let lo = cc.longitude as? CLLocationDegrees {
                           longi = lo
                       }
                    }
                }
                    
            
                  
                   
               }
               var cy = ""
               var conty = ""
               
               var loc = CLLocation(latitude: lat!, longitude: longi!)
               loc.fetchCityAndCountry { city, country, error in
                if let c = city as? String,let co = country as? String {
                    cy = c
                    conty = co
                    self.senddetails!(lat!,longi!,cy,conty)
                }
                else {
                    self.senddetails!(lat!,longi!,"","")
                }
            
            
                
               }
        
        
        submitdetails()
    }
    
    
    @IBAction func popupokpressed(_ sender: UIButton) {
        if self.genderpicker.isHidden == false {
            choosengender = self.genders[genderpicker.selectedRow(inComponent: 0)]
            self.genderselectedvalue.text = choosengender.capitalized
        }
        else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
             choosendate = dateFormatter.string(from: dobpicker.date)
            
            self.dobselectedvalue.text = choosendate
        }
        self.popupview.isHidden = true
    }
    
    
    @IBAction func popupclosepressed(_ sender: UIButton) {
        self.popupview.isHidden = true
    }
    
    
    
    
    
    func submitdetails()
    {
       
        
        self.senddetails = { lat,longi,cy,conty in
       
        var ver = ""
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            ver = version
        }
        
        var userid = UserDefaults.standard.value(forKey: "refid")
            print("Already userid ")
            print(userid)
            self.spinner.isHidden = false
            self.spinner.startAnimating()
            self.submitbtn.isEnabled = false
        
            let params : Dictionary<String,String> = ["Ref_Guid":"\(userid!)","FirstName":"\(self.firstname.text!)","LastName":"\(self.lastname.text!)","CreateOn":"\(Date().description)","LastUpdate":"\(Date().description)","ProfileImg":"","Gender":"\(self.choosengender)","Dob":"\(self.choosendate)","Address1":"","Address2":"","City":"\(cy)","State":"","Country":"\(conty)","Location":"","Latitude":"\(lat)","Longitude":"\(longi)","IP":"\(self.getIPAddress())","Device":"\(UIDevice.current.localizedModel)","AppVersion":"\(ver)"]
               
               print(params)
                  
  
                  
                  var url = Constants.K_baseUrl + Constants.addProf
                  var r = BaseServiceClass()
                  r.postApiRequest(url: url, parameters: params) { (data, err) in
                   if(err != nil) {
                       print(err)
                    self.submitbtn.isEnabled = true
                    self.spinner.isHidden = true
                    self.spinner.stopAnimating()
                   }
                      if let resv = (data?.result.value) as? Dictionary<String,AnyObject> {
                      
                        if let ans = resv["ResponseStatus"] as? Int {
                            if ans == 0 {
                                UserDefaults.standard.set("\(self.firstname.text!)", forKey: "firstname")
                                UserDefaults.standard.set("\(self.lastname.text!)", forKey: "lastname")
                                UserDefaults.standard.set("\(self.genderselectedvalue.text?.lowercased())", forKey: "gender")
                                UserDefaults.standard.set("\(self.dobselectedvalue.text)T00:00:00", forKey: "dob")
                                UserDefaults.standard.setValue("\(self.firstname.text!) \(self.lastname.text!)" as? String, forKey: "name")
                                self.submitbtn.isEnabled = true
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()

                                self.performSegue(withIdentifier: "logintodashboard", sender: nil)
                                print("Add on done")
                            }
                            else {
                                self.submitbtn.isEnabled = true
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()

                                print("Failed")
                            }
                        }

                      }

                  }

        }
        
    }
    
    
    func getIPAddress() -> String {
         var ipAddress: String?
                var ifaddr: UnsafeMutablePointer<ifaddrs>?

                if getifaddrs(&ifaddr) == 0 {
                    var pointer = ifaddr

                    while pointer != nil {
                        defer { pointer = pointer?.pointee.ifa_next }

                        guard
                            let interface = pointer?.pointee,
                            interface.ifa_addr.pointee.sa_family == UInt8(AF_INET) || interface.ifa_addr.pointee.sa_family == UInt8(AF_INET6),
                            let interfaceName = interface.ifa_name,
                            let interfaceNameFormatted = String(cString: interfaceName, encoding: .utf8),
                            InterfaceNames.supported.contains(interfaceNameFormatted)
                            else { continue }

                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))

                        getnameinfo(interface.ifa_addr,
                                    socklen_t(interface.ifa_addr.pointee.sa_len),
                                    &hostname,
                                    socklen_t(hostname.count),
                                    nil,
                                    socklen_t(0),
                                    NI_NUMERICHOST)

                        guard
                            let formattedIpAddress = String(cString: hostname, encoding: .utf8),
                            !formattedIpAddress.isEmpty
                            else { continue }

                        ipAddress = formattedIpAddress
                        break
                    }

                    freeifaddrs(ifaddr)
                }

        return ipAddress ?? ""
            }
        
        
        
    }
    
    
    
    



extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
