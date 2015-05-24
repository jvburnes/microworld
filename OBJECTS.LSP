~
~  OBJECTS
~
(PRINT 'OBJECTS)

(PACKAGE OBJECTS
    (PUT SIZE S1 S2 S3 S4 S5)
    (PUT COLOR S1 S2 S3)
    (PUT LENGTH S1)
    (PUT CONTAINS TOOLBOX1 CLOSET1)
    (PUT OBDESCR DROID1 WE TOOLBOX1 CAN1 CROWBAR1 BATTERY1 CLOSET1 PHASER1)
    (PUT DROIDTYPE DROID1)
    (PUT SOUND DROID1)
    (PUT CANTYPE CAN1)
    (PUT POSTPROC DROID)
    (PUT PREPROC DROID1)
    (PUT INSCRIPT PHASER1)
    (PUT EXTXT PHASER1)
    (FLAG GLUED CLOSET1)
    (PUT HOLDER TOOLBOX1 CAN1 CROWBAR1 BATTERY1 CLOSET1 PHASER1)
    (PUT OPENERS CLOSET1)
    (FLAG LOCKED CLOSET1)
    (FLAG HOLDS TOOLBOX1 CLOSET1 PHASER1)
    (FLAG ROOM WEAPNRM OBSERM LOBBY ELEVATOR)
    (FLAG OPEN WE))

(PUT 'S1
     'LARGE
     'SIZE)

(PUT 'S2
     'LARGE
     'SIZE)

(PUT 'S3
     'LARGE
     'SIZE)

(PUT 'S4
     'SMALL
     'SIZE)

(PUT 'S5
     'SMALL
     'SIZE)

(PUT 'S1
     'BLUE
     'COLOR)

(PUT 'S2
     'RED
     'COLOR)

(PUT 'S3
     'RED
     'COLOR)

(PUT 'S1
     '7
     'LENGTH)

(PUT 'TOOLBOX1
     '(CAN1 CROWBAR1 BATTERY1)
     'CONTAINS)

(PUT 'CLOSET1
     '(PHASER1)
     'CONTAINS)

(PUT 'DROID1
     '"A squeaky security droid"
     'OBDESCR)

(PUT 'WE
     '"a backpack"
     'OBDESCR)

(PUT 'TOOLBOX1
     '"a toolbox"
     'OBDESCR)

(PUT 'CAN1
     '"an oil can"
     'OBDESCR)

(PUT 'CROWBAR1
     '"a crowbar"
     'OBDESCR)

(PUT 'BATTERY1
     '"a high voltage industrial battery"
     'OBDESCR)

(PUT 'CLOSET1
     '"a closet"
     'OBDESCR)

(PUT 'PHASER1
     '"a dusty hand weapon"
     'OBDESCR)

(PUT 'DROID1
     'SECURITY
     'DROIDTYPE)

(PUT 'DROID1
     'SQUEAKY
     'SOUND)

(PUT 'CAN1
     'OIL
     'CANTYPE)

(PUT 'DROID
     'NIL
     'POSTPROC)

(PUT 'DROID1
     '(PROG (CMD OBJ1 OBJ2 PREP RETFLG GIFT RECIP) (SETQ CMD (GET SYNTREE (QUOTE COMMAND))) (SETQ OBJ1 (CAR INST1)) (SETQ OBJ2 (CAR 
INST2)) (SETQ PREP (GET SYNTREE (QUOTE PREPOSITION))) (SETQ RETFLG NIL) (COND ((EQ CMD (QUOTE GIVE)) (SETQ GIFT OBJ1) (SETQ RECIP OB~
J2) (COND ((EQ RECIP (QUOTE DROID1)) (COND ((EQ GIFT (QUOTE CAN1)) (PRINTC "My...thankyou for this fine can of oil.  I could sure
use some on my tracks..they're getting a bit squeaky in
my old age.  You're not so bad after all..you may go!" CMDWIN) (SETQ RETFLG (QUOTE NO)) (SETQ WINGAME T)) (T (PRINTC "The security d~
roid doesnt want " CMDWIN) (PRINC (GET GIFT (QUOTE OBDESCR)) CMDWIN) (SETQ RETFLG (QUOTE NO))))))) ((AND (EQ CMD (QUOTE GO)) (EQ OBJ~
1 (QUOTE S))) (PRINTC "The security droid blocks you way." CMDWIN) (SETQ RETFLG (QUOTE NO)))) (RETURN RETFLG))
     'PREPROC)

(PUT 'PHASER1
     '"
                    This Weapon manufactured of the
                      finest available polymers
                                by:

                         ACME PHASER WORKS
                   110110 Avenue of the Craters
                     Centille, Orion 489320-1

                   Ser. #: 49366198831415-2b93

             Remember: Robots dont kill robots - 
                           Guns Kill robots!
"
     'INSCRIPT)

(PUT 'PHASER1
     '"There is a small inscription on the
handle and a meter there too."
     'EXTXT)

(FLAG 'CLOSET1 'GLUED)

(PUT 'TOOLBOX1
     'OBSERM
     'HOLDER)

(PUT 'CAN1
     'TOOLBOX1
     'HOLDER)

(PUT 'CROWBAR1
     'TOOLBOX1
     'HOLDER)

(PUT 'BATTERY1
     'TOOLBOX1
     'HOLDER)

(PUT 'CLOSET1
     'WEAPNRM
     'HOLDER)

(PUT 'PHASER1
     'CLOSET1
     'HOLDER)

(PUT 'CLOSET1
     '(CROWBAR1)
     'OPENERS)

(FLAG 'CLOSET1 'LOCKED)

(FLAG 'TOOLBOX1 'HOLDS)

(FLAG 'CLOSET1 'HOLDS)

(FLAG 'PHASER1 'HOLDS)

(FLAG 'WEAPNRM 'ROOM)

(FLAG 'OBSERM 'ROOM)

(FLAG 'LOBBY 'ROOM)

(FLAG 'ELEVATOR 'ROOM)

(FLAG 'WE 'OPEN)

