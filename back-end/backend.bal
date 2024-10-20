import ballerina/http;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

configurable string host = "localhost";
configurable int port = 3306;
configurable string user = "root";
configurable string password = "123456";
configurable string database = "new";

type Album record {|
    string id;
    string name;
    string email;
    string password;
    string bank_ac_num;

|};
type Admin record {|
    string id;
    string name;
    string email;
    string password;
   

|};

type Bank record {|
    string id;
    string owner_name;
    string nic;
    string ac_num;
    string gender_id;
    string loan_amount;
    string start_date;
    string upto_date;

|};

type BankProcess record {|
    string id;
    int credit_office;
    int bank_manager;
    int mail_unit;
    string bank_ac;

|};

type ProvinceProcess record {|
    string id;
    int credit_officer;
    int area_manager;
    int ag_manager;
    int mail_unit;
    string bank_ac;

|};

type HeadOffice record {|
    string id;
    int branch_cu;
    int credit_office;
    int ag_manager;
    int dg_manager;
    string bank_ac;

|};

type Loan record {|
    string loan_id;
    string loan_amount;
    string start_date;
    string upto_date;
    string bank_ac_num;
    string bank_process_id;
    string province_office_id;
    string head_office_id;
|};

@http:ServiceConfig {
    cors: {
        allowOrigins: ["http://127.0.0.1:5500"], // Allow requests from this origin
        allowCredentials: false,
        allowMethods: ["GET", "POST", "OPTIONS"], // Allow necessary methods
        allowHeaders: ["Content-Type", "CORELATION_ID"], // Allow necessary headers
        exposeHeaders: ["X-CUSTOM-HEADER"],
        maxAge: 84900
    }
}

