public class AccountTriggerHandler extends TriggerHandler {
    List<Account> accountList;

    public AccountTriggerHandler() {
        this.accountList = (List<Account>) Trigger.new;
    }

    public override void beforeInsert() {
        for(Account acctRec : accountList){
            /* This if condition sets Account Rating to 'Hot' when Phone, Website, Fax are not NULL */
            if(!String.isBlank(acctRec.Phone) && !String.isBlank(acctRec.WebSite) && !String.isBlank(acctRec.Fax)){
                acctRec.Rating = 'Hot';
            }

            /* This if condition copies Shipping Address to Billing Address when all fields of Shipping Address are not NULL */
            if(!String.isBlank(acctRec.ShippingStreet) && !String.isBlank(acctRec.ShippingCity) && !String.isBlank(acctRec.ShippingState) 
                && !String.isBlank(acctRec.ShippingPostalCode) && !String.isBlank(acctRec.ShippingCountry)) {
            acctRec.BillingStreet = acctRec.ShippingStreet;
            acctRec.BillingCity = acctRec.ShippingCity;
            acctRec.BillingState = acctRec.ShippingState;
            acctRec.BillingPostalCode = acctRec.ShippingPostalCode;
            acctRec.BillingCountry = acctRec.ShippingCountry;
        }

        /* This if condition sets Account Type as 'Prospect' for all accounts whose Type is not specified during inserting the record */
        if(String.isBlank(acctRec.type)) {
            acctRec.type = 'Prospect';
        }
        }
    }
/*
    public override void beforeUpdate() {
        
    }

    public override void beforeDelete() {
        
    }
*/
    public override void afterInsert() {
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

 /*   public override void afterUpdate() {
        
    }

    public override void afterDelete() {
        
    }

    public override void afterUndelete() {
        
    } */
}