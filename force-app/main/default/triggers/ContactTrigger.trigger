trigger ContactTrigger on Contact (after insert, after update) {
    if(Trigger.isAfter && Trigger.isInsert) {
        ContactTriggerHandler.afterInsert(Trigger.new, Trigger.newMap);
    }

    if(Trigger.isAfter && Trigger.isUpdate) {
        ContactTriggerHandler.afterUpdate(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
    }
}