service /crossOriginService on new http:Listener(8080) {
    private final mysql:Client db;

    function init() returns error? {
        self.db = check new (host, user, password, database, port);
    }

    resource function get admins() returns Admin[]|error {
        stream<Admin, sql:Error?> adminStream = self.db->query(`SELECT * FROM admin `);
        return from Admin admindata in adminStream
            select admindata;
    }

    resource function get admins/[string id]() returns Admin|http:NotFound|error {
        Admin|sql:Error result = self.db->queryRow(`SELECT * FROM admin WHERE id = ${id}`);
        if result is sql:NoRowsError {
            return http:NOT_FOUND;
        } else {
            return result;
        }
    }

    resource function post sendadmin(@http:Payload Admin admindata) returns Admin|error {
        _ = check self.db->execute(`
            INSERT INTO admin ( name, email, password )
            VALUES ( ${admindata.name}, ${admindata.email}, ${admindata.password} );`);
        return admindata;
    }

    resource function get users() returns Album[]|error {
        stream<Album, sql:Error?> userStream = self.db->query(`SELECT * FROM user `);
        return from Album userdata in userStream
            select userdata;
    }

    resource function get users/[string id]() returns Album|http:NotFound|error {
        Album|sql:Error result = self.db->queryRow(`SELECT * FROM user WHERE id = ${id}`);
        if result is sql:NoRowsError {
            return http:NOT_FOUND;
        } else {
            return result;
        }
    }

    resource function post sendusers(@http:Payload Album userdata) returns Album|error {
        _ = check self.db->execute(`
            INSERT INTO user ( name, email, password, bank_ac_num)
            VALUES ( ${userdata.name}, ${userdata.email}, ${userdata.password}, ${userdata.bank_ac_num});`);
        return userdata;
    }

    resource function get bankdetails/acnum/[string bank_ac_num]() returns Bank|http:NotFound|error {
        Bank|sql:Error result = self.db->queryRow(`SELECT * FROM bank WHERE ac_num = ${bank_ac_num}`);
        if result is sql:NoRowsError {
            return http:NOT_FOUND;
        } else {
            return result;
        }
    }

    resource function get bankdetails() returns Bank[]|error {
        stream<Bank, sql:Error?> bankStream = self.db->query(`SELECT * FROM bank`);
        return from Bank bankdata in bankStream
            select bankdata;
    }

    resource function get bankdetails/[string id]() returns Bank|http:NotFound|error {
        Bank|sql:Error result = self.db->queryRow(`SELECT * FROM bank WHERE id = ${id}`);
        if result is sql:NoRowsError {
            return http:NOT_FOUND;
        } else {
            return result;
        }
    }

    // resource function post sendbankdetails(@http:Payload Bank bankdata) returns Bank|error {
    //     _ = check self.db->execute(`
    //         INSERT INTO bank ( owner_name, nic, ac_num, user_id, gender_id)
    //         VALUES ( ${bankdata.owner_name}, ${bankdata.nic}, ${bankdata.ac_num}, ${bankdata.user_id}, ${bankdata.gender_id});`);
    //     return bankdata;
    // }
    resource function post sendbankdetails(@http:Payload Bank bankdata) returns Bank|error {
        sql:ExecutionResult|sql:Error result = self.db->execute(`
        INSERT INTO bank (owner_name, nic, ac_num, gender_id, loan_amount, start_date, upto_date)
        VALUES ( ${bankdata.owner_name}, ${bankdata.nic}, ${bankdata.ac_num}, ${bankdata.gender_id}, ${bankdata.loan_amount}, ${bankdata.start_date}, ${bankdata.upto_date} );`);

        if result is sql:Error {
            // Check for duplicate entry error (SQL Error Code 1062)
            if result.message().startsWith("Duplicate entry") {
                return error("Duplicate entry for primary key");
            } else {
                return result; // Return other SQL errors
            }
        }
        return bankdata; // Return the successfully inserted userdata
    }
    resource function post updatebankdetails(@http:Payload Bank bankdata) returns Bank|error {
    sql:ExecutionResult|sql:Error result = self.db->execute(`
        UPDATE bank 
        SET owner_name = ${bankdata.owner_name}, 
            nic = ${bankdata.nic}, 
            ac_num = ${bankdata.ac_num}, 
            gender_id = ${bankdata.gender_id}, 
            loan_amount = ${bankdata.loan_amount}, 
            start_date = ${bankdata.start_date}, 
            upto_date = ${bankdata.upto_date}
        WHERE ac_num = ${bankdata.ac_num};
    `);

    if result is sql:Error {
        // Check for duplicate entry error (SQL Error Code 1062)
        if result.message().startsWith("Duplicate entry") {
            return error("Duplicate entry for primary key");
        } else {
            return result; // Return other SQL errors
        }
    }
    return bankdata; // Return the successfully updated bank data
}


    //     resource function post sendloandetails(@http:Payload Loan loandata) returns Loan|error {
    //     sql:ExecutionResult|sql:Error result = self.db->execute(`
    //         INSERT INTO loan (loan_amount, start_date, upto_date, bank_ac_num)
    //         VALUES (${loandata.loan_amount}, '${loandata.start_date}', ${loandata.upto_date}, '${loandata.bank_ac_num}');`);

    //      if result is sql:Error {
    //         // Check for duplicate entry error (SQL Error Code 1062)
    //         if result.message().startsWith("Duplicate entry") {
    //             return error("Duplicate entry for primary key");
    //         } else {
    //             return result; // Return other SQL errors
    //         }
    //     }
    //     return loandata; // Return the successfully inserted userdata
    // }
    resource function post sendloandetails(@http:Payload Loan loandata) returns Loan|error {
        // Corrected SQL query with proper placeholders
        _ = check self.db->execute(
        `INSERT INTO loan (loan_amount, start_date, upto_date, bank_ac_num)
        VALUES (${loandata.loan_amount}, ${loandata.start_date}, ${loandata.upto_date}, ${loandata.bank_ac_num});`);

        // Return the loan data
        return loandata;
    }

    resource function get bprocess() returns BankProcess[]|error {
        stream<BankProcess, sql:Error?> bpStream = self.db->query(`SELECT * FROM bank_process `);
        return from BankProcess bpdata in bpStream
            select bpdata;
    }
     resource function get bprocess/acnum/[string bank_ac_num]() returns BankProcess|http:NotFound|error {
        BankProcess|sql:Error result = self.db->queryRow(`SELECT * FROM bank_process WHERE bank_ac = ${bank_ac_num}`);
        if result is sql:NoRowsError {
            return http:NOT_FOUND;
        } else {
            return result;
        }
    }

    resource function get bprocess/[string id]() returns BankProcess|http:NotFound|error {
        BankProcess|sql:Error result = self.db->queryRow(`SELECT * FROM bank_process WHERE id = ${id}`);
        if result is sql:NoRowsError {
            return http:NOT_FOUND;
        } else {
            return result;
        }
    }

    resource function post sendbprocess(@http:Payload BankProcess bpdata) returns BankProcess|error {
        _ = check self.db->execute(`
            INSERT INTO bank_process ( credit_office, bank_manager, mail_unit, bank_ac)
            VALUES ( ${bpdata.credit_office}, ${bpdata.bank_manager}, ${bpdata.mail_unit}, ${bpdata.bank_ac});`);
        return bpdata;
    }
    resource function post updatebprocess(@http:Payload BankProcess bpdata) returns BankProcess|error {
    sql:ExecutionResult|sql:Error result = self.db->execute(`
        UPDATE bank_process 
        SET credit_office = ${bpdata.credit_office}, 
            bank_manager = ${bpdata.bank_manager}, 
            mail_unit = ${bpdata.mail_unit},
            bank_ac = ${bpdata.bank_ac}
        WHERE bank_ac = ${bpdata.bank_ac};
    `);

    if result is sql:Error {
        return result; // Return the SQL error
    }
    return bpdata; // Return the updated HeadOffice data
}

    resource function get pprocess() returns ProvinceProcess[]|error {
        stream<ProvinceProcess, sql:Error?> ppStream = self.db->query(`SELECT * FROM province_office `);
        return from ProvinceProcess ppdata in ppStream
            select ppdata;
    }
 resource function get pprocess/acnum/[string bank_ac_num]() returns ProvinceProcess|http:NotFound|error {
        ProvinceProcess|sql:Error result = self.db->queryRow(`SELECT * FROM province_office WHERE bank_ac = ${bank_ac_num}`);
        if result is sql:NoRowsError {
            return http:NOT_FOUND;
        } else {
            return result;
        }
    }
    resource function get pprocess/[string id]() returns ProvinceProcess|http:NotFound|error {
        ProvinceProcess|sql:Error result = self.db->queryRow(`SELECT * FROM province_office WHERE id = ${id}`);
        if result is sql:NoRowsError {
            return http:NOT_FOUND;
        } else {
            return result;
        }
    }

    resource function post sendpprocess(@http:Payload ProvinceProcess ppdata) returns ProvinceProcess|error {
        _ = check self.db->execute(`
            INSERT INTO province_office ( credit_officer, area_manager, ag_manager, mail_unit, bank_ac)
            VALUES ( ${ppdata.credit_officer}, ${ppdata.area_manager}, ${ppdata.ag_manager}, ${ppdata.mail_unit}, ${ppdata.bank_ac});`);
        return ppdata;
    }
resource function post updatepprocess(@http:Payload ProvinceProcess ppdata) returns ProvinceProcess|error {
    sql:ExecutionResult|sql:Error result = self.db->execute(`
        UPDATE province_office 
        SET credit_officer = ${ppdata.credit_officer}, 
            area_manager = ${ppdata.area_manager}, 
            ag_manager = ${ppdata.ag_manager}, 
            mail_unit = ${ppdata.mail_unit},
            bank_ac = ${ppdata.bank_ac}
        WHERE bank_ac = ${ppdata.bank_ac};
    `);

    if result is sql:Error {
        return result; // Return the SQL error
    }
    return ppdata; // Return the updated HeadOffice data
}

    resource function get hprocess() returns HeadOffice[]|error {
        stream<HeadOffice, sql:Error?> hpStream = self.db->query(`SELECT * FROM head_office `);
        return from HeadOffice hpdata in hpStream
            select hpdata;
    }
resource function get hprocess/acnum/[string bank_ac_num]() returns HeadOffice|http:NotFound|error {
        HeadOffice|sql:Error result = self.db->queryRow(`SELECT * FROM head_office WHERE bank_ac = ${bank_ac_num}`);
        if result is sql:NoRowsError {
            return http:NOT_FOUND;
        } else {
            return result;
        }
    }
    resource function get hprocess/[string id]() returns HeadOffice|http:NotFound|error {
        HeadOffice|sql:Error result = self.db->queryRow(`SELECT * FROM head_office WHERE id = ${id}`);
        if result is sql:NoRowsError {
            return http:NOT_FOUND;
        } else {
            return result;
        }
    }

    resource function post sendhprocess(@http:Payload HeadOffice hpdata) returns HeadOffice|error {
        _ = check self.db->execute(`
            INSERT INTO head_office ( branch_cu, credit_office, ag_manager, dg_manager, bank_ac)
            VALUES ( ${hpdata.branch_cu}, ${hpdata.credit_office}, ${hpdata.ag_manager}, ${hpdata.dg_manager}, ${hpdata.bank_ac});`);
        return hpdata;
    }
resource function post updatehprocess(@http:Payload HeadOffice hpdata) returns HeadOffice|error {
    sql:ExecutionResult|sql:Error result = self.db->execute(`
        UPDATE head_office 
        SET branch_cu = ${hpdata.branch_cu}, 
            credit_office = ${hpdata.credit_office}, 
            ag_manager = ${hpdata.ag_manager}, 
            dg_manager = ${hpdata.dg_manager},
            bank_ac = ${hpdata.bank_ac}
        WHERE bank_ac = ${hpdata.bank_ac};
    `);

    if result is sql:Error {
        return result; // Return the SQL error
    }
    return hpdata; // Return the updated HeadOffice data
}


}

