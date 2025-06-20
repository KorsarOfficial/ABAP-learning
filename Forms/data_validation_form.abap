REPORT z_data_validation.

DATA: lv_email TYPE string,
      lv_phone TYPE string,
      lv_age TYPE i,
      lv_valid TYPE abap_bool.

PARAMETERS: p_email TYPE string OBLIGATORY,
            p_phone TYPE string OBLIGATORY,
            p_age TYPE i OBLIGATORY.

START-OF-SELECTION.
  lv_email = p_email.
  lv_phone = p_phone.
  lv_age = p_age.

  PERFORM validate_email USING lv_email CHANGING lv_valid.
  IF lv_valid = abap_true.
    WRITE: / 'Email корректный:', lv_email.
  ELSE.
    WRITE: / 'Email некорректный:', lv_email.
  ENDIF.

  PERFORM validate_phone USING lv_phone CHANGING lv_valid.
  IF lv_valid = abap_true.
    WRITE: / 'Телефон корректный:', lv_phone.
  ELSE.
    WRITE: / 'Телефон некорректный:', lv_phone.
  ENDIF.

  PERFORM validate_age USING lv_age CHANGING lv_valid.
  IF lv_valid = abap_true.
    WRITE: / 'Возраст корректный:', lv_age.
  ELSE.
    WRITE: / 'Возраст некорректный:', lv_age.
  ENDIF.

FORM validate_email USING p_email TYPE string
                   CHANGING p_valid TYPE abap_bool.
  p_valid = abap_false.
  IF p_email CA '@' AND p_email CA '.'.
    IF strlen( p_email ) > 5.
      p_valid = abap_true.
    ENDIF.
  ENDIF.
ENDFORM.

FORM validate_phone USING p_phone TYPE string
                   CHANGING p_valid TYPE abap_bool.
  p_valid = abap_false.
  IF strlen( p_phone ) >= 10 AND strlen( p_phone ) <= 15.
    IF p_phone+0(1) = '+' OR ( p_phone+0(1) >= '0' AND p_phone+0(1) <= '9' ).
      p_valid = abap_true.
    ENDIF.
  ENDIF.
ENDFORM.

FORM validate_age USING p_age TYPE i
                 CHANGING p_valid TYPE abap_bool.
  p_valid = abap_false.
  IF p_age >= 18 AND p_age <= 100.
    p_valid = abap_true.
  ENDIF.
ENDFORM. 