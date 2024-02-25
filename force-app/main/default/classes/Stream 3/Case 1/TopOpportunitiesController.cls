public with sharing class TopOpportunitiesController {
    @AuraEnabled
    public static List<OpportunityWrapper> getTopOpportunities(Integer limitNumber){
        List<Opportunity> opps = queryOpportunities(limitNumber);

        List<OpportunityWrapper> oppsWrapper = new List<OpportunityWrapper>();

        for(Opportunity opp : opps){
            OpportunityWrapper oppWrapper = new OpportunityWrapper();
            oppWrapper.id = opp.Id;
            oppWrapper.name = opp.Name;
            oppWrapper.amount = opp.Amount;
            oppWrapper.closeDate = opp.CloseDate;
            oppWrapper.stageName = opp.StageName;
            oppWrapper.opportunityOwnerName = opp.Owner.Name;
            oppWrapper.nameUrl = '/' + opp.Id;
            oppsWrapper.add(oppWrapper);
        }

        System.debug('oppsWrapper: ' + oppsWrapper);

        return oppsWrapper;
    }

    private static List<Opportunity> queryOpportunities(Integer limitNumber){
        return [
            SELECT Id, Name, Amount, CloseDate, StageName, Owner.Name 
            FROM Opportunity 
            ORDER BY Amount DESC 
            LIMIT :limitNumber
        ];
    }

    class OpportunityWrapper {
        @AuraEnabled
        public Id id { get; set; }

        @AuraEnabled
        public String name { get; set; }

        @AuraEnabled
        public Decimal amount { get; set; }

        @AuraEnabled
        public Date closeDate { get; set; }

        @AuraEnabled
        public String stageName { get; set; }

        @AuraEnabled
        public String opportunityOwnerName { get; set; }

        @AuraEnabled
        public String nameUrl { get; set; }
    }
}