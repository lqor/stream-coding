public with sharing class UniversityDomainListCallout {
    public static final String GET = 'GET';
    public static final String ENDPOINT = 'http://universities.hipolabs.com/';
    public static final String SEARCH_DOMAIN = 'search?domain=';

    public Boolean checkDiscount(Contact contactToCheck) {
        String emailDomain = parseDomainFromEmail(contactToCheck.Email);

        HttpRequest request = new HttpRequest();
        request.setEndpoint(ENDPOINT + SEARCH_DOMAIN + emailDomain);
        request.setMethod(GET);

        Http http = new Http();
        HTTPResponse response = http.send(request);

        return response.getBody()?.contains(emailDomain);
    }

    private String parseDomainFromEmail(String email) {
        return email.substring(email.indexOf('@') + 1);
    }
}