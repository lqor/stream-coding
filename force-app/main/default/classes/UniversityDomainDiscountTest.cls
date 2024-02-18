@IsTest
public with sharing class UniversityDomainDiscountTest {
   @IsTest
    static void testUniversityDomainDiscount() {
        Test.setMock(HttpCalloutMock.class, new UniversityDomainDiscountMock());
        Contact contact = new Contact();
        contact.FirstName = 'Test';
        contact.LastName = 'Test';
        contact.Email = 'test@' + UniversityDomainDiscountMock.domain;

        Education_Discount__mdt discountRecord = [
            SELECT Id, Discount__c
            FROM Education_Discount__mdt
            WHERE DeveloperName = 'Standard_Discount'
            LIMIT 1
        ];

        Decimal expectedDiscount = discountRecord.Discount__c;

        Test.startTest();
        insert contact;
        Test.stopTest();

        contact = [SELECT Id, Discount__c FROM Contact WHERE Id = :contact.Id];

        Assert.areEqual(expectedDiscount, contact.Discount__c, 'Discount not applied');
    }
}