pragma solidity 0.4.0;


contract syndicate{
    
    struct LoanSeeker {
        uint companyId;
        string companyName;
        address userAddress;
        bool isLoanSeeker;
    }
    
    struct Lender {
        uint lenderId;
        string lenderName;
        address lenderAddress;
        uint term;
        uint amountOffered;
        uint interestRate;
    }
    
    struct LoanRequest{
         uint amountNeeded;
         uint term;
          address loanSeekerAddress;
    }
    
    LoanSeeker[] public loanSeekers;
    LoanRequest[] public loanRequests;
    Lender[] public lenders;
    address public creator;
    uint private loanAmountNeeded;
    string companyName;
    string companyRegNumber;
    string supportingDocument;
    
    function syndicate(){
        creator = msg.sender; //who is sending the message
    }
    
      function getAllTheLoanSeekers() constant returns (string) 
    {
                return loanSeekers[0].companyName;
    }
    
    function getCompanyName() constant returns (string) {
        return companyName;
    }
    
    
         function getCompanyregnumber()constant returns (string){
        return companyRegNumber;
    }
    
    modifier ifCreator(){
        if(msg.sender == creator){
            _;
        }
        else{
            throw;
        }
    }
    
      modifier ifLender(){
        if(msg.sender == creator){
            _;
        }
        else{
           throw;
        }
    }
    
        modifier ifLoanSeeker(){
        if(msg.sender == creator){
            _;
        }
        else{
           throw;
        }
    }
    
      function validateLoanSeekerRequest(uint _companyId) returns(bool){
          bool isInTheList;
            for(uint i=0 ; i<loanSeekers.length; i++){
              if(loanSeekers[i].companyId == _companyId){
                  return true;
              }
             }
    }
    
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
    function getlender(uint id) returns (string){
         for(uint i=0 ; i<lenders.length; i++){
              if(lenders[i].lenderId == id){
                  return lenders[i].lenderName;
              }
             }
    } 
    

    
}