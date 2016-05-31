import PerfectLib  

  
class HomeController: Controller {   
    
      
    override func Action(action: String) throws -> IActionResult {  
          
        switch request.action {  
        case "about" :  
            return try About()  
        default:  
            return try Index()  
        }  
          
    }  
    
      
    func Index() throws -> IActionResult{ 
        
        
        var values = [String: Any]() 
        
        values["str"]="Hi This is let Perfect like more Rails";
            
        return .View(templatePath: "Views/Home/Index.mustache", values: values)  
    }  
      
    func About() throws -> IActionResult{ 
        
        
        var values = [String: Any]()  
          
        return .View(templatePath: "Views/Home/About.mustache", values: values)  
    }  
      
      
} 