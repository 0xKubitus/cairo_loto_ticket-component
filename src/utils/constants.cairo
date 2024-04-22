use starknet::{ContractAddress,};
use starknet::{contract_address_const,};


const TEN_WITH_6_DECIMALS: u256 = 10000000;


fn fake_ERC20_asset() -> ContractAddress {
    contract_address_const::<'fake_ERC20_asset'>()
}