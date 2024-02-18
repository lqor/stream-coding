public with sharing class ContactService {
    public void checkEmailForDiscount(List<Contact> contacts) {
        Set<Id> contactsIds = (new Map<Id, Contact>(contacts)).keySet();
        List<Contact> relevant = queryContactsByIds(contactsIds);

        DiscountEmailCheckerQueueable emailChecker = new DiscountEmailCheckerQueueable(relevant);
        System.enqueueJob(emailChecker);
    }

    public void checkUpdatedEmailForDiscount(List<Contact> contacts, Map<Id, Contact> oldContacts) {
        List<Contact> relevant = filterContactsByEmailChange(contacts, oldContacts);
        Set<Id> relevantIds = (new Map<Id, Contact>(relevant)).keySet();
        relevant = queryContactsByIds(relevantIds);

        DiscountEmailCheckerQueueable emailChecker = new DiscountEmailCheckerQueueable(relevant);
        System.enqueueJob(emailChecker);
    }

    public List<Contact> filterContactsByEmailChange(List<Contact> contacts, Map<Id, Contact> oldContacts) {
        List<Contact> relevant = new List<Contact>();

        for (Contact contact : contacts) {
            Contact oldContact = oldContacts.get(contact.Id);

            if (oldContact.Email != contact.Email) {
                relevant.add(contact);
            }
        }

        return relevant;
    }

    public List<Contact> queryContactsByIds(Set<Id> ids) {
        return [SELECT Id, Email FROM Contact WHERE Id IN :ids];
    }
}