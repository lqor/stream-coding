import { LightningElement } from 'lwc';
import analyzeCode from '@salesforce/apex/AiCodeAnalyzerController.analyzeCode';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CodeAnalyzer extends LightningElement {
  codeFeedback = 'No feedback yet.';
  code = '';
  showSpinner = false;

  handleClick(event) {
    this.showSpinner = true;

    analyzeCode({ code: this.code })
      .then(result => {
        this.codeFeedback = result;

        this.showToastEvent('Success', 'Code analyzed successfully', 'success');
      })
      .catch(error => {        
        this.showToastEvent('Error', error, 'error');
      }).finally(() => {
        this.showSpinner = false;
      });
  }

  handleChange(event) {
    this.code = event.target.value;
  }

  showToastEvent(title, message, variant) {
    this.dispatchEvent(new ShowToastEvent({
      title: title,
      message: message,
      variant: variant
    }));
  }
}