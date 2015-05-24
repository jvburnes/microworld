~
~  PP
~
(PRINT 'PP)

(PACKAGE PP
    (DEF PPF PP *PP-EXPR *PP-EXPRI *PP-PROG *PP-PROGI *PP-ARGLIST 
    *PP-COND *PP-CONDI *PP-QUOTE *PP-LIST *PP-ITEM *PP-BODY *PP-TAB 
    *PP-SPACE *PP-ATOM *PP-DELIM *PP-CMMT *PP-CHK))

(DEF 'PPF
    '[NLAMBDA (N)
         (PP (GETD N))])

(DEF 'PP
    '[LAMBDA (E F)
         [PROG (*PP:FILE *PP:VTAB)
             (SETQ *PP:FILE F)
             (SETQ *PP:VTAB 4)
             (UNMACEXPAND E)
             (*PP-EXPR E)
             (*PP-TAB 0)
             (RETURN 'OK)]])

(DEF '*PP-EXPR
    '[LAMBDA (L)
         (COND
             [(ATOM L)
               (*PP-ATOM L)]
             [(AND (CONSP (CDR L))
                  (MEMB (CAR L)
                      '[LAMBDA MLAMBDA
                           NLAMBDA
                           PROG
                           DEFUN]))
               (*PP-PROG L)]
             [(EQ (CAR L)
                  'COND)
               (*PP-COND L)]
             [(AND (CONSP (CDR L))
                  (NULL (CDDR L))
                  (EQ (CAR L)
                      'QUOTE))
               (*PP-QUOTE L)]
             [(EQ (CAR L)
                  '\;)
               (*PP-CMMT (CADR L))]
             [T
               (*PP-LIST L)])])

(DEF '*PP-EXPRI
    '[LAMBDA (L P S *PP:VTAB)
         (SETQ *PP:VTAB P)
         (COND
             [(LT 1 S)
               (*PP-TAB P)])
         (*PP-EXPR L)])

(DEF '*PP-PROG
    '[LAMBDA (L *PP:VTAB PE)
         (SETQ *PP:VTAB
             (+ (CHRPOS *PP:FILE) 4))
         (*PP-DELIM "[")
         (*PP-ATOM (CAR L))
         (*PP-SPACE 1)
         (*PP-ARGLIST (CADR L))
         (*PP-TAB *PP:VTAB)
         (COND
             [(EQ (CAR L)
                  'PROG)
               (SETQ PE
                   '*PP-PROGI)]
             [T
               (SETQ PE
                   '*PP-EXPRI)])
         (*PP-BODY (CDDR L) "]" PE *PP:VTAB)])

(DEF '*PP-PROGI
    '[LAMBDA (L P S *PP:VTAB)
         (SETQ *PP:VTAB P)
         (COND
             [(EQ 1 S)
               ]
             [(ATOM L)
               (*PP-TAB (- P 3))]
             [T
               (*PP-TAB P)])
         (*PP-EXPR L)])

(DEF '*PP-ARGLIST
    '[LAMBDA (L *PP:VTAB)
         (SETQ *PP:VTAB
             (CHRPOS *PP:FILE))
         (COND
             [(NULL L)
               (*PP-DELIM "(")
               (*PP-DELIM ")")]
             [(ATOM L)
               (*PP-ATOM L)]
             [T
               (*PP-LIST L)])])

(DEF '*PP-COND
    '[LAMBDA (L *PP:VTAB)
         (SETQ *PP:VTAB
             (CHRPOS *PP:FILE))
         (*PP-DELIM "(")
         (*PP-ATOM 'COND)
         (*PP-BODY (CDR L) ")"
             '*PP-CONDI
             (+ *PP:VTAB 4))])

(DEF '*PP-CONDI
    '[LAMBDA (L P S *PP:VTAB)
         (SETQ *PP:VTAB
             (+ P 2))
         (*PP-TAB P)
         (COND
             [(ATOM L)
               (*PP-ATOM L)]
             [T
               (*PP-DELIM "[")
               (*PP-EXPR (CAR L))
               (*PP-TAB *PP:VTAB)
               (*PP-BODY (CDR L) "]"
                   '*PP-EXPRI *PP:VTAB)])])

(DEF '*PP-QUOTE
    '[LAMBDA (L *PP:VTAB)
         (SETQ *PP:VTAB
             (CHRPOS *PP:FILE))
         (*PP-DELIM "'")
         (*PP-EXPR (CADR L))])

(DEF '*PP-LIST
    '[LAMBDA (L *PP:VTAB)
         (SETQ *PP:VTAB
             (CHRPOS *PP:FILE))
         (*PP-DELIM "(")
         (*PP-BODY L ")"
             '*PP-ITEM
             (+ 4 *PP:VTAB))])

(DEF '*PP-ITEM
    '[LAMBDA (L P S)
         (COND
             [(CONSP L)
               (COND
                   [(LT 2 S)
                     (*PP-TAB P)]
                   [(LT 1 S)
                     (*PP-SPACE 1)])
               (*PP-EXPR L)]
             [T
               (COND
                   [(LT 1 S)
                     (*PP-SPACE 1)])
               (*PP-ATOM L)])])

(DEF '*PP-BODY
    '[LAMBDA (L RP EP P)
         [PROG (SUB)
             (SETQ SUB 1)
          LOOP
             (COND
                 [(ATOM L)
                   (COND
                       [L
                         (*PP-SPACE 1)
                         (*PP-DELIM ".")
                         (*PP-SPACE 1)
                         (*PP-ATOM L)])
                   (*PP-DELIM RP)
                   (RETURN)])
             (APPLY EP
                 (LIST (CAR L) P SUB))
             (SETQ L
                 (CDR L))
             (SETQ SUB
                 (ADD1 SUB))
             (GO LOOP)]])

(DEF '*PP-TAB
    '[LAMBDA (P)
         (TERPRI NIL *PP:FILE)
         (SPACES P *PP:FILE)])

(DEF '*PP-SPACE
    '[LAMBDA (S)
         (COND
             [(LT (+ S
                      (CHRPOS *PP:FILE))
                  (LINELENGTH NIL *PP:FILE))
               (SPACES S *PP:FILE)]
             [T
               (*PP-TAB *PP:VTAB)])])

(DEF '*PP-ATOM
    '[LAMBDA (A)
         (COND
             [(MEMB A
                  '(+ - -->))
               (*PP-CHK 1)
               (PRINC A *PP:FILE)]
             [T
               (*PP-CHK (FLATSIZE A))
               (PRIN A *PP:FILE)])])

(DEF '*PP-DELIM
    '[LAMBDA (D)
         (*PP-CHK 1)
         (PRINC D *PP:FILE)])

(DEF '*PP-CMMT
    '[LAMBDA (C)
         (*PP-CHK (+ 2
                      (STRLEN C)))
         (PRINC "{" *PP:FILE)
         (PRINC C *PP:FILE)
         (PRINC "}" *PP:FILE)])

(DEF '*PP-CHK
    '[LAMBDA (L)
         (COND
             [(LE (LINELENGTH NIL *PP:FILE)
                  (+ L
                      (CHRPOS *PP:FILE)))
               (*PP-TAB *PP:VTAB)])])

