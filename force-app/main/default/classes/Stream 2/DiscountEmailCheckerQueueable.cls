public with sharing class DiscountEmailCheckerQueueable implements Queueable, Database.AllowsCallouts {
    private List<Contact> contactsToCheckDiscount;

    public DiscountEmailCheckerQueueable(List<Contact> contactsToCheckDiscount) {
        this.contactsToCheckDiscount = contactsToCheckDiscount;
    }

    public void execute(QueueableContext context) {
        UniversityDomainListCallout universityDomainListCallout = new UniversityDomainListCallout();

        Education_Discount__mdt discountRecord = [
            SELECT Id, Discount__c
            FROM Education_Discount__mdt
            WHERE DeveloperName = 'Standard_Discount'
            LIMIT 1
        ];

        Decimal discount = discountRecord.Discount__c;

        for(Contact contact : contactsToCheckDiscount) {
            Boolean hasDiscount = universityDomainListCallout.checkDiscount(contact);

            if(hasDiscount) {
                contact.Discount__c = discount;
            } else {
                contact.Discount__c = 0;
            }
        }

        update contactsToCheckDiscount;
    }
}