public with sharing class ContactTriggerHandler {
    public static void afterInsert(List<Contact> newList, Map<Id, Contact> newMap) {
        ContactService service = new ContactService();
        service.checkEmailForDiscount(newList);
    }

    public static void afterUpdate(
        List<Contact> newList, 
        Map<Id, Contact> newMap, 
        List<Contact> oldList, 
        Map<Id, Contact> oldMap
    ) {
        ContactService service = new ContactService();
        service.checkUpdatedEmailForDiscount(newList, oldMap);
    }
}