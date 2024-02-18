@isTest
public with sharing class AiCodeAnalyzerControllerTest {
  @isTest
  static void testCallout_Positive() {
    Test.setMock(HttpCalloutMock.class, new OpenAICalloutMock());

    Test.startTest();
    String responseString = AiCodeAnalyzerController.analyzeCode('class Car {}');
    Test.stopTest();

    Assert.isTrue(responseString.contains(OpenAICalloutMock.reponseString));
  }
}