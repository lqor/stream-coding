import { LightningElement, api } from 'lwc';
import getTopOpportunities from '@salesforce/apex/TopOpportunitiesController.getTopOpportunities';

export default class TopOpportinities extends LightningElement {
    @api numberOfOpps;

    data = [];

    columns = [
        { 
            label: 'Opportunity name',
            fieldName: 'nameUrl',
            type: 'url',
            typeAttributes: {label: { fieldName: 'name' }, 
            target: '_blank'}
        },
        { label: 'Stage', fieldName: 'stageName', type: 'text' },
        { label: 'Amount', fieldName: 'amount', type: 'currency' },
        { label: 'Close Date', fieldName: 'closeDate', type: 'date' },
        { label: 'Owner', fieldName: 'opportunityOwnerName', type: 'text'}
    ];

    connectedCallback() {
        this.getTopOpportunities();
    }

    getTopOpportunities() {
        getTopOpportunities({ limitNumber: this.numberOfOpps })
            .then(result => {
                this.data = result;
                console.log('this.data', this.data);
            })
            .catch(error => {
                this.error = error;
            });
    }

}