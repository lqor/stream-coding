String domain = 'tumaini.ac.tz';

HttpRequest request = new HttpRequest();
request.setEndpoint('http://universities.hipolabs.com/search?domain=' + domain);
request.setMethod('GET');
request.setHeader('Content-Type', 'application/json');

Http http = new Http();
HTTPResponse response = http.send(request);
System.debug(response.getBody());
