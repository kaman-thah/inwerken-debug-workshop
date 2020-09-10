*&---------------------------------------------------------------------*
*& Report            ZINW_DEBUGGER_DEMO
*&---------------------------------------------------------------------*
*                                                                      *
*     _____                        _                         _____     *
*    |_   _|                      | |                  /\   / ____|    *
*      | |  _ ____      _____ _ __| | _____ _ __      /  \ | |  __     *
*      | | | '_ \ \ /\ / / _ \ '__| |/ / _ \ '_ \    / /\ \| | |_ |    *
*     _| |_| | | \ V  V /  __/ |  |   <  __/ | | |  / ____ \ |__| |    *
*    |_____|_| |_|\_/\_/ \___|_|  |_|\_\___|_| |_| /_/    \_\_____|    *
*                                                                      *
*                                                  einfach Inwerken.   *
*                                                                      *
*&---------------------------------------------------------------------*

REPORT  zinw_debugger_demo.

TYPE-POOLS
  : abap
  .
PARAMETERS
  : entry   TYPE xfeld RADIOBUTTON GROUP mode
  , basic   TYPE xfeld RADIOBUTTON GROUP mode
  , vars    TYPE xfeld RADIOBUTTON GROUP mode
  , tabs    TYPE xfeld RADIOBUTTON GROUP mode
  , objs    TYPE xfeld RADIOBUTTON GROUP mode
  , wps     TYPE xfeld RADIOBUTTON GROUP mode
  , diff    TYPE xfeld RADIOBUTTON GROUP mode
  , layer   TYPE xfeld RADIOBUTTON GROUP mode
  , script  TYPE xfeld RADIOBUTTON GROUP mode
  .
*----------------------------------------------------------------------*
*       CLASS lcl_test DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_test DEFINITION.

  PUBLIC SECTION.

    DATA att_public TYPE string  VALUE 'PUBLIC'.

    EVENTS evt_public
      EXPORTING VALUE(e_subrc)  TYPE sysubrc.

  PROTECTED SECTION.

    DATA att_protected  TYPE string  VALUE 'PROTECTED'.

    EVENTS evt_protected.

  PRIVATE SECTION.

    DATA att_private  TYPE string VALUE 'PRIVATE'.

    EVENTS evt_private.

ENDCLASS.                    "lcl_test DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_test IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_test IMPLEMENTATION.
ENDCLASS.                    "lcl_test IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_test2 DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_test2 DEFINITION INHERITING FROM lcl_test.

  PUBLIC SECTION.

    DATA
      : att_newly_defined_in_lcl_test2  TYPE i VALUE 99
      .

    METHODS
      : constructor
      .

    EVENTS evt_public2.

ENDCLASS.                    "lcl_test2 DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_test2 IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_test2 IMPLEMENTATION.

  METHOD constructor.
    super->constructor( ).

    att_protected = 'PROTECTED_INHERITED'.
    att_public    = 'PUBLIC_INHERITED'.
  ENDMETHOD.                    "constructor

ENDCLASS.                    "lcl_test2 IMPLEMENTATION

INTERFACE lif_printable.
  DATA:
    printer TYPE string.

  METHODS:
    print.
ENDINTERFACE.

INTERFACE lif_sendable.
  DATA:
    receiver TYPE string,
    subject  TYPE string,
    body     TYPE string.

  METHODS:
    send.
ENDINTERFACE.

CLASS lcl_document DEFINITION.
  PUBLIC SECTION.
    INTERFACES:
      lif_printable,
      lif_sendable.

  PROTECTED SECTION.
    DATA:
      content TYPE xstring.
ENDCLASS.

CLASS lcl_document IMPLEMENTATION.

  METHOD lif_printable~print.

  ENDMETHOD.

  METHOD lif_sendable~send.

  ENDMETHOD.

ENDCLASS.

DATA
  : gd_string   TYPE        string VALUE 'Global String variable'
  , gd_int      TYPE        i      VALUE 123456789
  , go_test     TYPE REF TO lcl_test
  .

START-OF-SELECTION.

  CASE abap_true.
    WHEN entry.
      PERFORM entry.
    WHEN basic.
      PERFORM basic.
    WHEN vars.
      PERFORM vars.
    WHEN tabs.
      PERFORM tabs.
    WHEN objs.
      PERFORM objs.
    WHEN wps.
      PERFORM wps.
    WHEN diff.
      PERFORM diff.
    WHEN layer.
      PERFORM layer.
    WHEN script.
      PERFORM script.
    WHEN OTHERS.
  ENDCASE.

