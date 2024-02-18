public class OpenAICalloutMock implements HttpCalloutMock {
  public static String reponseString = 'Hello there, how may I assist you today?';

  public HTTPResponse respond(HTTPRequest req) {
      HttpResponse response = new HttpResponse();
      response.setHeader('Content-Type', 'application/json');
      response.setBody('{"choices": [{"message": {"role": "assistant", "content": "' + reponseString + '"}}]}');
      return response;
  }
}