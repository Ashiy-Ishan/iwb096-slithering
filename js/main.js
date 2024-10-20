// Get the input elements by their ID for the Admin Login form
const adminEmailInput = document.getElementById('admin-email');
const adminPasswordInput = document.getElementById('admin-password');

// Get the input elements by their ID for the Normal User Login form
const userEmailInput = document.getElementById('user-email');
const userPasswordInput = document.getElementById('user-password');

// Function to trigger the alert showing Admin User ID and password
function AlertAdmin() {
    // Display the Admin User ID and password in an alert box
    alert("Admin User ID: " + adminEmailInput.value + "\nPassword: " + adminPasswordInput.value);

    // Prevent form submission so the page doesn't reload
    return false;
}

// Function to trigger the alert showing Normal User ID and password
// function AlertUser() {
//     // // Display the Normal User ID and password in an alert box
//     // alert("User ID: " + userEmailInput.value + "\nPassword: " + userPasswordInput.value);

//     // // Prevent form submission so the page doesn't reload
//     // return false;
//     // Function to get all users
// async function getUsers() {
//     try {
//         const response = await fetch('http://localhost:8080/users');
//         if (!response.ok) {
//             throw new Error(`HTTP error! Status: ${response.status}`);
//         }
//         const users = await response.json(); // Parse the JSON data
//         alert(users); // Do something with the fetched data
//     } catch (error) {
//         alert('Error fetching users:', error);
//     }
// }

// getUsers();

// }
// Function to get all users and check if the entered email and password match any user
async function checkUser() {
    // Get the values entered by the user
    const enteredEmail = document.getElementById('email').value;
    const enteredPassword = document.getElementById('password').value;
    
    try {
        const response = await fetch('http://localhost:8080/crossOriginService/users');
        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }

        const users = await response.json(); // Parse the JSON data

        // Find if any user matches the entered name and password
        const matchedUser = users.find(userdata => userdata.email === enteredEmail && userdata.password === enteredPassword);
        
        if (matchedUser) {
            alert('Login successful!'); // Alert if a match is found
            window.location.href = "view only.html";
        } else {
            alert('email or password is incorrect!'); // Alert if no match is found
        }

    } catch (error) {
        console.error('Error fetching users:', error);
    }
}
async function adminLogin() {
    // Get the values entered by the user
    const enteredEmail = document.getElementById('admin-email').value;
    const enteredPassword = document.getElementById('admin-password').value;
    
    try {
        const response = await fetch('http://localhost:8080/crossOriginService/admins');
        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }

        const users = await response.json(); // Parse the JSON data

        // Find if any user matches the entered name and password
        const matchedUser = users.find(admindata => admindata.email === enteredEmail && admindata.password === enteredPassword);
        
        if (matchedUser) {
            alert('Login successful!'); // Alert if a match is found
            window.location.href = "adminLogin.html";
        } else {
            alert('email or password is incorrect!'); // Alert if no match is found
        }

    } catch (error) {
        console.error('Error fetching users:', error);
    }
}

async function registerUser() {
    // Get the values entered by the user in the registration form
    const name = document.getElementById('admin-name').value;  // Input field for the user's name
    const email = document.getElementById('admin-email').value;  // Input field for the user's email
    const password = document.getElementById('admin-password').value;  // Input field for the user's password

    // Create a user object matching the structure expected by the Ballerina service
    const newUser = {
        id: '', // Set an empty string for id because it will be auto-generated in the backend
        name: name,
        email: email,
        password: password
    };

    try {
        // Send the data to the Ballerina service via POST
        const response = await fetch('http://localhost:8080/crossOriginService/sendusers', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',  // Inform the backend that the request contains JSON
            },
            body: JSON.stringify(newUser)  // Convert the user object to a JSON string
        });

        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }

        const result = await response.json();  // Parse the JSON response from the backend

        alert('Registration successful!');
        console.log('User added:', result);  // Log the returned user data
        
    } catch (error) {
        console.error('Error registering user:', error);
        alert('Failed to register user.');
    }
}
function getBankDataByAcNum() {
    var nicSearch = document.getElementById('nicSearch').value;
    const url = `http://localhost:8080/crossOriginService/bankdetails/acnum/${nicSearch}`;

    fetch(url)
    .then(response => {
        if (!response.ok) {
            
            alert('Bank details not found');
        }
        return response.json();
    })
    .then(data => {
        console.log('Bank details:', data);
        document.getElementById("nameShow").value = data.owner_name;
        document.getElementById("nicShow").value = data.nic;
        document.getElementById("loanIDShow").value = data.id;
        document.getElementById("amountShow").value = data.loan_amount;
        document.getElementById("p_dateShow").value = data.start_date;
        document.getElementById("u_dateShow").value = data.upto_date;
        
        // Handle gender radio buttons
        if(data.gender_id == 1){
            document.getElementById('maleshow').checked = true;
        } else if(data.gender_id == 2){
            document.getElementById('femaleshow').checked = true;
        } else if(data.gender_id == 3){
            document.getElementById('othershow').checked = true;
        }

    })
    .catch(error => {
        console.error('Error fetching bank details:', error);
    });
}

