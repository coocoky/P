// P semantics test: two machines, "send", "raise" with payload for non-constant event expressions

event E1 assert 1;
event E2 assert 1: bool;

machine Main {
    var test: bool; 
	var mac: machine;
	var ev1: event;
	var ev2: event;
	var ev3: int;
    start state Real1_Init {
        entry { 
			mac = new Real2();


			ev1 = E1;			
			raise ev1;  		
        } 	
        on E1 do Action1;   
		on null goto Real1_S1;
        exit {  
			ev2 = E2;
            send mac, ev2, test;			 
		}
	}
	state Real1_S1 {
	}
    fun Action1() {
		test = true;
    }
	
}
machine Real2 {
	var pl: bool;
	start state Real2_Init {
		entry {	
		}
		on E2 do (payload: bool) {
			 
			 
				Action2(payload); 
			
			 
			
		}
	}
	fun Action2(payload: bool) {
		assert(payload == false);  //fails
    }
}
