// initializing the CFA Library
pragma solidity 0.8.13;

import { 
    ISuperfluid 
} from "@superfluid-finance/contracts/interfaces/superfluid/ISuperfluid.sol";

import { 
    ISuperToken 
} from "@superfluid-finance/contracts/interfaces/superfluid/ISuperToken.sol";

import {
    SuperTokenV1Library
} from "@superfluid-finance/contracts/apps/SuperTokenV1Library.sol";

contract Manager {

    using SuperTokenV1Library for ISuperToken;
    ISuperToken public token;
    
    constructor(ISuperToken _token) {
        token = _token;
    }
    //your contract code here...
}