function getBankOfficeDetails(){
    var nicSearch = document.getElementById('nicSearch').value;
const url = `http://localhost:8080/crossOriginService/bprocess/acnum/${nicSearch}`;

fetch(url)
.then(response => {
    if (!response.ok) {
        console.log('No Bank Office details found');
        return;
    }
    return response.json();
})
.then(data => {
    console.log('Bank details:', data);
    
    // Handle checkboxes independently
    if(data.credit_office == 2){
        document.getElementById('CreditOfficerShow').checked = true;
    } else {
        document.getElementById('CreditOfficerShow').checked = false;
    }

    if(data.bank_manager == 2){
        document.getElementById('BankManagerShow').checked = true;
    } else {
        document.getElementById('BankManagerShow').checked = false;
    }

    if(data.mail_unit == 2){
        document.getElementById('MailUnitShow').checked = true;
    } else {
        document.getElementById('MailUnitShow').checked = false;
    }

})
.catch(error => {
    console.error('Error fetching bank details:', error);
});
}
// Example usage:
function getBankPPDetails(){
    var nicSearch = document.getElementById('nicSearch').value;
const url = `http://localhost:8080/crossOriginService/pprocess/acnum/${nicSearch}`;

fetch(url)
.then(response => {
    if (!response.ok) {
        console.log('No Province office details found');
        return;
    }
    return response.json();
})
.then(data => {
    console.log('Bank details:', data);
    
    // Handle checkboxes independently
    if(data.credit_officer == 2){
        document.getElementById('CreditOfficerProvinceShow').checked = true;
    } else {
        document.getElementById('CreditOfficerProvinceShow').checked = false;
    }

    if(data.area_manager == 2){
        document.getElementById('BankManagerProvinceShow').checked = true;
    } else {
        document.getElementById('BankManagerProvinceShow').checked = false;
    }

    if(data.ag_manager == 2){
        document.getElementById('AssistantGeneralProvinceShow').checked = true;
    } else {
        document.getElementById('AssistantGeneralProvinceShow').checked = false;
    }
    if(data.mail_unit == 2){
        document.getElementById('MailUnitProvinceShow').checked = true;
    } else {
        document.getElementById('MailUnitProvinceShow').checked = false;
    }

})
.catch(error => {
    console.error('Error fetching bank details:', error);
});
}
function getBankHPDetails(){
    var nicSearch = document.getElementById('nicSearch').value;
const url = `http://localhost:8080/crossOriginService/hprocess/acnum/${nicSearch}`;

fetch(url)
.then(response => {
    if (!response.ok) {
        console.log('No Head office details found');
        return;
    }
    return response.json();
})
.then(data => {
    console.log('Bank details:', data);
    
    // Handle checkboxes independently
    if(data.branch_cu == 2){
        document.getElementById('BranchCreditHeadShow').checked = true;
    } else {
        document.getElementById('BranchCreditHeadShow').checked = false;
    }

    if(data.credit_office == 2){
        document.getElementById('CreditOfficerHeadShow').checked = true;
    } else {
        document.getElementById('CreditOfficerHeadShow').checked = false;
    }

    if(data.ag_manager == 2){
        document.getElementById('AssistantGeneralHeadShow').checked = true;
    } else {
        document.getElementById('AssistantGeneralHeadShow').checked = false;
    }
    if(data.dg_manager == 2){
        document.getElementById('DivisionalGeneralShow').checked = true;
    } else {
        document.getElementById('DivisionalGeneralShow').checked = false;
    }

})
.catch(error => {
    console.error('Error fetching bank details:', error);
});
}
