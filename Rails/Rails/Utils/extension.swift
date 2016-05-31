import PerfectLib  
  
extension WebRequest {  
    var action: String {  
        return urlVariables["action"] ?? "index"  
    }  
    var acceptJson: Bool {  
        return httpAccept().contains("application/json")  
    }  
}  
  
extension WebResponse {  
    func render(templatePath: String, values: MustacheEvaluationContext.MapType) throws -> String {  
        let fullPath = "./webroot/"+templatePath  
        let file = File(fullPath)  
        
        print(fullPath)
          
        try file.openRead()  
        defer { file.close() }  
        let bytes = try file.readSomeBytes(file.size())  
          
        let parser = MustacheParser()  
        let str = UTF8Encoding.encode(bytes)  
        let template = try parser.parse(str)  
          
        let context = MustacheEvaluationContext(map: values)  
        context.filePath = file.path()  
        let collector = MustacheEvaluationOutputCollector()  
        try template.evaluatePragmas(context, collector: collector, requireHandler: false)  
        template.evaluate(context, collector: collector)  
        return collector.asString()  
    }  
      
    func renderHTML(templatePath: String, values: MustacheEvaluationContext.MapType) throws {  
        let responsBody = try render(templatePath, values: values)  
        appendBodyString(responsBody)  
        addHeader("Content-type", value: "text/html")  
    }  
      
    func outputJson(values: [String:JSONValue]) throws {  
        addHeader("content-type", value: "application/json")  
        let encoded = try values.jsonEncodedString()  
        appendBodyString(encoded)  
    }  
}  