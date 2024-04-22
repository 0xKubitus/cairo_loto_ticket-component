// TODO: Test the component's external/public functions via deployment of the Mock contract.
//! (This method does not seem to support testing of internal/public functions)

use poc_tickets_component::utils::mocks::ticket_mock::CairoLotoTicketMock;
use poc_tickets_component::interfaces::cairo_loto_ticket::ICairoLotoTicket;
use poc_tickets_component::interfaces::cairo_loto_ticket::{ICairoLotoTicketDispatcher, ICairoLotoTicketDispatcherTrait,};
use poc_tickets_component::utils::constants::{TEN_WITH_6_DECIMALS, ETH_ADDRS, OWNER, fake_ERC20_asset,};
use poc_tickets_component::utils;
use poc_tickets_component::utils::{SerializedAppend,};
use starknet::{ContractAddress, SyscallResultTrait,};
use starknet::testing;


// use poc_tickets_component::interfaces::cairo_loto_ticket;
// // use poc_tickets_component::interfaces::cairo_loto_ticket::{ICairoLotoTicket, ICairoLotoTicketDispatcher, ICairoLotoTicketDispatcherTrait,};
// use starknet::{contract_address_const, deploy_syscall,};




// #############################################################################
fn setup_eth_ticket() -> ICairoLotoTicketDispatcher {
    let mut calldata = array![];
    calldata.append_serde(ETH_ADDRS());

    testing::set_contract_address(OWNER()); 
    //? using `set_contract_address` in a test will indicate
    //? to the test runnerat which address it must lookup for storage…
    // is this useful in this case, though?

    let address = utils::deploy(CairoLotoTicketMock::TEST_CLASS_HASH, calldata);
    ICairoLotoTicketDispatcher { contract_address: address }
}
fn fake_erc20_ticket_setup() -> ICairoLotoTicketDispatcher {
    let mut calldata = array![];
    calldata.append_serde(fake_ERC20_asset());

    testing::set_contract_address(OWNER()); 
    //? using `set_contract_address` in a test will indicate
    //? to the test runnerat which address it must lookup for storage…
    // is this useful in this case, though?

    let address = utils::deploy(CairoLotoTicketMock::TEST_CLASS_HASH, calldata);
    ICairoLotoTicketDispatcher { contract_address: address }
}
// #############################################################################




#[test]
fn test_initializer() {}

#[test]
fn test_constructor() {
    let ticket_component = fake_erc20_ticket_setup();

    assert_eq!(ticket_component.underlying_erc20_asset(), fake_ERC20_asset());
    assert_eq!(ticket_component.ticket_value(), TEN_WITH_6_DECIMALS);
}

#[test]
fn test_underlying_erc20_asset() {
    let ticket_component = setup_eth_ticket();
    assert_eq!(ticket_component.underlying_erc20_asset(), ETH_ADDRS());
}

#[test]
fn ticket_value() {}

#[test]
fn circulating_supply() {}

#[test]
fn total_tickets_emitted() {}







// -----------------------------------------------------------------------------
// TODO ALSO: Test the component functionality without deploying the Mock contract.
//! I THINK I AM OBLIGED TO USE THIS IN ORDER TO TEST INTERNAL/PRIVATE METHODS

use poc_tickets_component::components::cairo_loto_ticket::CairoLotoTicket;

type TestingState = CairoLotoTicket::ComponentState<CairoLotoTicketMock::ContractState>;

impl TestingStateDefault of Default<TestingState> {
    fn default() -> TestingState {
        CairoLotoTicket::component_state_for_testing()
    }
}


use poc_tickets_component::components::cairo_loto_ticket::CairoLotoTicket::TicketInternalImpl;
#[test]
fn test__underlying_erc20_asset() {
    let mut ticket_cmpnt: TestingState = Default::default();

    ticket_cmpnt.initializer(fake_ERC20_asset(), TEN_WITH_6_DECIMALS);

    assert_eq!(ticket_cmpnt._underlying_erc20_asset(), fake_ERC20_asset());
}

// #[test]
// fn test__ticket_value() {}

// // Tests for other private/internal methods
// // {...}



