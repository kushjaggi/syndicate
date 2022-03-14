pragma solidity 0.4.0;
//older version check compatability

contract syndicate{
    //defining loan seeker 
    struct LoanSeeker {
        uint companyId;
        string companyName;
        address userAddress;
        bool isLoanSeeker;
    }
    //defining lender
    struct Lender {
        uint lenderId;
        string lenderName;
        address lenderAddress;
        uint term;
        uint amountOffered;
        uint interestRate;
    }
    //defining loan request
    struct LoanRequest{
         uint amountNeeded;
         uint term;
          address loanSeekerAddress;
    }
    //Declaration of arrays and variables
    LoanSeeker[] public loanSeekers;
    LoanRequest[] public loanRequests;
    Lender[] public lenders;
    address public creator;
    uint private loanAmountNeeded;
    string companyName;
    string companyRegNumber;
    string supportingDocument;
    
    //Making the creator owner of smart contract
    function syndicate(){
        creator = msg.sender; //who is sending the message
    }
    //inputs loan seekers name
      function getAllTheLoanSeekers() constant returns (string) 
    {
                return loanSeekers[0].companyName;//returns only 1st loan seeker
    }
    //inputs loan seekers company name
    function getCompanyName() constant returns (string) {
        return companyName;
    }
    
    //inputs company registration number
    function getCompanyregnumber()constant returns (string){
        return companyRegNumber;
    }
    //checks if creator gives access otherwise denies
    modifier ifCreator(){
        if(msg.sender == creator){
            _;
        }
        else{
            throw;
        }
    }
    //checks if caller is lender
      modifier ifLender(){
        if(msg.sender == creator){
            _;
        }
        else{
           throw;
        }
    }
    //checks if the caller is a loan seeker
        modifier ifLoanSeeker(){
        if(msg.sender == creator){
            _;
        }
        else{
           throw;
        }
    }
    //checks if the loan seeker is valid or in the list and checks company id
      function validateLoanSeekerRequest(uint _companyId) returns(bool){
          bool isInTheList;
            for(uint i=0 ; i<loanSeekers.length; i++){
              if(loanSeekers[i].companyId == _companyId){
                  return true;
              }
             }
    }
    //checks if the function caller is the owner and input company id , loan amount, term for loan and supporting document
    function raiseLoanRequest(uint _companyId,uint _loanAmountNeeded, uint _term, string _supportingDocument) ifLender{
               if(msg.sender == creator){
                  loanRequests.length++;
                    uint index = loanRequests.length-1;
                    loanRequests[index].amountNeeded = _loanAmountNeeded;
                    loanRequests[index].term =_term;
                    
                    if(validateLoanSeekerRequest(_companyId)){
                       throw;
                    }
                    loanRequests[index].loanSeekerAddress =msg.sender;
    
                    
               }
                
    }
    //checks from ifLoanseeker and return values to the parameters 
    function addLoanSeeker(uint _companyId, string _companyName) ifLoanSeeker{
               if(msg.sender == creator){
                    //   validateUser();
               loanSeekers.length++;
                    uint index = loanSeekers.length-1;
                    loanSeekers[index].companyName=_companyName;
                    loanSeekers[index].companyId =_companyId;
                    loanSeekers[index].userAddress =msg.sender;

        }
    }
    //checks from ifLender and return values to the parameters 
    function addlender(  uint _lenderId, uint _amountOffered, uint _interestRate,  uint _term, string _lenderName) ifLender{
               if(msg.sender == creator){
                    //   validateUser();
                    lenders.length++;
                    uint index = lenders.length-1;
                    lenders[index].lenderId=_lenderId;
                    lenders[index].lenderName =_lenderName;
                    lenders[index].term =_term;
                    lenders[index].amountOffered =_amountOffered;
                    lenders[index].interestRate =_interestRate;

        }
    }
    //checks with lenderid and return lender name 
    function getlender(uint id) returns (string){
         for(uint i=0 ; i<lenders.length; i++){
              if(lenders[i].lenderId == id){
                  return lenders[i].lenderName;
              }
             }
    } 
    

    
}
