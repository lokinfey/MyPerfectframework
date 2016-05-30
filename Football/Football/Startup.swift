import PerfectLib  
  
public func PerfectServerModuleInit() {  
      
    Routing.Handler.registerGlobally(); 
    
    Routing.Routes["GET", ["/Content/*/*/*"]] = { _ in return StaticFileHandler() } 
    Routing.Routes["GET", ["/","/Home/{action}"] ] = { _ in return HomeController() }  
      
      
}