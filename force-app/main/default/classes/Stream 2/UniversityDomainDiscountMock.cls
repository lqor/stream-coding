public with sharing class UniversityDomainDiscountMock implements HttpCalloutMock {
    public static String domain = 'tum.de';
  
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"domains": ["' + domain + '"]}');
        return response;
    }
  }