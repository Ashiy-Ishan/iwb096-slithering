// const banknumberInput = document.getElementById('bank_number');
// const nameInput = document.getElementById('name');




// const nicInput = document.getElementById('nic');
// const acnumberInput = document.getElementById('amount');
// const loanidInput = document.getElementById('loanID');
// const loanplacementdateInput = document.getElementById('p_date');
// const updatedateInput = document.getElementById('u_date');

// function Alert() {
//     // Display details in an alert box
//     alert("Bank Number: " + banknumberInput.value + "\nBank owner name: " + nameInput.value + 
//         "\nNational Card Number: " + nicInput.value + "\nLoan Amount (Rs:): " + acnumberInput.value + "\nLoan ID:" 
//         + loanidInput.value + "\nLoan Placement Date:" + loanplacementdateInput.value 
//         + "\nLatest Status Update Date:" + updatedateInput.value );

//     // Prevent form submission so the page doesn't reload
//     return false;
// }

// document.getElementById('submit').onclick = function() {
//     var selected = document.querySelector('input[type=radio][name=gender]:checked');
//     alert(selected.value);
// }
async function registerloan(event) {
    event.preventDefault();
    // Get the values entered by the user in the registration form
    const banknb = document.getElementById('bank_number').value;
    const name = document.getElementById('name').value;
    const selectedRadio = document.querySelector('input[name="gender"]:checked');
    const genderId = selectedRadio ? selectedRadio.value : null;  // Ensure a radio button is selected
    const nic = document.getElementById('nic').value;
    const amount = document.getElementById('amount').value;
    const loanplacementdate = document.getElementById('p_date').value;
    const updatedate = document.getElementById('u_date').value;

    // Process the various checkboxes and assign corresponding IDs
    

    // Create the data objects for newAc and newBP
    const newAc = {
        id: '',  // Auto-generated in the backend
        owner_name: name,
        nic: nic,
        ac_num: banknb,
        gender_id: genderId,
        loan_amount: amount,
        start_date: loanplacementdate,
        upto_date: updatedate,

    };

    

    try {
        // Send the first request for loan registration (newAc)
        const loanResponse = await fetch('http://localhost:8080/crossOriginService/sendbankdetails', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(newAc)
        });

        if (!loanResponse.ok) {
            throw new Error(`Loan registration failed! Status: ${loanResponse.status}`);
        }

        const loanResult = await loanResponse.json();
        console.log('Loan registered:', loanResult);  // Log the loan registration result

        // Send the second request for the bank process (newBP)

        // Show success message only after both requests are successful
        
        
    } catch (error) {
        console.error('Error during registration process:', error);
        
        
    }
    
}


async function addbpprocess(){
    const banknb = document.getElementById('bank_number').value;
    const coID = document.getElementById('CreditOfficer').checked ? 2 : 1;
    const bmID = document.getElementById('BankManager').checked ? 2 : 1;
    const muID = document.getElementById('MailUnit').checked ? 2 : 1;
    // const copID = document.getElementById('CreditOfficeProvince').checked ? 2 : 1;
    // const bmpID = document.getElementById('BankManagerProvince').checked ? 2 : 1;
    // const agpID = document.getElementById('AssistantGeneralProvince').checked ? 2 : 1;
    // const mupID = document.getElementById('MailUnitProvince').checked ? 2 : 1;
    // const bchID = document.getElementById('BranchCreditHead').checked ? 2 : 1;
    // const cohID = document.getElementById('CreditOfficerHead').checked ? 2 : 1;
    // const asgID = document.getElementById('AssistantGeneralHead').checked ? 2 : 1;
    // const dgID = document.getElementById('DivisionalGeneral').checked ? 2 : 1;
    const newBP = {
        id: '',  // Auto-generated in the backend
        credit_office: coID,
        bank_manager: bmID,
        mail_unit: muID,
        bank_ac: banknb
    };
try{
   
// Send the second request for the bank process (newBP)
const processResponse = await fetch('http://localhost:8080/crossOriginService/sendbprocess', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
    },
    body: JSON.stringify(newBP)
});

if (!processResponse.ok) {
    throw new Error(`Bank process registration failed! Status: ${processResponse.status}`);
}

const processResult = await processResponse.json();
console.log('Bank process registered:', processResult);  // Log the bank process result

// Show success message only after both requests are successful


} catch (error) {
    console.error('Error during registration process:', error);
    
}


}


