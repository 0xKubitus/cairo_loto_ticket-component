use starknet::ContractAddress;

#[starknet::interface]
pub trait ICairoLotoTickets<TContractState> {
    fn underlying_erc20_asset(self: @TContractState) -> ContractAddress;
    fn ticket_value(self: @TContractState) -> u256;

    // fn circulating_supply(self: @TContractState) -> u256;
    // fn total_tickets_emitted(self: @TContractState) -> u256;
    
    // fn set_that(ref self: TContractState, name: felt252, );
    // fn set_that(ref self: TContractState, name: felt252, );
    // fn set_that(ref self: TContractState, name: felt252, );
}


#[starknet::contract]
mod CairoLotoTickets {
    use starknet::{ContractAddress,};

    #[storage]
    struct Storage {
        underlying_asset: ContractAddress,
        value: u256,
        // current_supply: u256,
        // total_supply: u256,
    }


    #[constructor]
    fn constructor(ref self: ContractState, asset: ContractAddress, value: u256,) {
        self.initializer(asset, value);
    }


    //
    // External/Public functions
    //
    #[abi(embed_v0)]
    impl CairoLotoTicketsImpl of super::ICairoLotoTickets<ContractState> {
        // Getters
        fn underlying_erc20_asset(self: @ContractState) -> ContractAddress {
            self._underlying_erc20_asset()
        }

        //TODO: Test this
        fn ticket_value(self: @ContractState) -> u256 {
            self._ticket_value()
        }
        // fn circulating_supply(self: @ContractState) -> u256 {

        // }
        // fn total_tickets_emitted(self: @ContractState) -> u256 {

        // }

        // Setters
        // (none required)
    }



    //
    // Internal/Private functions
    //
    #[generate_trait]
    impl TicketsInternalImpl of TicketsInternalTrait {
        // TODO: Test current version of the contract, then
        //! complete below `fn initializer()` with additional
        //! Storage values to set at contract deployment
        fn initializer(ref self: ContractState, asset: ContractAddress, ticket_value: u256,) {
            self.underlying_asset.write(asset);
            self.value.write(ticket_value);
        }

        // ---------------------------------

        fn _underlying_erc20_asset(self: @ContractState) -> ContractAddress {
            let asset: ContractAddress = self.underlying_asset.read();
            match asset.is_zero() {
                bool::False(()) => asset,
                bool::True(()) => panic_with_felt252('Error = ERC20 backing asset')
            }

        }

        fn _ticket_value(self: @ContractState) -> u256 {
            let amount: u256 = self.value.read();
            match amount < 1 {
               bool::False(()) => amount,
               bool::True(()) => panic_with_felt252('Ticket value cannot be 0')
            }
        }

        // ---------------------------------

        // fn _circulating_supply(self: @ContractState) -> u256 {}

        // fn _increase_circulating_supply(ref self: ContractState) {}
        // fn _decrease_circulating_supply(ref self: ContractState) {}

        // ---------------------------------

        // fn _total_tickets_emitted(self: @ContractState) -> u256 {}

        // fn _increase_total_tickets_emitted(ref self: ContractState) {}
    }




}


// NOTES:
// 1 -> No setter methods (neither internal nor external) for both 'underlying_asset' and 'ticket_value'
//      because these should not evolve once set by the `initializer()` function.

// 2 -> No external setter functions for "circulating_supply" nor "total_tickets_sold"
//      because these values should only evolve when tickets are either minted or burnt.