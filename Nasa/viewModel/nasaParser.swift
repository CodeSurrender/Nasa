//
//  nasaParser.swift
//  Nasa
//
//  Created by Cole on 23/06/2022.
//  Copyright © 2022 Cole. All rights reserved.
//

import Foundation
import UIKit

struct nasaParser{
    
    
    // Retrieve Data From API
    
        func parse(comp : @escaping ([Item])->()){
        
        print("loading...")
        let api = URL(string: "https://images-api.nasa.gov/search?q=%22%22")
        
        URLSession.shared.dataTask(with: api!){
            data, response, error in
            
    //Error Checking
            
            if error != nil{
                
                alertTitleGlobal = "Connection error"
                alertMessageGlobal = "Please check your internet connection or link"
                selfController.showAlert(alertText: alertTitleGlobal, alertMessage: alertMessageGlobal)
                alertOptionGlobal = "Retry"
                print(error?.localizedDescription)
                return

            }
            
    //JSON Decoding
            
            do {
                let result = try JSONDecoder().decode(Content.self , from: data!)
                comp(((result.collection?.items)!))
                print(result)
            } catch {
                print("decoding error...")
                
                alertTitleGlobal = "JSON decoding error"
                alertMessageGlobal = "Please check your internet connection"
                selfController.showAlert(alertText: alertTitleGlobal, alertMessage: alertMessageGlobal)
                alertOptionGlobal = "Retry"
                
            }
        }.resume()
        
    }
    
}

