trigger SetPrimaryContact on Opportunity (before update) {
    Set<Id> oppAccountIds = new Set<Id>();
    for(Opportunity oppRec1 : Trigger.new) {
       oppAccountIds.add(oppRec1.AccountId);
    }

    Map<Id, Id> accountContact = new Map<Id, Id>();
    for(Contact contactRec : [Select Id, AccountId from Contact where AccountId in :oppAccountIds and Title = 'CEO']) {
        accountContact.put(contactRec.AccountId, contactRec.Id);
    }

    for(Opportunity oppRec2 : Trigger.new) {
        oppRec2.Primary_Contact__c = accountContact.get(oppRec2.AccountId);
    }
}