*&---------------------------------------------------------------------*
*&      Form  ENTRY
*&---------------------------------------------------------------------*
FORM entry .

  WRITE: / 'ENTRY'.
  MESSAGE 'Hallo Welt!' TYPE 'I'.

  BREAK-POINT ID zinw_debugger_demo.

ENDFORM.                    " ENTRY

*&---------------------------------------------------------------------*
*&      Form  BASIC
*&---------------------------------------------------------------------*
FORM basic .

  BREAK-POINT.

  WRITE: / 'BASIC'.

  PERFORM basic1.

  PERFORM basic2.

  PERFORM basic3.

  PERFORM deep.

  BREAK-POINT.

ENDFORM.                    " BASIC
*&---------------------------------------------------------------------*
*&      Form  basic1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM basic1 .
  WRITE: / 'BASIC1'.
ENDFORM.                    "basic1
*&---------------------------------------------------------------------*
*&      Form  basic2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM basic2.
  WRITE: / 'BASIC2'.
ENDFORM.                    "basic2
*&---------------------------------------------------------------------*
*&      Form  basic3
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM basic3 .
  WRITE: / 'BASIC3'.
ENDFORM.                    "basic3

*&---------------------------------------------------------------------*
*&      Form  deep
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM deep.
  WRITE: / 'DEEP'.
  PERFORM deep1.
ENDFORM.                    "deep

*&---------------------------------------------------------------------*
*&      Form  deep1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM deep1.
  WRITE: /7 'DEEP1'.
  PERFORM deep2.
ENDFORM.                    "deep1

*&---------------------------------------------------------------------*
*&      Form  deep2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM deep2.
  WRITE: /14 'DEEP2'.
  PERFORM deep3.
ENDFORM.                    "deep2

*&---------------------------------------------------------------------*
*&      Form  deep3
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM deep3.
  WRITE: /21 'DEEP3'.
  PERFORM deep4.
ENDFORM.                    "deep3

*&---------------------------------------------------------------------*
*&      Form  deep4
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM deep4.
  WRITE: /28 'DEEP4'.
  PERFORM deep5.
ENDFORM.                    "deep4

*&---------------------------------------------------------------------*
*&      Form  deep5
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM deep5.
  WRITE: /35 'DEEP5'.
  WRITE: '- Down below...'.
ENDFORM.                    "deep5

*&---------------------------------------------------------------------*
*&      Form  vars
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM vars.

  DATA
    : ld_str    TYPE          string
    , ld_int    TYPE          i
    , ld_int2   TYPE          i
    , ls_usr02  TYPE          usr02
    , lt_usr02  TYPE TABLE OF usr02
    , lo_test   TYPE REF   TO lcl_test
    .
  BREAK-POINT.

  ld_str = 'Hallo Welt!'.

  ld_int = 42.

  ld_int2 = ld_int ** 2.

  DO 10 TIMES.
    ld_int = sy-index * 2.
  ENDDO.

  SELECT SINGLE *
    FROM  usr02
    INTO  ls_usr02
    WHERE bname = 'MHAUBITZ'.

  SELECT *
    FROM  usr02
    UP TO 50 ROWS
    INTO  TABLE lt_usr02.

  CREATE OBJECT lo_test.

  BREAK-POINT.

ENDFORM.                    "vars

