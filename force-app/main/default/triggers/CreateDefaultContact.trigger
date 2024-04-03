trigger CreateDefaultContact on Account (after insert) {
    List<Contact> defContactList = new List<Contact>();
    Set<Id> accountIds = Trigger.newMap.keySet();

    for(Id acctId : accountIds) {
        Contact defContactRec = new Contact(LastName = 'DefaultContact', Email = 'default@email.com', AccountId = acctId);
        defContactList.add(defContactRec);
    }
    Database.DMLOptions dml = new Database.DMLOptions();
    dml.DuplicateRuleHeader.AllowSave = true;
    Database.insert(defContactList, dml);
}