async function addPPprocess(){
    const banknb = document.getElementById('bank_number').value;
    const copID = document.getElementById('CreditOfficerProvince').checked ? 2 : 1;
    const bmpID = document.getElementById('BankManagerProvince').checked ? 2 : 1;
    const agpID = document.getElementById('AssistantGeneralProvince').checked ? 2 : 1;
    const mupID = document.getElementById('MailUnitProvince').checked ? 2 : 1;
    // const bchID = document.getElementById('BranchCreditHead').checked ? 2 : 1;
    // const cohID = document.getElementById('CreditOfficerHead').checked ? 2 : 1;
    // const asgID = document.getElementById('AssistantGeneralHead').checked ? 2 : 1;
    // const dgID = document.getElementById('DivisionalGeneral').checked ? 2 : 1;
    const newPP = {
        id: '',  // Auto-generated in the backend
        credit_officer: copID,
        area_manager: bmpID,
        ag_manager: agpID,
        mail_unit: mupID,
        bank_ac: banknb
    };
try{
   
// Send the second request for the bank process (newBP)
const processResponse = await fetch('http://localhost:8080/crossOriginService/sendpprocess', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
    },
    body: JSON.stringify(newPP)
});

if (!processResponse.ok) {
    throw new Error(`Bank process registration failed! Status: ${processResponse.status}`);
}

const processResult = await processResponse.json();
console.log('Bank process registered:', processResult);  // Log the bank process result

// Show success message only after both requests are successful


} catch (error) {
    console.error('Error during registration process:', error);
   
}


}

async function addHPprocess(){
    const banknb = document.getElementById('bank_number').value;
 
    const bchID = document.getElementById('BranchCreditHead').checked ? 2 : 1;
    const cohID = document.getElementById('CreditOfficerHead').checked ? 2 : 1;
    const asgID = document.getElementById('AssistantGeneralHead').checked ? 2 : 1;
    const dgID = document.getElementById('DivisionalGeneral').checked ? 2 : 1;
    const newHP = {
        id: '',  // Auto-generated in the backend
        branch_cu: bchID,
        credit_office: cohID,
        ag_manager: asgID,
        dg_manager: dgID,
        bank_ac: banknb
    };
try{
   
// Send the second request for the bank process (newBP)
const processResponse = await fetch('http://localhost:8080/crossOriginService/sendhprocess', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
    },
    body: JSON.stringify(newHP)
});

if (!processResponse.ok) {
    alert("Loan add Failed !")
    throw new Error(`Bank process registration failed! Status: ${processResponse.status}`);
}

const processResult = await processResponse.json();
console.log('Bank process registered:', processResult);  // Log the bank process result
alert("Loan add success");
// Show success message only after both requests are successful


} catch (error) {
    console.error('Error during registration process:', error);
    
}


}


async function updateloan() {
    // Get the values entered by the user in the registration form
    const id = document.getElementById('loanIDShow').value;
    const banknb = document.getElementById('nicSearch').value;
    const name = document.getElementById('nameShow').value;
    const selectedRadio = document.querySelector('input[name="gender"]:checked');
    const genderId = selectedRadio ? selectedRadio.value : null;  // Ensure a radio button is selected
    const nic = document.getElementById('nicShow').value;
    const amount = document.getElementById('amountShow').value;
    const loanplacementdate = document.getElementById('p_dateShow').value;
    const updatedate = document.getElementById('u_dateShow').value;

    // Process the various checkboxes and assign corresponding IDs
    

    // Create the data objects for newAc and newBP
    const newAc = {
        id: id,  // Auto-generated in the backend
        owner_name: name,
        nic: nic,
        ac_num: banknb,
        gender_id: genderId,
        loan_amount: amount,
        start_date: loanplacementdate,
        upto_date: updatedate,

    };

    

    try {
        // Send the first request for loan registration (newAc)
        const loanResponse = await fetch('http://localhost:8080/crossOriginService/updatebankdetails', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(newAc)
        });

        if (!loanResponse.ok) {
            throw new Error(`Loan update failed! Status: ${loanResponse.status}`);
        }

        const loanResult = await loanResponse.json();
        console.log('Loan updated:', loanResult);  // Log the loan registration result

        // Send the second request for the bank process (newBP)

        // Show success message only after both requests are successful
        alert('update successful!');
        
    } catch (error) {
        console.error('Error during update process:', error);
        alert('update failed! Please try again.');
        
    }
    
}
async function updatebpprocess(){
    const banknb = document.getElementById('nicSearch').value;
    
    const coID = document.getElementById('CreditOfficerShow').checked ? 2 : 1;
    const bmID = document.getElementById('BankManagerShow').checked ? 2 : 1;
    const muID = document.getElementById('MailUnitShow').checked ? 2 : 1;
    // const copID = document.getElementById('CreditOfficeProvince').checked ? 2 : 1;
    // const bmpID = document.getElementById('BankManagerProvince').checked ? 2 : 1;
    // const agpID = document.getElementById('AssistantGeneralProvince').checked ? 2 : 1;
    // const mupID = document.getElementById('MailUnitProvince').checked ? 2 : 1;
    // const bchID = document.getElementById('BranchCreditHead').checked ? 2 : 1;
    // const cohID = document.getElementById('CreditOfficerHead').checked ? 2 : 1;
    // const asgID = document.getElementById('AssistantGeneralHead').checked ? 2 : 1;
    // const dgID = document.getElementById('DivisionalGeneral').checked ? 2 : 1;
    const newBP = {
        id: '',  // Auto-generated in the backend
        credit_office: coID,
        bank_manager: bmID,
        mail_unit: muID,
        bank_ac: banknb
    };
try{
   
// Send the second request for the bank process (newBP)
const processResponse = await fetch('http://localhost:8080/crossOriginService/updatebprocess', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
    },
    body: JSON.stringify(newBP)
});

