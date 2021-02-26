//
//  ViewController.swift
//  Json.Swift
//
//  Created by aydoğan pederli on 26.02.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var cadLabel: UILabel!
    
    @IBOutlet weak var chfLabel: UILabel!
    
    @IBOutlet weak var cbpLabel: UILabel!
    
    @IBOutlet weak var jpyLabel: UILabel!
    
    @IBOutlet weak var usdLabel: UILabel!
    
    @IBOutlet weak var tryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesButton(_ sender: Any) {
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=2c9f3517e27c67564e154038ba789f50&format=1")
        
        let session = URLSession.shared
        
        //Closure - CallbackFunction
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                
                alert.addAction(okButton)
                
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                if data != nil {
                    
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String , Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any]{
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                             
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"

                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"

                                }
                                
                                if let trylab = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(trylab)"

                                }
                            }
                                
                           
                        
                        }
                    } catch  {
                        print("error")
                    }
                    
                    
                }
            }
        }
        task.resume()
    }
    
}
