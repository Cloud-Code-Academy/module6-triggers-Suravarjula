trigger ValidateOpportunityAmount on Opportunity (before update) {
    for(Opportunity oppRec : Trigger.new) {
        if(oppRec.Amount <= 5000) {
            oppRec.Amount.addError(Label.Opp_Amount_More_Than_5000);
        }
    }

}