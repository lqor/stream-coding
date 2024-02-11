public with sharing class OpenAICallout {

  public class OpenAIException extends Exception {}

  public static final String ENDPOINT = 'https://api.openai.com/v1/chat/completions';
  public static final String POST = 'POST';
  
  public static final String CONTENT_TYPE_KEY = 'Content-Type';
  public static final String CONTENT_TYPE_VALUE = 'application/json';

  public static final String AUTHORIZATION_KEY = 'Authorization';
  public static final String AUTHORIZATION = 'Bearer ';

  public static final String STANDARD_PROMT_DEV_NAME = 'Standard_Prompt';
  public static final String STANDARD_KEY_DEV_NAME = 'Standard_Key';

  public static final String SYSTEM_ROLE = 'system';
  public static final String USER_ROLE = 'user';

  public String makeCallout(String code) {
    if(code == null) {
      throw new OpenAIException('Code cannot be empty');
    }
    String apiKey = queryKey();
    String requestBody = createOpenAIRequest(code);

    HttpRequest request = formRequest(apiKey, requestBody);
    Http http = new Http();
    HTTPResponse response = http.send(request);

    String contentToReturn = parseResponse(response.getBody());

    return contentToReturn;  
  }

  public HttpRequest formRequest(String apiKey, String requestBody) {
    HttpRequest request = new HttpRequest();

    request.setEndpoint(ENDPOINT);
    request.setMethod(POST);
    request.setHeader(CONTENT_TYPE_KEY, CONTENT_TYPE_VALUE);
    request.setHeader(AUTHORIZATION_KEY, AUTHORIZATION + apiKey);
    request.setBody(requestBody);

    return request;
  }

  public String parseResponse(String responseString) {
    OpenAIResponse aiResponse = (OpenAIResponse) JSON.deserialize(responseString, OpenAIResponse.class);
    return aiResponse.choices.get(0).message.content;
  }

  public String createOpenAIRequest(String code) {    
    Prompt__mdt prompt = queryPrompt();

    OpenAIRequest message = new OpenAIRequest();
    message.model = prompt.Model__c;
    message.messages = new List<Message>();
    message.messages.add(new Message(SYSTEM_ROLE, prompt.AssistantDescription__c));
    message.messages.add(new Message(USER_ROLE, code));

    return JSON.serialize(message);
  }

  public String queryKey() {
    OpenAI_Credential__mdt openAI = [
      SELECT DeveloperName, ApiKey__c  
      FROM OpenAI_Credential__mdt 
      WHERE DeveloperName = :STANDARD_KEY_DEV_NAME
      LIMIT 1
    ];

    return openAI.ApiKey__c;
  }

  public Prompt__mdt queryPrompt() {
    return [
      SELECT AssistantDescription__c, Model__c  
      FROM Prompt__mdt 
      WHERE DeveloperName = :STANDARD_PROMT_DEV_NAME
      LIMIT 1
    ];
  }

  class OpenAIRequest {
    public String model;
    public List<Message> messages;

    public OpenAIRequest() {}
  }

  class Message {
    public String role;
    public String content;

    public Message(String role, String content) {
      this.role = role;
      this.content = content;
    }
  }

  class OpenAIResponse {
    public String model;
    public List<Choice> choices;
  }

  class Choice {
    public Message message;
  }
}