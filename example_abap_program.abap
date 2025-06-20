REPORT zexample_program.
DATA: lv_name TYPE string VALUE 'Иван',
      lv_age  TYPE i VALUE 25,
      lv_salary TYPE p DECIMALS 2 VALUE '50000.00',
      lv_result TYPE string.

TYPES: BEGIN OF ty_employee,
         name TYPE string,
         position TYPE string,
         salary TYPE p DECIMALS 2,
       END OF ty_employee.

DATA: lt_employees TYPE TABLE OF ty_employee,
      ls_employee TYPE ty_employee.

CONSTANTS: c_company TYPE string VALUE 'ООО "Пример"',
           c_currency TYPE string VALUE 'RUB'.

INITIALIZATION.
  WRITE: / 'Добро пожаловать в программу на ABAP!'.

START-OF-SELECTION.
  WRITE: / 'Информация о сотруднике:',
         / 'Имя:', lv_name,
         / 'Возраст:', lv_age,
         / 'Зарплата:', lv_salary, c_currency.

  IF lv_age >= 18.
    WRITE: / 'Статус: Совершеннолетний'.
  ELSE.
    WRITE: / 'Статус: Несовершеннолетний'.
  ENDIF.

  WRITE: / 'Расчет годовой зарплаты:'.
  lv_salary = lv_salary * 12.
  WRITE: / 'Годовая зарплата:', lv_salary, c_currency.

  WRITE: / '--- Список сотрудников ---'.
  ls_employee-name = 'Петр Иванов'.
  ls_employee-position = 'Разработчик'.
  ls_employee-salary = '60000.00'.
  APPEND ls_employee TO lt_employees.

  ls_employee-name = 'Мария Петрова'.
  ls_employee-position = 'Аналитик'.
  ls_employee-salary = '55000.00'.
  APPEND ls_employee TO lt_employees.

  ls_employee-name = 'Алексей Сидоров'.
  ls_employee-position = 'Тестировщик'.
  ls_employee-salary = '45000.00'.
  APPEND ls_employee TO lt_employees.

  LOOP AT lt_employees INTO ls_employee.
    WRITE: / ls_employee-name, 
           ' - ', ls_employee-position,
           ' - ', ls_employee-salary, c_currency.
  ENDLOOP.

  WRITE: / '--- Категории зарплат ---'.
  LOOP AT lt_employees INTO ls_employee.
    CASE ls_employee-salary.
      WHEN 0 TO 40000.
        lv_result = 'Низкая зарплата'.
      WHEN 40001 TO 55000.
        lv_result = 'Средняя зарплата'.
      WHEN OTHERS.
        lv_result = 'Высокая зарплата'.
    ENDCASE.
    WRITE: / ls_employee-name, ':', lv_result.
  ENDLOOP.

  PERFORM show_company_info.

FORM show_company_info.
  WRITE: / '--- Информация о компании ---',
         / 'Название:', c_company,
         / 'Валюта:', c_currency,
         / 'Количество сотрудников:', lines( lt_employees ).
ENDFORM.

TRY.
    DATA(lv_division) = 100 / 5.
    WRITE: / 'Результат деления: ', lv_division.
    
  CATCH cx_sy_arithmetic_error.
    WRITE: / 'Ошибка: Деление на ноль!'.
    
  CATCH cx_root INTO DATA(lo_exception).
    WRITE: / 'Общая ошибка: ', lo_exception->get_text( ).
ENDTRY.

END-OF-SELECTION.
  WRITE: / 'Программа завершена успешно.'. 