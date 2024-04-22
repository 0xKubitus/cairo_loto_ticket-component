use poc_tickets_component::contracts::cairo_loto_ticket::{
    CairoLotoTickets, ICairoLotoTickets, ICairoLotoTicketsDispatcher,
    ICairoLotoTicketsDispatcherTrait
};
use poc_tickets_component::contracts::cairo_loto_ticket::CairoLotoTickets::{
    TicketsInternalImpl, TicketsInternalTrait,
};
use poc_tickets_component::contracts::cairo_loto_ticket::CairoLotoTickets::__member_module_total_supply::InternalContractMemberStateTrait as total;
use poc_tickets_component::contracts::cairo_loto_ticket::CairoLotoTickets::__member_module_current_supply::InternalContractMemberStateTrait as circ;
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

fn fake_ERC20_asset() -> ContractAddress {
    contract_address_const::<'fake_ERC20_asset'>()
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
    state.initializer(fake_ERC20_asset(), TEN_WITH_6_DECIMALS);

    let addrs = state._underlying_erc20_asset();
    assert_eq!(addrs, fake_ERC20_asset());

    let amount = state._ticket_value();
    assert_eq!(amount, TEN_WITH_6_DECIMALS);
}

#[test]
fn test__underlying_erc20_asset() {
    let mut state = CairoLotoTickets::contract_state_for_testing();

    state.initializer(fake_ERC20_asset(), TEN_WITH_6_DECIMALS);

    let addrs = state._underlying_erc20_asset();
    assert_eq!(addrs, fake_ERC20_asset())
}

#[test]
fn test__ticket_value() {
    let mut state = CairoLotoTickets::contract_state_for_testing();

    state.initializer(fake_ERC20_asset(), TEN_WITH_6_DECIMALS);

    let amount = state._ticket_value();
    assert_eq!(amount, TEN_WITH_6_DECIMALS);
}

#[test]
fn test__circulating_supply() {
    let mut state = CairoLotoTickets::contract_state_for_testing();
    state.current_supply.write(10);

    let amount = state._circulating_supply();
    assert_eq!(amount, 10_u256);
}
#[test]
fn test__increase_circulating_supply() {
    let mut state = CairoLotoTickets::contract_state_for_testing();
    state.current_supply.write(10);

    state._increase_circulating_supply();

    let amount = state._circulating_supply();
    assert_eq!(amount, 11);
}
#[test]
fn test__decrease_circulating_supply() {
    let mut state = CairoLotoTickets::contract_state_for_testing();
    state.current_supply.write(10);

    state._decrease_circulating_supply();

    let amount = state.current_supply.read();
    assert_eq!(amount, 9);
}

#[test]
fn test__total_tickets_emitted() {
    let mut state = CairoLotoTickets::contract_state_for_testing();
    state.total_supply.write(10);

    let amount = state._total_tickets_emitted();
    assert_eq!(amount, 10);
}
#[test]
fn test__increase_total_tickets_emitted() {
    let mut state = CairoLotoTickets::contract_state_for_testing();
    state.total_supply.write(10);

    state._increase_total_tickets_emitted();

    let amount = state._total_tickets_emitted();
    assert_eq!(amount, 11);
}


//TODO: Test the constructor function:
#[test]
fn test_constructor() {
    // ----------------------------------------------------------------
    //? To be moved into Setup/utils
    //? to create a setup like 
    //? OZ's "setup_dispatcher_with_event()"
    let mut calldata = array![];
    calldata.append_serde(fake_ERC20_asset());
    calldata.append_serde(TEN_WITH_6_DECIMALS);

    let address = deploy(CairoLotoTickets::TEST_CLASS_HASH, calldata);
    let dispatcher = ICairoLotoTicketsDispatcher { contract_address: address };
    // ----------------------------------------------------------------

    // Check `underlying_asset` is correct
    assert_eq!(dispatcher.underlying_erc20_asset(), fake_ERC20_asset());

    // Check ticket's `value` is correct
    assert_eq!(dispatcher.ticket_value(), TEN_WITH_6_DECIMALS);

    // Check `current_supply` is correct
    assert_eq!(dispatcher.circulating_supply(), 0);

    // Check `total_supply` is correct
    assert_eq!(dispatcher.total_tickets_emitted(), 0);
}


//TODO: Test External functions:
#[test]
fn test_underlying_erc20_asset() {
    let mut state = CairoLotoTickets::contract_state_for_testing();

    state.initializer(fake_ERC20_asset(), TEN_WITH_6_DECIMALS);

    let addrs = state.underlying_erc20_asset();
    assert_eq!(addrs, fake_ERC20_asset())
}

#[test]
fn test_ticket_value() {
    let mut state = CairoLotoTickets::contract_state_for_testing();

    state.initializer(fake_ERC20_asset(), TEN_WITH_6_DECIMALS);

    let amount = state.ticket_value();
    assert_eq!(amount, TEN_WITH_6_DECIMALS);
}
