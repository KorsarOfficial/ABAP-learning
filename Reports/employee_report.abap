REPORT z_employee_report.

TABLES: sscrfields.

TYPES: BEGIN OF ty_employee,
         emp_id TYPE n LENGTH 8,
         firstname TYPE string,
         lastname TYPE string,
         department TYPE string,
         salary TYPE p DECIMALS 2,
         hire_date TYPE dats,
       END OF ty_employee.

DATA: lt_employees TYPE TABLE OF ty_employee,
      ls_employee TYPE ty_employee,
      lv_total_salary TYPE p DECIMALS 2,
      lv_avg_salary TYPE p DECIMALS 2,
      lv_count TYPE i.

SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
PARAMETERS: p_dept TYPE string DEFAULT 'IT' OBLIGATORY.
SELECT-OPTIONS: s_sal FOR ls_employee-salary.
PARAMETERS: p_show AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN: END OF BLOCK b1.

INITIALIZATION.
  text-001 = 'Параметры отчета'.

  ls_employee-emp_id = '00000001'.
  ls_employee-firstname = 'Иван'.
  ls_employee-lastname = 'Петров'.
  ls_employee-department = 'IT'.
  ls_employee-salary = '75000.00'.
  ls_employee-hire_date = '20230115'.
  APPEND ls_employee TO lt_employees.

  ls_employee-emp_id = '00000002'.
  ls_employee-firstname = 'Мария'.
  ls_employee-lastname = 'Сидорова'.
  ls_employee-department = 'HR'.
  ls_employee-salary = '65000.00'.
  ls_employee-hire_date = '20230301'.
  APPEND ls_employee TO lt_employees.

  ls_employee-emp_id = '00000003'.
  ls_employee-firstname = 'Алексей'.
  ls_employee-lastname = 'Иванов'.
  ls_employee-department = 'IT'.
  ls_employee-salary = '80000.00'.
  ls_employee-hire_date = '20220915'.
  APPEND ls_employee TO lt_employees.

  ls_employee-emp_id = '00000004'.
  ls_employee-firstname = 'Елена'.
  ls_employee-lastname = 'Козлова'.
  ls_employee-department = 'Finance'.
  ls_employee-salary = '70000.00'.
  ls_employee-hire_date = '20231020'.
  APPEND ls_employee TO lt_employees.

START-OF-SELECTION.
  WRITE: / 'ОТЧЕТ ПО СОТРУДНИКАМ'.
  WRITE: / sy-datum, sy-uzeit.
  ULINE.

  IF p_show = 'X'.
    WRITE: / 'Фильтр по отделу:', p_dept.
    ULINE.

    WRITE: /5 'ID', 15 'Имя', 35 'Фамилия', 55 'Отдел', 75 'Зарплата', 95 'Дата найма'.
    ULINE.

    LOOP AT lt_employees INTO ls_employee
      WHERE department = p_dept
      AND salary IN s_sal.

      WRITE: /5 ls_employee-emp_id,
             15 ls_employee-firstname,
             35 ls_employee-lastname,
             55 ls_employee-department,
             75 ls_employee-salary,
             95 ls_employee-hire_date.

      lv_total_salary = lv_total_salary + ls_employee-salary.
      lv_count = lv_count + 1.
    ENDLOOP.

    ULINE.
    IF lv_count > 0.
      lv_avg_salary = lv_total_salary / lv_count.
      WRITE: / 'Количество сотрудников:', lv_count.
      WRITE: / 'Общая зарплата:', lv_total_salary.
      WRITE: / 'Средняя зарплата:', lv_avg_salary.
    ELSE.
      WRITE: / 'Сотрудники не найдены по заданным критериям'.
    ENDIF.
  ELSE.
    WRITE: / 'Отображение отчета отключено'.
  ENDIF. 