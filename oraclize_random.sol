...
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract IEF_Betting is usingOraclize {
	...
	uint randomNumber = -1;

	function __callback(bytes32 _queryId, string _result, bytes _proof) {
		require (msg.sender == oraclize_cbAddress());
		
		if (oraclize_randomDS_proofVerify__returnCode(_queryId, _result, _proof) == 0) {
			randomNumber = parseInt(result) % 2;
		}
	}
	
	function closeBet(uint256 id) public returns (bool) {
		...
		oraclize_setProof(proofType_Android);
		bytes32 queryId = oraclize_newRandomDSQuery(0, 1, 200000); //delay = 0, bytes = 1, gas = 2000000
	
		if(randomNumber != -1)
			betting[id].randomResult = randomNumber;
		else
			betting[id].randomResult = int8(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % 2);
		...
	}
}
