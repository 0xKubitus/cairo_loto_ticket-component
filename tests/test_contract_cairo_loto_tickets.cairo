use poc_tickets_component::contracts::cairo_loto_tickets::{CairoLotoTickets, ICairoLotoTickets,};
use poc_tickets_component::contracts::cairo_loto_tickets::CairoLotoTickets::{TicketsInternalImpl, TicketsInternalTrait,};
use starknet::{ContractAddress, contract_address_const};


// const ETH_ADRS: ContractAddress = 0x;


//TODO: Test Internal functions:
#[test]
fn test_initializer() {
    let mut state = CairoLotoTickets::contract_state_for_testing();
    let underlying_erc20: ContractAddress = contract_address_const::<0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7>(); // <= ETH contract address

    state.initializer(underlying_erc20);

    let addrs = state._underlying_erc20_asset();
    assert_eq!(addrs, underlying_erc20)
}

// #[test]
// fn test__underlying_erc20_asset() {
//     let mut state = CairoLotoTickets::contract_state_for_testing();
//     let underlying_erc20: ContractAddress = contract_address_const::<0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7>(); // <= ETH contract address

// }

//TODO: Test the constructor function:
// fn test_constructor(ref self: ContractState, asset: ContractAddress) {}

//TODO: Test External functions:
// fn test_underlying_erc20_asset(ref self: ContractState) -> ContractAddress {}