public with sharing class AiCodeAnalyzerController {
  @AuraEnabled
  public static String analyzeCode(String code) {
    OpenAICallout callout = new OpenAICallout();
    return callout.makeCallout(code); 
  }
}