// Query metdata OpenAI_Credential__mdt Standard_Key
OpenAI_Credential__mdt openAI = [
  SELECT DeveloperName, ApiKey__c  
  FROM OpenAI_Credential__mdt 
  WHERE DeveloperName = 'Standard_Key'
  LIMIT 1
];

HttpRequest request = new HttpRequest();
request.setEndpoint('https://api.openai.com/v1/chat/completions');
request.setMethod('POST');
request.setHeader('Content-Type', 'application/json');
request.setHeader('Authorization', 'Bearer' + openAI.ApiKey__c);
request.setBody('{"model": "gpt-3.5-turbo", "messages": [{"role": "system", "content": "You are a helpful assistant."}]}');

Http http = new Http();
HTTPResponse response = http.send(request);
System.debug(response.getBody());
