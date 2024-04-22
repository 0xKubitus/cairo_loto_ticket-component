// use starknet::ContractAddress;

#[starknet::interface]
trait ICairoLotoTicket<TState> {
    fn underlying_erc20_asset(self: @TState) -> starknet::ContractAddress;
    fn ticket_value(self: @TState) -> u256;
    fn circulating_supply(self: @TState) -> u256;
    fn total_tickets_emitted(self: @TState) -> u256;
}
