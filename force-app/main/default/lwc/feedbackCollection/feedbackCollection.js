import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class FeedbackCollection extends LightningElement {
    @api recordId;
    objectApiName = 'Feedback__c';

    handleSuccess(event) {
        this.showToast('Feedback submitted', 'Feedback submitted successfully', 'success');
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        }));
    }
}