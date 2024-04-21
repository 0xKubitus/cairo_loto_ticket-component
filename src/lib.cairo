use starknet::ContractAddress;

#[starknet::interface]
pub trait ICairoLotoTickets<TContractState> {
    fn underlying_erc20_asset(ref self: TContractState) -> ContractAddress;

    // fn get_this(self: @TContractState) -> xxx;
    // fn get_this(self: @TContractState) -> xxx;
    // fn get_this(self: @TContractState) -> xxx;
    
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
        // value: u256,
        // circulating_supply: u256,
        // total_tickets_emitted: u256,
    }


    #[constructor]
    fn constructor(ref self: ContractState, asset: ContractAddress) {
        self.initializer(asset);
    }



    //
    // External/Public functions
    //
    #[abi(embed_v0)]
    impl CairoLotoTicketsImpl of super::ICairoLotoTickets<ContractState> {
        fn underlying_erc20_asset(ref self: ContractState) -> ContractAddress {
            self._underlying_erc20_asset()
        }

        // fn get_this() -> {}
        // fn get_this() -> {}
        // fn get_this() -> {}

        // ---------------------------------

        // fn set_this() {}
        // fn set_this() {}
        // fn set_this() {}
    }



    //
    // Internal/Private functions
    //
    #[generate_trait]
    impl TicketsInternalImpl of TicketsInternalTrait {
        fn initializer(ref self: ContractState, asset: ContractAddress) {
            self.underlying_asset.write(asset);
        }
        // TODO: Test current version of the contract, then
        //! complete above `fn initializer()` with additional
        //! Storage values to set at contract deployment

        // ---------------------------------

        fn _underlying_erc20_asset(ref self: ContractState) -> ContractAddress {
            let asset: ContractAddress = self.underlying_asset.read();
            match asset.is_zero() {
                bool::False(()) => asset,
                bool::True(()) => panic_with_felt252('Error = ERC20 backing asset')
            }

        }

        // ---------------------------------

        // fn _get_this() -> {}

        // fn _set_this() {}

        // ---------------------------------

        // fn _get_this() -> {}

        // fn _set_this() {}

        // ---------------------------------

        // fn _get_this() -> {}

        // fn _set_this() {}
    }




}