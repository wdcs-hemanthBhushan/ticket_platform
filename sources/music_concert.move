module book_my_ticket_platform::dont_my_ticket_coin{
    use sui::tx_context::{Self, TxContext};
    use sui::coin::{Self , Coin ,TreasuryCap };
    use std::option;
    use sui::url;
    use sui::transfer;
    use sui::event;
    
    struct DONT_MY_TICKET_COIN has drop{}


    //events 

    struct TokenMinted has copy,drop {
        minter : address , 
        mint_amount : u64
    }

    struct TokenBurnt has copy,drop {
        burner : address , 
        burnt_amount : u64 
    }

    fun init(otw: DONT_MY_TICKET_COIN, ctx: &mut TxContext){
      let(treasuryCap ,coinMetadata ) =  coin::create_currency(otw ,
          9 ,
          b"BMTC", 
          b"DONT_MY_TICKET_COIN" , 
          b"Coin used for booking the tickect for concerts" , 
          option::some(url::new_unsafe_from_bytes(b"https://www.google.com/search?gs_ssp=eJzj4tLP1Tcwzk0ut0xRYDRgdGDw4knKz89WyK1UKCnKLAAAe4YInw&q=book+my+trip&oq=book+&gs_lcrp=EgZjaHJvbWUqEAgFEC4YxwEYsQMY0QMYgAQyBggAEEUYOTIYCAEQLhhDGIMBGMcBGLEDGNEDGIAEGIoFMgwIAhAAGAoYyQMYgAQyDAgDEAAYChiSAxiABDINCAQQABiSAxiABBiKBTIQCAUQLhjHARixAxjRAxiABDIGCAYQRRg8MgYIBxAFGEDSAQgzMTY2ajBqN6gCALACAA&sourceid=chrome&ie=UTF-8")),
          ctx
           );

          transfer::public_freeze_object(coinMetadata);

          let coin_obj :Coin<DONT_MY_TICKET_COIN> = coin::mint(&mut treasuryCap, 1000000000000,ctx);

          transfer::public_transfer(coin_obj ,tx_context::sender(ctx) );

          transfer::public_transfer(treasuryCap ,tx_context::sender(ctx) );
    
    }

    public entry fun mint_and_transfer<DONT_MY_TICKET_COIN>(cap:&mut TreasuryCap<DONT_MY_TICKET_COIN>, mint_amount: u64,to: address , ctx: &mut TxContext){
        coin::mint_and_transfer<DONT_MY_TICKET_COIN>(cap , mint_amount,to, ctx);
        event::emit(TokenMinted{
            minter : tx_context::sender(ctx) ,
            mint_amount 
        })
    }




     //entry function can return the values in the sui
    public entry fun burn<DONT_MY_TICKET_COIN>(cap: &mut TreasuryCap<DONT_MY_TICKET_COIN>, c: Coin<DONT_MY_TICKET_COIN>,ctx: &mut TxContext){
       let burnt_amount : u64 = coin::burn<DONT_MY_TICKET_COIN>(cap,c);
        event::emit(TokenBurnt{
            burner : tx_context::sender(ctx) ,
            burnt_amount 
        })
    }

   public entry fun transfer_coin(coin : Coin<DONT_MY_TICKET_COIN> , to :address , _ : &mut TxContext){
         transfer::public_transfer(coin , to)
     }

   public entry fun create_zero_value<DONT_MY_TICKET_COIN>(ctx : &mut TxContext){

    let zero_coin = coin::zero<DONT_MY_TICKET_COIN>(ctx);

    transfer::public_transfer(zero_coin , tx_context::sender(ctx));
   }  

   public entry fun delete_zero_value<DONT_MY_TICKET_COIN>(c: Coin<DONT_MY_TICKET_COIN>,_ :&mut TxContext){
    coin::destroy_zero<DONT_MY_TICKET_COIN>(c)
   }
}