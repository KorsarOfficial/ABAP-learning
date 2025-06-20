REPORT z_basic_operations.

DATA: lv_number1 TYPE i VALUE 10,
      lv_number2 TYPE i VALUE 5,
      lv_result TYPE i,
      lv_text1 TYPE string VALUE 'Привет',
      lv_text2 TYPE string VALUE 'Мир',
      lv_combined TYPE string,
      lv_date TYPE dats,
      lv_time TYPE tims,
      lv_counter TYPE i.

START-OF-SELECTION.
  WRITE: / 'БАЗОВЫЕ ОПЕРАЦИИ В ABAP'.
  ULINE.

  lv_result = lv_number1 + lv_number2.
  WRITE: / 'Сложение:', lv_number1, '+', lv_number2, '=', lv_result.

  lv_result = lv_number1 - lv_number2.
  WRITE: / 'Вычитание:', lv_number1, '-', lv_number2, '=', lv_result.

  lv_result = lv_number1 * lv_number2.
  WRITE: / 'Умножение:', lv_number1, '*', lv_number2, '=', lv_result.

  lv_result = lv_number1 / lv_number2.
  WRITE: / 'Деление:', lv_number1, '/', lv_number2, '=', lv_result.

  lv_result = lv_number1 MOD lv_number2.
  WRITE: / 'Остаток от деления:', lv_number1, 'MOD', lv_number2, '=', lv_result.

  ULINE.
  WRITE: / 'РАБОТА СО СТРОКАМИ'.

  lv_combined = lv_text1 && ' ' && lv_text2.
  WRITE: / 'Конкатенация:', lv_combined.

  WRITE: / 'Длина строки "', lv_text1, '":', strlen( lv_text1 ).

  IF lv_text1 = 'Привет'.
    WRITE: / 'Строки равны'.
  ELSE.
    WRITE: / 'Строки не равны'.
  ENDIF.

  ULINE.
  WRITE: / 'УСЛОВНЫЕ ОПЕРАТОРЫ'.

  IF lv_number1 > lv_number2.
    WRITE: / lv_number1, 'больше', lv_number2.
  ELSEIF lv_number1 < lv_number2.
    WRITE: / lv_number1, 'меньше', lv_number2.
  ELSE.
    WRITE: / lv_number1, 'равно', lv_number2.
  ENDIF.

  CASE lv_number2.
    WHEN 1.
      WRITE: / 'Число равно 1'.
    WHEN 5.
      WRITE: / 'Число равно 5'.
    WHEN OTHERS.
      WRITE: / 'Число не равно 1 или 5'.
  ENDCASE.

  ULINE.
  WRITE: / 'ЦИКЛЫ'.

  DO 3 TIMES.
    lv_counter = lv_counter + 1.
    WRITE: / 'DO цикл, итерация:', lv_counter.
  ENDDO.

  lv_counter = 1.
  WHILE lv_counter <= 3.
    WRITE: / 'WHILE цикл, итерация:', lv_counter.
    lv_counter = lv_counter + 1.
  ENDWHILE.

  ULINE.
  WRITE: / 'СИСТЕМНЫЕ ПЕРЕМЕННЫЕ'.

  lv_date = sy-datum.
  lv_time = sy-uzeit.
  WRITE: / 'Текущая дата:', lv_date.
  WRITE: / 'Текущее время:', lv_time.
  WRITE: / 'Пользователь:', sy-uname.
  WRITE: / 'Мандант:', sy-mandt. 