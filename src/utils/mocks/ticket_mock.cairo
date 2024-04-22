//
// MOCK CONTRACT
//
#[starknet::contract]
pub mod CairoLotoTicketMock {
    use poc_tickets_component::interfaces::cairo_loto_ticket::ICairoLotoTicket;
    use poc_tickets_component::components::cairo_loto_ticket::CairoLotoTicket;
    use poc_tickets_component::components::cairo_loto_ticket::CairoLotoTicket::TicketInternalTrait;
    use poc_tickets_component::utils;
    use poc_tickets_component::utils::constants::{TEN_WITH_6_DECIMALS, fake_ERC20_asset,};
    use starknet::ContractAddress;

    component!(path: CairoLotoTicket, storage: cairo_loto_ticket, event: TicketEvent);


    #[storage]
    struct Storage {
        #[substorage(v0)]
        cairo_loto_ticket: CairoLotoTicket::Storage,
    }


    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        TicketEvent: CairoLotoTicket::Event,
    }


    #[constructor]
    fn constructor(ref self: ContractState, underlying_asset: ContractAddress,) {
        // let asset: ContractAddress = fake_ERC20_asset();
        let ticket_value: u256 = TEN_WITH_6_DECIMALS; 
        
        self.cairo_loto_ticket.initializer(underlying_asset, ticket_value);
    }


    //
    // External/Public functions
    //
    #[abi(embed_v0)]
    impl CairoLotoTicketImpl = CairoLotoTicket::TicketExternals<ContractState>;


    //
    // Internal/Private functions
    //
    impl TicketInternalImpl = CairoLotoTicket::TicketInternalImpl<ContractState>;
}