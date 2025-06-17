      * ZUTZCPD.CPY                                                     00010001
           DISPLAY SPACE                                                00010101
           MOVE UT-TEST-CASE-COUNT TO UT-TEST-CASE-NUMBER               00010201
           DISPLAY UT-TEST-CASE-NUMBER ' TEST CASES WERE EXECUTED'      00010301
           MOVE UT-NUMBER-PASSED TO UT-TEST-CASE-NUMBER                 00010401
           DISPLAY UT-TEST-CASE-NUMBER ' PASSED'                        00010501
           MOVE UT-NUMBER-FAILED TO UT-TEST-CASE-NUMBER                 00010601
           DISPLAY UT-TEST-CASE-NUMBER ' FAILED'                        00010701
           DISPLAY "================================================="  00010801
           MOVE UT-RETCODE TO RETURN-CODE                               00010901
           GOBACK.                                                      00011001
       UT-ASSERT-EQUAL.                                                 00011101
      ***************************************************************** 00011201
      * COMPARE EXPECTED AND ACTUAL VALUES FOR EQUALITY.                00011301
      ***************************************************************** 00011401
           MOVE UT-TEST-CASE-COUNT TO UT-TEST-CASE-NUMBER               00011501
           PERFORM UT-COMPARE                                           00011601
           IF UT-COMPARE-PASSED                                         00011701
               PERFORM UT-DISPLAY-PASSED                                00011801
           ELSE                                                         00011901
               PERFORM UT-DISPLAY-FAILED                                00012001
           END-IF                                                       00012101
           .                                                            00012201
       UT-COMPARE.                                                      00012301
           SET UT-COMPARE-FAILED TO TRUE                                00012401
           IF UT-COMPARE-NUMERIC                                        00012501
               IF UT-ACTUAL-NUMERIC IS EQUAL TO UT-EXPECTED-NUMERIC     00012601
                   SET UT-COMPARE-PASSED TO TRUE                        00012701
               END-IF                                                   00012801
           ELSE                                                         00012901
               IF UT-ACTUAL IS EQUAL TO UT-EXPECTED                     00013001
                   SET UT-COMPARE-PASSED TO TRUE                        00013101
               END-IF                                                   00013201
           END-IF                                                       00013301
           PERFORM UT-REVERSE-RESULT                                    00013401
           .                                                            00013501
       UT-REVERSE-RESULT.                                               00013601
           IF UT-REVERSE-COMPARE                                        00013701
               IF UT-COMPARE-PASSED                                     00013801
                   SET UT-COMPARE-FAILED TO TRUE                        00013901
               ELSE                                                     00014001
                   SET UT-COMPARE-PASSED TO TRUE                        00014101
               END-IF                                                   00014201
           END-IF                                                       00014301
           .                                                            00014401
       UT-DISPLAY-PASSED.                                               00014501
           ADD 1 TO UT-NUMBER-PASSED                                    00014601
           DISPLAY UT-PASSED                                            00014701
                   UT-TEST-CASE-NUMBER '. '                             00014801
                   UT-TEST-CASE-NAME                                    00014901
           .                                                            00015001
       UT-DISPLAY-FAILED.                                               00015101
           ADD 1 TO UT-NUMBER-FAILED                                    00015201
           DISPLAY UT-FAILED                                            00015301
                   UT-TEST-CASE-NUMBER '. '                             00015401
                   UT-TEST-CASE-NAME                                    00015501
           IF UT-COMPARE-NUMERIC                                        00015601
               DISPLAY '    EXPECTED ' UT-EXPECTED-NUMERIC              00015701
                       ', WAS ' UT-ACTUAL-NUMERIC                       00015801
           ELSE                                                         00015901
               DISPLAY '    EXPECTED <' UT-EXPECTED                     00016001
                       '>, WAS <' UT-ACTUAL '>'                         00016101
           END-IF                                                       00016201
           MOVE 4 TO UT-RETCODE                                         00016301
           .                                                            00016401
       UT-ASSERT-ACCESSES.                                              00016501
      ***************************************************************** 00016601
      * COMPARE THE NUMBER OF ACCESSES TO A MOCK WITH THE EXPECTED      00016701
      * NUMBER OF ACCESSES.                                             00016801
      ***************************************************************** 00016901
           MOVE UT-TEST-CASE-COUNT TO UT-TEST-CASE-NUMBER               00017001
           MOVE UT-ACTUAL-ACCESSES TO UT-ACTUAL-ACCESSES-FMT            00017101
           MOVE UT-EXPECTED-ACCESSES TO UT-EXPECTED-ACCESSES-FMT        00017201
           IF UT-EXPECTED-ACCESSES IS EQUAL TO 1                        00017301
              MOVE SPACES TO UT-LABEL-EXPECTED-ACCESS-PL                00017401
           ELSE                                                         00017501
              MOVE UT-CONST-ES TO UT-LABEL-EXPECTED-ACCESS-PL           00017601
           END-IF                                                       00017701
           SET UT-VERIFY-FAILED TO TRUE                                 00017801
           EVALUATE TRUE                                                00017901
               WHEN UT-VERIFY-AT-LEAST                                  00018001
                    IF UT-ACTUAL-ACCESSES IS GREATER THAN OR EQUAL TO   00018101
                            UT-EXPECTED-ACCESSES                        00018201
                        SET UT-VERIFY-PASSED TO TRUE                    00018301
                    END-IF                                              00018401
               WHEN UT-VERIFY-NO-MORE-THAN                              00018501
                    IF UT-ACTUAL-ACCESSES IS LESS THAN OR EQUAL TO      00018601
                            UT-EXPECTED-ACCESSES                        00018701
                        SET UT-VERIFY-PASSED TO TRUE                    00018801
                    END-IF                                              00018901
               WHEN OTHER                                               00019001
                    IF UT-ACTUAL-ACCESSES IS EQUAL TO                   00019101
                            UT-EXPECTED-ACCESSES                        00019201
                        SET UT-VERIFY-PASSED TO TRUE                    00019301
                    END-IF                                              00019401
           END-EVALUATE                                                 00019501
           IF UT-VERIFY-PASSED                                          00019601
               ADD 1 TO UT-NUMBER-PASSED                                00019701
               DISPLAY UT-PASSED                                        00019801
                       UT-TEST-CASE-NUMBER '. '                         00019901
                      'VERIFY ' UT-EXPECTED-ACCESSES-FMT SPACE          00020001
                      UT-LABEL-EXPECTED-ACCESS                          00020101
           ELSE                                                         00020201
               ADD 1 TO UT-NUMBER-FAILED                                00020301
               MOVE SPACES TO UT-DISPLAY-MESSAGE                        00020401
               IF UT-MOCK-FILE(UT-MOCK-IX)                              00020501
                   STRING                                               00020601
                       UT-FAILED                      DELIMITED BY SIZE 00020701
                       UT-TEST-CASE-NUMBER            DELIMITED BY SIZE 00020801
                       '. VERIFY ACCESSES TO '        DELIMITED BY SIZE 00020901
                       UT-MOCK-OPERATION(UT-MOCK-IX)  DELIMITED BY SPACE00021001
                       ' ON '                         DELIMITED BY SIZE 00021101
                       UT-MOCK-FILENAME(UT-MOCK-IX)   DELIMITED BY SPACE00021201
                       ' | EXPECTED '                 DELIMITED BY SIZE 00021301
                       UT-EXPECTED-ACCESSES-FMT       DELIMITED BY SIZE 00021401
                       SPACE                          DELIMITED BY SIZE 00021501
                       UT-LABEL-EXPECTED-ACCESS       DELIMITED BY SPACE00021601
                       ', WAS '                       DELIMITED BY SIZE 00021701
                       UT-ACTUAL-ACCESSES-FMT         DELIMITED BY SIZE 00021801
                       INTO UT-DISPLAY-MESSAGE                          00021901
                   END-STRING                                           00022001
               ELSE                                                     00022101
                   STRING                                               00022201
                       UT-FAILED                      DELIMITED BY SIZE 00022301
                       UT-TEST-CASE-NUMBER            DELIMITED BY SIZE 00022401
                       '. VERIFY ACCESSES TO '        DELIMITED BY SIZE 00022501
                       UT-MOCK-CICS-KEYWORDS-KEY(UT-MOCK-IX)            00022601
                                                      DELIMITED BY SIZE 00022701
                       INTO UT-DISPLAY-MESSAGE                          00022801
                   END-STRING                                           00022901
                   DISPLAY UT-DISPLAY-MESSAGE                           00023001
                   MOVE SPACES TO UT-DISPLAY-MESSAGE                    00023101
                   STRING                                               00023201
                       '   EXPECTED '                 DELIMITED BY SIZE 00023301
                       UT-EXPECTED-ACCESSES-FMT       DELIMITED BY SIZE 00023401
                       SPACE                          DELIMITED BY SIZE 00023501
                       UT-LABEL-EXPECTED-ACCESS       DELIMITED BY SPACE00023601
                       ', WAS '                       DELIMITED BY SIZE 00023701
                       UT-ACTUAL-ACCESSES-FMT         DELIMITED BY SIZE 00023801
                       INTO UT-DISPLAY-MESSAGE                          00023901
                   END-STRING                                           00024001
               END-IF                                                   00024101
               DISPLAY UT-DISPLAY-MESSAGE                               00024201
               MOVE 4 TO UT-RETCODE                                     00024301
           END-IF                                                       00024401
           .                                                            00024501
       UT-SET-MOCK.                                                     00024601
      ***************************************************************** 00024701
      * CREATE OR UPDATE A MOCK SPECIFICATION.                          00024801
      ***************************************************************** 00024901
           EVALUATE TRUE                                                00025001
               WHEN UT-FIND-FILE-MOCK                                   00025101
                    PERFORM UT-SET-FILE-MOCK                            00025201
               WHEN UT-FIND-CALL-MOCK                                   00025301
                    PERFORM UT-SET-CALL-MOCK                            00025401
               WHEN UT-FIND-CICS-MOCK                                   00025501
                    PERFORM UT-SET-CICS-MOCK                            00025601
               WHEN UT-FIND-PARA-MOCK                                   00025701
                    PERFORM UT-SET-PARA-MOCK                            00025801
           END-EVALUATE                                                 00025901
           .                                                            00026001
       UT-SET-FILE-MOCK.                                                00026101
           PERFORM UT-LOOKUP-MOCK                                       00026201
           IF UT-MOCK-FOUND                                             00026301
               CONTINUE                                                 00026401
           ELSE                                                         00026501
               ADD 1 TO UT-MOCK-COUNT                                   00026601
               SET UT-MOCK-IX TO UT-MOCK-COUNT                          00026701
               SET UT-MOCK-FILE(UT-MOCK-IX) TO TRUE                     00026801
               MOVE UT-MOCK-FIND-FILENAME                               00026901
                    TO UT-MOCK-FILENAME(UT-MOCK-IX)                     00027001
               MOVE UT-MOCK-FIND-OPERATION                              00027101
                    TO UT-MOCK-OPERATION(UT-MOCK-IX)                    00027201
           END-IF                                                       00027301
           MOVE UT-MOCK-SET-RECORD                                      00027401
                TO UT-MOCK-RECORD(UT-MOCK-IX)                           00027501
           MOVE UT-MOCK-SET-FILE-STATUS                                 00027601
                TO UT-MOCK-FILE-STATUS(UT-MOCK-IX)                      00027701
           .                                                            00027801
       UT-SET-CALL-MOCK.                                                00027901
           PERFORM UT-LOOKUP-MOCK                                       00028001
           IF UT-MOCK-FOUND                                             00028101
               CONTINUE                                                 00028201
           ELSE                                                         00028301
               ADD 1 TO UT-MOCK-COUNT                                   00028401
               SET UT-MOCK-IX TO UT-MOCK-COUNT                          00028501
               MOVE UT-MOCK-FIND-CALL-TOKENS                            00028601
                   TO UT-MOCK-CALL-TOKENS-KEY(UT-MOCK-IX)               00028701
           END-IF                                                       00028801
           .                                                            00028901
       UT-SET-CICS-MOCK.                                                00029001
           PERFORM UT-LOOKUP-MOCK                                       00029101
           IF UT-MOCK-FOUND                                             00029201
               CONTINUE                                                 00029301
           ELSE                                                         00029401
               ADD 1 TO UT-MOCK-COUNT                                   00029501
               SET UT-MOCK-IX TO UT-MOCK-COUNT                          00029601
               MOVE UT-MOCK-FIND-CICS-KEYWORDS                          00029701
                   TO UT-MOCK-CICS-KEYWORDS-KEY(UT-MOCK-IX)             00029801
           END-IF                                                       00029901
           .                                                            00030001
       UT-SET-PARA-MOCK.                                                00030101
           PERFORM UT-LOOKUP-MOCK                                       00030201
           IF UT-MOCK-FOUND                                             00030301
               CONTINUE                                                 00030401
           ELSE                                                         00030501
               ADD 1 TO UT-MOCK-COUNT                                   00030601
               SET UT-MOCK-IX TO UT-MOCK-COUNT                          00030701
               MOVE UT-MOCK-FIND-PARA-NAME                              00030801
                   TO UT-MOCK-PARA-NAME(UT-MOCK-IX)                     00030901
           END-IF                                                       00031001
           .                                                            00031101
       UT-LOOKUP-MOCK.                                                  00031201
      ***************************************************************** 00031301
      * LOOK UP A MOCK SPECIFICATION.                                   00031401
      ***************************************************************** 00031501
           SET UT-MOCK-NOT-FOUND TO TRUE                                00031601
           PERFORM VARYING UT-MOCK-IX FROM 1 BY 1                       00031701
               UNTIL UT-MOCK-IX IS GREATER THAN UT-MOCK-MAX             00031801
                  OR UT-MOCK-FOUND                                      00031901
               EVALUATE TRUE                                            00032001
                   WHEN UT-FIND-FILE-MOCK                               00032101
                       IF UT-MOCK-FIND-FILENAME IS EQUAL TO             00032201
                              UT-MOCK-FILENAME(UT-MOCK-IX)              00032301
                       AND UT-MOCK-FIND-OPERATION IS EQUAL TO           00032401
                              UT-MOCK-OPERATION(UT-MOCK-IX)             00032501
                           SET UT-MOCK-FOUND TO TRUE                    00032601
                           CONTINUE                                     00032701
                       END-IF                                           00032801
                   WHEN UT-FIND-CALL-MOCK                               00032901
                       IF UT-MOCK-FIND-CALL-TOKENS IS EQUAL TO          00033001
                              UT-MOCK-CALL-TOKENS-KEY(UT-MOCK-IX)       00033101
                           SET UT-MOCK-FOUND TO TRUE                    00033201
                           CONTINUE                                     00033301
                       END-IF                                           00033401
                   WHEN UT-FIND-CICS-MOCK                               00033501
                       IF UT-MOCK-FIND-CICS-KEYWORDS IS EQUAL TO        00033601
                              UT-MOCK-CICS-KEYWORDS-KEY(UT-MOCK-IX)     00033701
                           SET UT-MOCK-FOUND TO TRUE                    00033801
                           CONTINUE                                     00033901
                       END-IF                                           00034001
                   WHEN UT-FIND-PARA-MOCK                               00034101
                       IF UT-MOCK-FIND-PARA-NAME IS EQUAL TO            00034201
                              UT-MOCK-PARA-NAME(UT-MOCK-IX)             00034301
                           SET UT-MOCK-FOUND TO TRUE                    00034401
                           CONTINUE                                     00034501
                       END-IF                                           00034601
               END-EVALUATE                                             00034701
           END-PERFORM                                                  00034801
           SET UT-MOCK-IX DOWN BY 1                                     00034901
           .                                                            00035001
       UT-LOOKUP-FILE.                                                  00035101
      ***************************************************************** 00035201
      * LOOK UP A FILE SPECIFICATION.                                   00035301
      ***************************************************************** 00035401
           PERFORM VARYING UT-FILE-IX FROM 1 BY 1                       00035501
               UNTIL UT-FILE-IX GREATER UT-FILE-MAX                     00035601
               OR UT-INTERNAL-FILENAME(UT-FILE-IX)                      00035701
                EQUAL UT-MOCK-FIND-FILENAME                             00035801
           END-PERFORM                                                  00035901
           SET UT-FILE-IX DOWN BY 1                                     00036001
           .                                                            00036101
                                                                        00036200
                                                                        00036300
                                                                        00040000
                                                                        00050000