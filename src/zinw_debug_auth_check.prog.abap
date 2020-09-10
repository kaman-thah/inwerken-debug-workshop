*&---------------------------------------------------------------------*
*& Report ZINW_DEBUG_AUTH_CHECK
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
REPORT zinw_debug_auth_check.

START-OF-SELECTION.

  BREAK-POINT.

  AUTHORITY-CHECK OBJECT 'S_CARRID'
      ID 'CARRID' FIELD 'LH'
      ID 'ACTVT' FIELD '06'.
  IF sy-subrc <> 0.
    WRITE: / 'Berechtigungsprüfung nicht erfolgreich'.
    EXIT.
  ENDIF.

  WRITE: / 'Berechtigungsprüfung erfolgreich'.
