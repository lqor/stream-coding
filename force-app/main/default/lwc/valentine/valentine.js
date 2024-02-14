import { LightningElement, api, track } from 'lwc';
import gif_zipped from "@salesforce/resourceUrl/gif_zipped";
import gif_zipped_2 from "@salesforce/resourceUrl/gif_zipped_2";
import { loadScript } from "lightning/platformResourceLoader";
import CONFETTI from "@salesforce/resourceUrl/confetti";

export default class Valentine extends LightningElement {
    @api yesClicked = false;

    gifZipped = gif_zipped;
    gifZipped = gif_zipped_2;

    gifFull = gif_zipped + "/valentine.gif";
    gifFull_2 = gif_zipped_2 + "/valentine_2.gif";

    // Confetti
    handleYes() {
        this.yesClicked = true;

        Promise.all([
          loadScript(this, CONFETTI )
        ])
          .then(() => {
           
            this.setUpCanvas();
    
             //calling Confetti
          
            this.basicCannon();
    
          })
          .catch(error => {
            this.dispatchEvent(
              new ShowToastEvent({
                title: "Error",
                message: error.message,
                variant: error
              })
            );
          });
    
      }
    
      setUpCanvas() {
        var confettiCanvas = this.template.querySelector("canvas.confettiCanvas");
        this.myconfetti = confetti.create(confettiCanvas, { resize: true });
        this.myconfetti({
          zIndex: 10000
        });
      }
      
      basicCannon() {
        confetti({
          particleCount: 100,
          spread: 70,
          origin: {
            y: 0.6
          }
        });
      }
}