if (!processResponse.ok) {
    throw new Error(`Bank process update failed! Status: ${processResponse.status}`);
}

const processResult = await processResponse.json();
console.log('Bank process updated:', processResult);  // Log the bank process result

// Show success message only after both requests are successful


} catch (error) {
    console.error('Error during update process:', error);
 
}


}
async function updatePPprocess(){
    const banknb = document.getElementById('nicSearch').value;
    
    const copID = document.getElementById('CreditOfficerProvinceShow').checked ? 2 : 1;
    const bmpID = document.getElementById('BankManagerProvinceShow').checked ? 2 : 1;
    const agpID = document.getElementById('AssistantGeneralProvinceShow').checked ? 2 : 1;
    const mupID = document.getElementById('MailUnitProvinceShow').checked ? 2 : 1;
    // const bchID = document.getElementById('BranchCreditHead').checked ? 2 : 1;
    // const cohID = document.getElementById('CreditOfficerHead').checked ? 2 : 1;
    // const asgID = document.getElementById('AssistantGeneralHead').checked ? 2 : 1;
    // const dgID = document.getElementById('DivisionalGeneral').checked ? 2 : 1;
    const newPP = {
        id: '',  // Auto-generated in the backend
        credit_officer: copID,
        area_manager: bmpID,
        ag_manager: agpID,
        mail_unit: mupID,
        bank_ac: banknb
    };
try{
   
// Send the second request for the bank process (newBP)
const processResponse = await fetch('http://localhost:8080/crossOriginService/updatepprocess', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
    },
    body: JSON.stringify(newPP)
});

if (!processResponse.ok) {
    throw new Error(`Bank process update failed! Status: ${processResponse.status}`);
}

const processResult = await processResponse.json();
console.log('Bank process updated:', processResult);  // Log the bank process result

// Show success message only after both requests are successful


} catch (error) {
    console.error('Error during update process:', error);
   
}


}
async function updateHPprocess(){
    const banknb = document.getElementById('nicSearch').value;
    
 
    const bchID = document.getElementById('BranchCreditHeadShow').checked ? 2 : 1;
    const cohID = document.getElementById('CreditOfficerHeadShow').checked ? 2 : 1;
    const asgID = document.getElementById('AssistantGeneralHeadShow').checked ? 2 : 1;
    const dgID = document.getElementById('DivisionalGeneralShow').checked ? 2 : 1;
    const newHP = {
        id: '',  // Auto-generated in the backend
        branch_cu: bchID,
        credit_office: cohID,
        ag_manager: asgID,
        dg_manager: dgID,
        bank_ac: banknb
    };
try{
   
// Send the second request for the bank process (newBP)
const processResponse = await fetch('http://localhost:8080/crossOriginService/updatehprocess', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
    },
    body: JSON.stringify(newHP)
});

if (!processResponse.ok) {
    throw new Error(`Bank process update failed! Status: ${processResponse.status}`);
}

const processResult = await processResponse.json();
console.log('Bank process update:', processResult);  // Log the bank process result

// Show success message only after both requests are successful


} catch (error) {
    console.error('Error during update process:', error);

}


}