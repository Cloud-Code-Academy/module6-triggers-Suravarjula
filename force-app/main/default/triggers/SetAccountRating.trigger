trigger SetAccountRating on Account (before insert) {
    for(Account acctRec : Trigger.new){
        if(!String.isBlank(acctRec.Phone) && !String.isBlank(acctRec.WebSite) && !String.isBlank(acctRec.Fax)){
            acctRec.Rating = 'Hot';
        }
    }
}