KJOXERR ; Murat Khemesh, Error processing stack example
 ;;
 ;-----------------------------------------------------
 ;
 ; Main function calls the two scenarios
 ;
 ;-----------------------------------------------------
MAIN
 W "MAIN BEFORE",!
 DO DISPLAY
 WRITE "#############################",!
 DO SCNRIO1
 WRITE "MAIN END OF SENARIO 1",!
 WRITE "#############################",!
 DO SCNRIO2
 WRITE "MAIN END OF SENARIO 2",!
 WRITE "#############################",!
 DO DISPLAY
 W "MAIN AFTER",!
 QUIT
 ;-----------------------------------------------------
 ;
 ; Scenario 1: calls TRAP1 when $ECODE is set
 ;
 ;-----------------------------------------------------
SCNRIO1
 NEW $ETRAP
 ;CALLING ERR1 WITH TRAP1
 WRITE ?$$TAB,"ERR1 WITH TRAP1",!
 S $ETRAP="D TRAP1^KJOXERR"
 D ERR1
 QUIT
 ;-----------------------------------------------------
 ;
 ; Scenario 2: calls TRAP2 when $ECODE is set
 ;
 ;-----------------------------------------------------
SCNRIO2
 NEW $ETRAP
 ;CALLING ERR1 WITH TRAP2
 WRITE ?$$TAB,"ERR1 WITH TRAP2",!
 S $ETRAP="D TRAP2^KJOXERR"
 D ERR1
 Q
 ;-----------------------------------------------------
 ;
 ; ERR1: Calls ERR2 then Set $ECODE to a custom message
 ;
 ;-----------------------------------------------------
ERR1
 D ERR2^KJOXERR
 W ?$$TAB,"ERR1 BEFORE",!
 SET $ECODE=",UKJOX ERROR 1,"
 W ?$$TAB,"ERR1 AFTER"
 Q
 ;-----------------------------------------------------
 ;
 ; ERR2: set $ECODE to a custom message
 ;
 ;-----------------------------------------------------
ERR2
 W ?$$TAB,"ERR2 BEFORE",!
 SET $ECODE=",UKJOX ERROR 2,"
 W ?$$TAB,"ERR2 AFTER"
 Q
 ;-----------------------------------------------------
 ;
 ; TRAP1: displays the stack levels data then clear $ECODE
 ;
 ;-----------------------------------------------------
TRAP1
 WRITE ?$$TAB,"TRAP1 (DISPLAY STACK AND CLEAR $ECODE)",!
 DO DISPLAY
 ;CLEARING $ECODE TO RETURN TO THE PRE-STACK LEVEL
 SET $ECODE=""
 Q
 ;-----------------------------------------------------
 ;
 ; TRAP2: displays the stack level data and keep $ECODE value
 ;
 ;-----------------------------------------------------
TRAP2
 WRITE ?$$TAB,"TRAP2 (DISPLAY STACK)",!
 DO DISPLAY
 ; $ECODE NOT EMPTY FROM THE FIRST ERROR
 Q
 ;-----------------------------------------------------
 ;
 ; DISPLAY: show stack levels data
 ;
 ;-----------------------------------------------------
DISPLAY
 NEW dsm1,l,i
 set dsm1=($stack(-1)-1)
 write !,?($$TAB-10),"$stack(-1):",dsm1
 for l=dsm1:-1:0 do
 . write !,?($$TAB-6),l
 . for i="ecode","place","mcode" write ?$$TAB,"   ",i,"    ",$stack(l,i),!
 Q
 ;-----------------------------------------------------
 ;
 ; TAB: used for formating output data
 ;
 ;-----------------------------------------------------
TAB()
 QUIT ($stack(-1)-1)*6
