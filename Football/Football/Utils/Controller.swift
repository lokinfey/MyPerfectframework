import PerfectLib  
  
class Controller : RequestHandler{  
      
      
    enum IActionResult {  
        case View(templatePath: String?, values: [String: Any])  
        case Redirect(url: String)  
        case Error(status: Int, message: String)  
    }  
      
      
    var request: WebRequest!  
    var response: WebResponse!  
      
      
    func handleRequest(request: WebRequest, response: WebResponse) {  
        self.request = request  
        self.response = response  
          
          
          
        defer {  
            response.requestCompletedCallback()  
        }  
          
        do{  
          
        switch try Action(request.action) {  
        case let .View(templatePath, responseValues):  
            let values = responseValues  
            if request.acceptJson {  
                try response.outputJson(values)  
            } else if let templatePath = templatePath {  
                try response.renderHTML(templatePath, values: values)  
            }  
        case let .Redirect(url):  
            response.redirectTo(url)  
        case let .Error(status, message):  
            response.setStatus(status, message: message)  
            break;  
        }  
        }catch let e {  
            print(e)  
        }  
    }  
      
    func Action(action: String) throws -> IActionResult {  
        return .Error(status: 500, message: "need implement")  
    }  
      
} 