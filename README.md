# iwb096-slithering
Demostrate solution for Bank Loan Traffic. The Bank Loan Tracking System

This is a dimostrate website for bank loan tracking system. It can manage and improve user satispaction.

In this project; We used 
  HTML AND CSS -- Deveolop and style frontend
  MySQL        -- Database
  Bellerina   -- Develop backend and Interegrate from frontend to database.
  JavaScript  -- Make web more functional.
  Fetch API   -- Get data from frontend and send it to backend.

1. In this web all admin, user passwords and email should store into database, when bank want to add new admin or user for viewOnly mode the bank have to inform it to main database administrator. Because bank  system not allow any new sign up from 3rd parties.
   pre added,
   
   Admin panel -- bank1@gmail.com ====>  Password = bank1
   User panel -- bank2@gmail.com   ====>  password = vbank1

2. Setup Database connect to ballerina.
   
![Screenshot 2024-10-20 180231](https://github.com/user-attachments/assets/48107c6f-c41b-4a60-92e2-4841f53e3539)

Make your host, user and password in ballerina code file, otherwise it not connect to database.
after that connect sql file using HEIDISQL or SQL workbench.

3. After the connect sql into backend ballerina, Run ballerina file use vscode.
   
5. Open Login.html file and click live server button in under the vscode.
   
   ![Screenshot 2024-10-20 181008](https://github.com/user-attachments/assets/9a2202c5-1f43-4031-b246-74c62f8868d6)

   
5.After that, login.html will popup in webbrowser. Then input email and password according to the above password.

  ![Screenshot 2024-10-20 181554](https://github.com/user-attachments/assets/c3731311-2c39-455f-afb2-53d339b4233f)
  
6. Admin login.
   Admin can enter Bank customer's data. and update it by update button after the first data entry.
   Before update progress admin shoul click add loan button for make space in data base first time.
   
   ![Screenshot 2024-10-20 182423](https://github.com/user-attachments/assets/2fe23b7b-6aba-47f9-8417-2e2e170c9d0f)
   
   then admin can add progress.
   
8. Ater the first time admin can update customer loan progress by clicking update button. After the update button click admin should search customer's previous data by searching bank number.
9. 
![Screenshot 2024-10-20 182816](https://github.com/user-attachments/assets/3c12798f-e53d-4f2a-b078-080c8f4fbc07)


10. In normal login bankers can find customer's loan progress by simpley searching his or her account number.
    
![Screenshot 2024-10-20 183046](https://github.com/user-attachments/assets/407268f1-6cf1-4a1d-b4ee-d308559367d6)


