use poc_tickets_component::contracts::cairo_loto_tickets::{CairoLotoTickets, ICairoLotoTickets, ICairoLotoTicketsDispatcher, ICairoLotoTicketsDispatcherTrait};
use poc_tickets_component::contracts::cairo_loto_tickets::CairoLotoTickets::{TicketsInternalImpl, TicketsInternalTrait,};
use starknet::{ContractAddress, contract_address_const, deploy_syscall, SyscallResultTrait,};



// ----------------------------------------------------------------
// SETUP / UTILS

trait SerializedAppend<T> {
    fn append_serde(ref self: Array<felt252>, value: T);
}

impl SerializedAppendImpl<T, impl TSerde: Serde<T>, impl TDrop: Drop<T>> of SerializedAppend<T> {
    fn append_serde(ref self: Array<felt252>, value: T) {
        value.serialize(ref self);
    }
}


fn deploy(contract_class_hash: felt252, calldata: Array<felt252>) -> ContractAddress {
    deploy_with_salt(contract_class_hash, calldata, 0)
}

fn deploy_with_salt(
    contract_class_hash: felt252, calldata: Array<felt252>, salt: felt252
) -> ContractAddress {
    let (address, _) = starknet::deploy_syscall(
        contract_class_hash.try_into().unwrap(), salt, calldata.span(), false
    )
        .unwrap_syscall();
    address
}

fn ERC20_Asset() -> ContractAddress {
    contract_address_const::<'ERC20_Asset'>()
}

// fn ten_with_6_decimals() -> u256 {
//     10_u256
// }
const TEN_WITH_6_DECIMALS: u256 = 10000000;

// ----------------------------------------------------------------



//TODO: Test Internal functions:
#[test]
fn test_initializer() {
    let mut state = CairoLotoTickets::contract_state_for_testing();
    state.initializer(ERC20_Asset(), TEN_WITH_6_DECIMALS);

    let addrs = state._underlying_erc20_asset();
    assert_eq!(addrs, ERC20_Asset());

    let amount = state._ticket_value();
    assert_eq!(amount, TEN_WITH_6_DECIMALS);
}

#[test]
fn test__underlying_erc20_asset() {
    let mut state = CairoLotoTickets::contract_state_for_testing();

    state.initializer(ERC20_Asset(), TEN_WITH_6_DECIMALS);

    let addrs = state._underlying_erc20_asset();
    assert_eq!(addrs, ERC20_Asset())
}

#[test]
fn test__ticket_value() {
    let mut state = CairoLotoTickets::contract_state_for_testing();

    state.initializer(ERC20_Asset(), TEN_WITH_6_DECIMALS);

    let amount = state._ticket_value();
    assert_eq!(amount, TEN_WITH_6_DECIMALS);
}





//TODO: Test the constructor function:
#[test]
fn test_constructor() {
    // ----------------------------------------------------------------
    //? To be moved into Setup/utils
    //? to create a setup like 
    //? OZ's "setup_dispatcher_with_event()"
    let mut calldata = array![];
    calldata.append_serde(ERC20_Asset());
    calldata.append_serde(TEN_WITH_6_DECIMALS);

    let address = deploy(CairoLotoTickets::TEST_CLASS_HASH, calldata);
    let dispatcher = ICairoLotoTicketsDispatcher { contract_address: address};
    // ----------------------------------------------------------------

    // Check `underlying_asset` is correct
    assert_eq!(dispatcher.underlying_erc20_asset(), ERC20_Asset());

    // Check ticket's `value` is correct
    assert_eq!(dispatcher.ticket_value(), TEN_WITH_6_DECIMALS);

    // Check `current_supply` is correct
    // Check `total_supply` is correct


}





//TODO: Test External functions:
#[test]
fn test_underlying_erc20_asset() {
    let mut state = CairoLotoTickets::contract_state_for_testing();

    state.initializer(ERC20_Asset(), TEN_WITH_6_DECIMALS);

    let addrs = state.underlying_erc20_asset();
    assert_eq!(addrs, ERC20_Asset())
}

#[test]
fn test_ticket_value() {
    let mut state = CairoLotoTickets::contract_state_for_testing();

    state.initializer(ERC20_Asset(), TEN_WITH_6_DECIMALS);

    let amount = state.ticket_value();
    assert_eq!(amount, TEN_WITH_6_DECIMALS);
}