*&---------------------------------------------------------------------*
*&      Form  TABS
*&---------------------------------------------------------------------*
FORM tabs .

  DATA
    : lt_usr02  TYPE TABLE OF usr02
    , ls_usr02  TYPE          usr02

    , lt_usr02_srt TYPE SORTED TABLE OF usr02
                   WITH UNIQUE KEY bname
                   WITH NON-UNIQUE SORTED KEY erdat COMPONENTS erdat
    , lt_usr02_hash TYPE HASHED TABLE OF usr02
                    WITH UNIQUE KEY bname
    , lt_usr02_skey TYPE STANDARD TABLE OF usr02 WITH DEFAULT KEY
                    WITH UNIQUE SORTED KEY bname COMPONENTS bname
                    WITH UNIQUE HASHED KEY bnh    COMPONENTS bname
                    WITH NON-UNIQUE SORTED KEY erdat COMPONENTS erdat
    .
  SELECT *
    FROM  usr02
    UP TO 50 ROWS
    INTO  TABLE lt_usr02.
  DATA(lt_usr02_2) = lt_usr02.
  INSERT LINES OF lt_usr02 INTO TABLE lt_usr02_srt.
  INSERT LINES OF lt_usr02 INTO TABLE lt_usr02_hash.
  INSERT LINES OF lt_usr02 INTO TABLE lt_usr02_skey.

  BREAK-POINT.

  TRY.
      ls_usr02 = lt_usr02_skey[ KEY erdat COMPONENTS erdat = '20170101' ].
    CATCH cx_sy_itab_line_not_found ##no_handler.
  ENDTRY.

  BREAK-POINT.

  LOOP AT lt_usr02 INTO ls_usr02.
    ls_usr02-bname = 'MHAUBITZ'.
  ENDLOOP.

  LOOP AT lt_usr02 ASSIGNING FIELD-SYMBOL(<ls_usr02>).
    <ls_usr02>-bname = 'BLÖD'.
  ENDLOOP.

ENDFORM.                    " TABS

*&---------------------------------------------------------------------*
*&      Form  OBJS
*&---------------------------------------------------------------------*
FORM objs .

  DATA:
    lo_test   TYPE REF TO lcl_test,
    lo_test_2 TYPE REF TO lcl_test,
    lo_test2  TYPE REF TO lcl_test2,
    document  TYPE REF TO lcl_document.

  lo_test = NEW #( ).
  lo_test_2 = NEW #( ).
  lo_test2 = NEW #( ).
  document = NEW #( ).

  BREAK-POINT.

  lo_test_2 = lo_test.

  BREAK-POINT.

ENDFORM.                    " OBJS

*&---------------------------------------------------------------------*
*&      Form  wps
*&---------------------------------------------------------------------*
FORM wps.

  DATA
    : ld_int    TYPE i
    .
  FIELD-SYMBOLS
    : <l_fs>    TYPE i
    .
  BREAK-POINT.

  DO 10 TIMES.
    ld_int = sy-index ** 2.
    WRITE: / ld_int.
  ENDDO.

  BREAK-POINT.

  ASSIGN ld_int TO <l_fs>.

  ld_int = 15.

  UNASSIGN <l_fs>.

  ld_int = 18.

  BREAK-POINT.

ENDFORM.                    "wps

*&---------------------------------------------------------------------*
*&      Form  DIFF
*&---------------------------------------------------------------------*
FORM diff .

  DATA
    : lt_usr02_1    TYPE TABLE OF usr02
    , lt_usr02_2    TYPE TABLE OF usr02
    .
  FIELD-SYMBOLS
    : <ls_usr02>   TYPE          usr02
    .
  SELECT *
    FROM  usr02
    UP TO 50 ROWS
    INTO  TABLE lt_usr02_1.

  SELECT *
    FROM  usr02
    UP TO 50 ROWS
    INTO  TABLE lt_usr02_2.
  READ TABLE lt_usr02_2 ASSIGNING <ls_usr02> INDEX 20.
  <ls_usr02>-bname = 'mhaubitz'.
  READ TABLE lt_usr02_2 ASSIGNING <ls_usr02> INDEX 30.
  <ls_usr02>-ustyp = 'hallo'.

  BREAK-POINT.

  PERFORM objs.

ENDFORM.                    " DIFF

FORM layer.

  BREAK-POINT.

  PERFORM layer1.

ENDFORM.

FORM layer1.

  PERFORM write_programs(zinw_debug_layer).

ENDFORM.

FORM script .

  BREAK-POINT.

  SELECT *
    FROM usr02
    INTO TABLE @DATA(users)
    UP TO 10 ROWS.
  SELECT *
    FROM  t000
    INTO  TABLE @DATA(clients)
    UP TO 10 ROWS.
  SELECT *
    FROM  t005
    INTO  TABLE @DATA(countries)
    UP TO 10 ROWS.
  SELECT *
    FROM  t005t
    INTO  TABLE @DATA(country_names)
    UP TO 10 ROWS.
  SELECT *
    FROM  t002
    INTO  TABLE @DATA(languages)
    UP TO 10 ROWS.

ENDFORM.
