@isTest
public with sharing class OpenAICalloutTest {
  @isTest
  static void testCallout_Positive() {
    Test.setMock(HttpCalloutMock.class, new OpenAICalloutMock());

    OpenAICallout callout = new OpenAICallout();

    Test.startTest();
    String responseString = callout.makeCallout('class Car {}');
    Test.stopTest();

    Assert.isTrue(responseString.contains(OpenAICalloutMock.reponseString));
  }

  @isTest
  static void testCallout_Negative() {
    Test.setMock(HttpCalloutMock.class, new OpenAICalloutMock());

    OpenAICallout callout = new OpenAICallout();

    Test.startTest();

    try {
      callout.makeCallout(null);
      Assert.fail('Expected exception was not thrown');
    } catch (OpenAICallout.OpenAIException e) {}

    Test.stopTest();
  }
}