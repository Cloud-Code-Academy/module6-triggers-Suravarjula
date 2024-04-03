trigger CheckIndustryOnOpportunityDeletion on Opportunity (before delete) {
    Set<Id> oppAccountIds = new Set<Id>();
    for(Opportunity oppRec : Trigger.old) {
       oppAccountIds.add(oppRec.AccountId);
    }

    List<Account> bankingAccounts = [SELECT Id from Account where Id in :oppAccountIds and Industry = 'Banking'];
    
    if(bankingAccounts.size() > 0) {
        for(Opportunity oppRec : Trigger.old) {
            if(oppRec.StageName == 'Closed Won') {
                oppRec.Name.addError(Label.Prevent_Opportunity_Deletion_For_Banking);
            }
        }
    }
}