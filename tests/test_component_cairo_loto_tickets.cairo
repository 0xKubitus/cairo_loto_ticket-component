// #################################################################
// MOCK CONTRACT
#[starknet::contract]
mod CairoLotoTicketMock {
    use poc_tickets_component::components::cairo_loto_ticket::CairoLotoTicketComponent::TicketInternalTrait;
use poc_tickets_component::components::cairo_loto_ticket::CairoLotoTicketComponent;
    use poc_tickets_component::interfaces::ticket::ICairoLotoTicket;

    component!(path: CairoLotoTicketComponent, storage: cairo_loto_ticket, event: TicketEvent);


    #[storage]
    struct Storage {
        #[substorage(v0)]
        cairo_loto_ticket: CairoLotoTicketComponent::Storage,
    }


    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        TicketEvent: CairoLotoTicketComponent::Event,
    }


    #[constructor]
    fn constructor(ref self: ContractState,) {
        // TODO: create a file to store all 'utils' for testing and import it in test files including this one.
        let underlying_asset: ContractAddress = fake_ERC20_asset(); //? "fake_ERC20_asset()" is already declared, but in another test file... (see above)
        let ticket_value: u256 = TEN_WITH_6_DECIMALS; //? SAME AS ABOVE 
        
        self.cairo_loto_ticket.initializer(underlying_asset, ticket_value);
    }


    //
    // External/Public functions
    //
    #[abi(embed_v0)]
    impl CairoLotoTicketImpl = CairoLotoTicketComponent::TicketExternals<ContractState>;


    //
    // Internal/Private functions
    //
    impl TicketInternalImpl = CairoLotoTicketComponent::TicketInternalImpl<ContractState>;
}
// #################################################################



// TODO ALSO: Test the component functionality via deployment of the Mock contract