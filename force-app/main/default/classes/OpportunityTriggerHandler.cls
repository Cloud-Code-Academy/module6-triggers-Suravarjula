public class OpportunityTriggerHandler extends TriggerHandler{
    List<Opportunity> opportunityList;

    public OpportunityTriggerHandler() {
        this.opportunityList = (List<Opportunity>) Trigger.new;
    }

    public override void beforeUpdate() {
        Set<Id> oppIds = Trigger.newMap.keySet();
        Map<Id, Id> accountContact = getCEOContactForAccount(oppIds);

        for(Opportunity oppRec : opportunityList) {
            //oppAccountIds.add(oppRec.AccountId);
            oppRec.Primary_Contact__c = accountContact.get(oppRec.AccountId);
            if(oppRec.Amount <= 5000) {
                oppRec.Amount.addError(Label.Opp_Amount_More_Than_5000);
            }
        }  
    }

    public override void beforeDelete() {
        Set<Id> oppIds = Trigger.oldMap.keySet();
        List<Account> bankingAccounts = getOpportunityAccountsForIndustry(oppIds, 'Banking');
        
        if(bankingAccounts.size() > 0) {
            for(Opportunity oppRec : (List<Opportunity>) Trigger.old) {
                if(oppRec.StageName == 'Closed Won') {
                    oppRec.Name.addError(Label.Prevent_Opportunity_Deletion_For_Banking);
                }
            }
        }
    }

    private Map<Id, Id> getCEOContactForAccount(Set<Id> opportunityIds) {
        Map<Id, Id> accountContact = new Map<Id, Id>();
        for (Contact contactRec : [SELECT Id, AccountId from Contact where AccountId in (SELECT AccountId from Opportunity where Id in :opportunityIds)  and Title = 'CEO']) {
            accountContact.put(contactRec.AccountId, contactRec.Id);
        }
        return accountContact;
    }

    private List<Account> getOpportunityAccountsForIndustry(Set<Id> opportunityIds, String industry) {
        return [SELECT Id from Account where Id in (SELECT AccountId from Opportunity where Id in :opportunityIds) and Industry = :industry];
    }
}