import PerfectLib  
import MySQL

  
class HomeController: Controller {  
    
    let HOST = "perfect.mysqldb.chinacloudapi.cn"  
    let USER = "perfect%demo"  
    let PASSWORD = "1a2b3c4D"  
    let SCHEME = "demo" 
    
    typealias MySQLText = [UInt8]
      
    override func Action(action: String) throws -> IActionResult {  
          
        switch request.action {  
        case "about" :  
            return try About()  
        default:  
            return try Index()  
        }  
          
    }  
    
    
    
    func stringFromMySQLText(text: MySQLText?) -> String? {
        guard let text = text else { return nil }
        return UTF8Encoding.encode(text)
    }
      
    func Index() throws -> IActionResult{  
          
        var values = [String: Any]() 
        
        let mysql = MySQL()  
        let connect = mysql.connect(HOST, user: USER, password: PASSWORD)  
        if(connect)  
        {  
            let sres = mysql.selectDatabase(SCHEME)  
            if(sres)  
            {  
                  
                let sres2 = mysql.query("SELECT id,name,playdate,url FROM football")  
                  
                if(sres2)  
                {  
                    let results = mysql.storeResults()!  
                      
                      
                      
                    if(results.numRows()==0)  
                    {  
                    }  
                    else  
                    {   
                        
                        
				        var ary = [[String:Any]]()
                        
                        
                        while let row = results.next() {  
				
                            ary.append([
                                "id":row[0],
                                "name":row[1],
                                "playdate":row[2],
                                "url":row[3],
                                "img":"../Content/img/cont_top/"+row[0]+".png"
                                ])
                            
                        }  
                        
                        
                        values["list"]=ary 
                          
                          
                          
                    }  
                      
                      
                      
                      
                    results.close()  
                }  
            }  
            else
            {
                print("scheme fail")
            }
            mysql.close()  
        }  
        else
        {
            print("connect fail")
        } 
      
        
            
        return .View(templatePath: "Views/Home/Index.mustache", values: values)  
    }  
      
    func About() throws -> IActionResult{  
          
        var values = [String: Any]()  
          
        values["str"]="Hello kinfey Framework"  
        
        
        print(values["str"]) 
          
        return .View(templatePath: "Views/Home/About.mustache", values: values)  
    }  
      
      
} 