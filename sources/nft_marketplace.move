// module ticket_platform::nft_marketplace {
//     use sui::url::{Self, Url};
//     use std::string;
//     use sui::object::{Self, ID, UID};
//     use sui::event;
//     use sui::transfer;
//     use sui::tx_context::{Self, TxContext};

//     struct NFT has key,store {
//        id: UID ,
//        name: string::String , 
//        url : Url , 
//        power : u64 ,
//        scarcity : u64
//     }

//     struct NFTMinted has copy,drop{
//         id: ID,
//         minted_to : address,
//         power : u64 ,
//         scarcity :u64
//     }

//     public fun view_nft(nft : &NFT):(&string::String , &Url , u64 , u64) {
//        (&nft.name ,&nft.url ,nft.power , nft.scarcity)
//     }

//     public entry fun  mint_nft(name:string::String , url:vector<u8> , power:u64 , scarcity: u64, ctx : &mut TxContext){
//         let nft = NFT{
//             id: object::new(ctx) ,
//             name , 
//             url : url::new_unsafe_from_bytes(url) , 
//             power  ,
//             scarcity
//         };
        
//         event::emit(NFTMinted{
//              id: object::id(&nft),
//              minted_to : tx_context::sender(ctx),
//              power  ,
//              scarcity 
//         });

//         transfer::public_transfer(nft , tx_context::sender(ctx));
//     }


//     public entry fun transfer_nft(nft : NFT , to:address , _ : &mut TxContext){
//         transfer::public_transfer(nft , to);
//     }

//     public entry fun burn_nft(nft: NFT , _:&mut TxContext){
//         let NFT{id ,name:_ ,url :_ ,power :_ , scarcity:_}  = nft;
//         object::delete(id)
//     }

// }