trigger SetAccountTypeToProspect on Account (before insert) {
    for( Account acctRec : Trigger.new) {
        if(String.isBlank(acctRec.type)) {
            acctRec.type = 'Prospect';
        }
    }
}