~
~  NATCOM
~
(PRINT 'NATCOM)

(PACKAGE NATCOM
    (DEF PARSE-WORD PARSE-NOUN-GROUP PARSE-COMMAND))

(DEF 'PARSE-WORD
    '[LAMBDA (PARENT-NODE FEATURES)
         [PROG (THIS-NODE HOLD)
             (SETQ HOLD REMAINING-WORDS)
             (SETQ CURRENT-WORD
                 (CAR REMAINING-WORDS))
             (SETQ THIS-NODE
                 (GENNAME 'PARSE-WORD))
          S1
             (COND
                 [T
                   (SETQ THIS-NODE CURRENT-WORD)
                   (SETQ REMAINING-WORDS
                       (CDR REMAINING-WORDS))
                   (COND
                       [REMAINING-WORDS
                         (SETQ CURRENT-WORD
                             (CAR REMAINING-WORDS))]
                       [T
                         (SETQ CURRENT-WORD NIL)])]
                 [T
                   (GO LOSE)])
          WIN
             (COND
                 [(NOT (TESTF THIS-NODE FEATURES))
                   (GO LOSE)])
             (ATTACH THIS-NODE PARENT-NODE)
             (SETQ LAST-PARSED THIS-NODE)
             (RETURN THIS-NODE)
          LOSE
             (SETQ REMAINING-WORDS HOLD)
             (SETQ CURRENT-WORD
                 (CAR REMAINING-WORDS))
             (RETURN NIL)]])

(DEF 'PARSE-NOUN-GROUP
    '[LAMBDA (PARENT-NODE FEATURES)
         [PROG (THIS-NODE HOLD)
             (SETQ HOLD REMAINING-WORDS)
             (SETQ CURRENT-WORD
                 (CAR REMAINING-WORDS))
             (SETQ THIS-NODE
                 (GENNAME 'PARSE-NOUN-GROUP))
          S1
             (COND
                 [(PARSE-WORD THIS-NODE
                      'DETERMINER)
                   (SETR 'NUMBER
                       (SELCT '(SINGULAR PLURAL)
                           (GETF LAST-PARSED)))
                   (SETR 'DETERMINER
                       (SELCT '(DEFINITE INDEFINITE)
                           (GETF LAST-PARSED)))]
                 [T
                   ]
                 [T
                   (GO LOSE)])
          S2A
             (COND
                 [(PARSE-WORD THIS-NODE
                      'NUMBER)
                   (COND
                       [(EQUAL 'SINGULAR
                            (GETR 'NUMBER))
                         (PRINT 'TILT-DETERMINER-NUMBER)])
                   (SETR 'NUMBER
                       (GET LAST-PARSED
                           'NUMBER))]
                 [T
                   ]
                 [T
                   (GO LOSE)])
          WIN
             (COND
                 [(NOT (TESTF THIS-NODE FEATURES))
                   (GO LOSE)])
             (ATTACH THIS-NODE PARENT-NODE)
             (SETQ LAST-PARSED THIS-NODE)
             (RETURN THIS-NODE)
          LOSE
             (SETQ REMAINING-WORDS HOLD)
             (SETQ CURRENT-WORD
                 (CAR REMAINING-WORDS))
             (RETURN NIL)]])

(DEF 'PARSE-COMMAND
    '[LAMBDA (PARENT-NODE FEATURES)
         [PROG (THIS-NODE HOLD)
             (SETQ HOLD REMAINING-WORDS)
             (SETQ CURRENT-WORD
                 (CAR REMAINING-WORDS))
             (SETQ THIS-NODE
                 (GENNAME 'PARSE-COMMAND))
          S1
             (COND
                 [(AND (EQUAL CURRENT-WORD
                           'COUNT)
                      (PARSE-WORD THIS-NODE
                          'NIL))
                   (SETR 'COMMAND
                       'COUNT)]
                 [(AND (EQUAL CURRENT-WORD
                           'IDENTIFY)
                      (PARSE-WORD THIS-NODE
                          'NIL))
                   (SETR 'COMMAND
                       'ENUMERATE)]
                 [T
                   (GO LOSE)])
          S2
             (COND
                 [(AND (PARSE-NOUN-GROUP THIS-NODE NIL)
                      (NULL REMAINING-WORDS))
                   (SETR 'NOUN-GROUP LAST-PARSED)]
                 [T
                   (GO LOSE)])
          WIN
             (COND
                 [(NOT (TESTF THIS-NODE FEATURES))
                   (GO LOSE)])
             (ATTACH THIS-NODE PARENT-NODE)
             (SETQ LAST-PARSED THIS-NODE)
             (RETURN THIS-NODE)
          LOSE
             (SETQ REMAINING-WORDS HOLD)
             (SETQ CURRENT-WORD
                 (CAR REMAINING-WORDS))
             (RETURN NIL)]])

