trigger CopyShippingAddressToBilling on Account (before insert) {
    for(Account acctRec : Trigger.new) {
        if(!String.isBlank(acctRec.ShippingStreet) && !String.isBlank(acctRec.ShippingCity) && !String.isBlank(acctRec.ShippingState) 
                && !String.isBlank(acctRec.ShippingPostalCode) && !String.isBlank(acctRec.ShippingCountry)) {
            acctRec.BillingStreet = acctRec.ShippingStreet;
            acctRec.BillingCity = acctRec.ShippingCity;
            acctRec.BillingState = acctRec.ShippingState;
            acctRec.BillingPostalCode = acctRec.ShippingPostalCode;
            acctRec.BillingCountry = acctRec.ShippingCountry;
        }
    }
}