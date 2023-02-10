function runCheck() {
    /*
     MARK: Make all input field font sizes at least 16px.
     Mobile browsers make a very annoying –yet well justified zoom– on input fields under 16px, and Transbank uses 14px for theirs.
     */
    const pageInputs = document.querySelectorAll("input");
    pageInputs.forEach(pageInput => {
        pageInput.style.fontSize = "16px";
    });
    
    /*
     MARK: Allow credit and debit cards auto-fill.
     Because it"s the right thing to do in 2023.
     */
    const cardNumberInput = document.querySelector("#card-number");
    const cardExpInput = document.querySelector("#card-exp");
    const cardCVVInput = document.querySelector("#card-cvv");
    
    // We don't want to run this infinite times 😅
    if (cardNumberInput.getAttribute("autocomplete") != "cc-number") {
        console.log("cardNumberInput's autocomplete attribute is not cc-number");
        cardNumberInput.setAttribute("autocomplete", "cc-number");
    }
    
    // We don't want to run this infinite times 😅
    if (cardExpInput.getAttribute("autocomplete") != "cc-exp") {
        console.log("cardExpInput's autocomplete attribute is not cc-exp");
        cardExpInput.setAttribute("autocomplete", "cc-exp");
    }
    
    // We don't want to run this infinite times 😅
    if (cardCVVInput.getAttribute("autocomplete") != "cc-csc") {
        console.log("cardCVVInput's autocomplete attribute is not cc-csc");
        cardCVVInput.setAttribute("autocomplete", "cc-csc");
    }
}

// Select the node that will be observed for mutations
const targetNode = document.body;

// Options for the observer (which mutations to observe)
const config = { attributes: true, childList: true, subtree: true };

// Callback function to execute when mutations are observed
const callback = (mutationList, observer) => {
    for (const mutation of mutationList) {
        if (mutation.type === "childList") {
            console.log("A child node has been added or removed.");
        } else if (mutation.type === "attributes") {
            console.log(`The ${mutation.attributeName} attribute was modified.`);
        }
        
        runCheck();
        
    }
};

// Create an observer instance linked to the callback function
const observer = new MutationObserver(callback);

// Start observing the target node for configured mutations
observer.observe(targetNode, config);
