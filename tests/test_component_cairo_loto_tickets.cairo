// TODO: Test the component functionality via deployment of the Mock contract.

use poc_tickets_component::utils::mocks::ticket_mock::CairoLotoTicketMock;
use poc_tickets_component::interfaces::cairo_loto_ticket::ICairoLotoTicket;
use poc_tickets_component::interfaces::cairo_loto_ticket::{ICairoLotoTicketDispatcher, ICairoLotoTicketDispatcherTrait,};
use poc_tickets_component::utils::constants::{TEN_WITH_6_DECIMALS, fake_ERC20_asset,};
use starknet::{ContractAddress, SyscallResultTrait,};
// use poc_tickets_component::utils;
// use poc_tickets_component::utils::{deploy,};
// use poc_tickets_component::utils::{SerializedAppend,};

// use poc_tickets_component::interfaces::cairo_loto_ticket;
// // use poc_tickets_component::interfaces::cairo_loto_ticket::{ICairoLotoTicket, ICairoLotoTicketDispatcher, ICairoLotoTicketDispatcherTrait,};
// use starknet::{ContractAddress, contract_address_const, deploy_syscall, SyscallResultTrait,};

// #############################################################################
fn setup_ticket() -> ICairoLotoTicketDispatcher {
    let (address, _) = starknet::deploy_syscall(
        CairoLotoTicketMock::TEST_CLASS_HASH.try_into().unwrap(), 0, array![].span(), false
    )
        .unwrap_syscall();
    ICairoLotoTicketDispatcher { contract_address: address }
}
// #############################################################################



#[test]
fn _test_underlying_erc20_asset() {}

#[test]
fn _ticket_value() {}

// Tests for other internal methods
// {...}

#[test]
fn test_initializer() {}

#[test]
fn test_constructor() {
    let cairo_loto_tickets = setup_ticket();

    assert_eq!(cairo_loto_tickets.underlying_erc20_asset(), fake_ERC20_asset());
    assert_eq!(cairo_loto_tickets.ticket_value(), TEN_WITH_6_DECIMALS);
}

#[test]
fn test_underlying_erc20_asset() {}

#[test]
fn ticket_value() {}

// Tests for other external functions
// {...}





// -----------------------------------------------------------------------------
// TODO ALSO: Test the component functionality without deploying the Mock contract.
// use poc_tickets_component::components::cairo_loto_ticket::CairoLotoTicketComponent;

// type TestingState = CairoLotoTicketComponent::ComponentState<CairoLotoTicketMock::ContractState>;

// impl TestingStateDefault of Default<TestingState> {
//     fn default() -> TestingState {
//         CounterComponent::component_state_for_testing()
//     }
// }