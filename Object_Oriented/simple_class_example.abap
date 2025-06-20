REPORT z_oop_example.

CLASS lcl_vehicle DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING iv_brand TYPE string
                                   iv_model TYPE string
                                   iv_year TYPE i,
             get_info RETURNING VALUE(rv_info) TYPE string,
             start_engine.
  PROTECTED SECTION.
    DATA: mv_brand TYPE string,
          mv_model TYPE string,
          mv_year TYPE i,
          mv_engine_running TYPE abap_bool.
ENDCLASS.

CLASS lcl_vehicle IMPLEMENTATION.
  METHOD constructor.
    mv_brand = iv_brand.
    mv_model = iv_model.
    mv_year = iv_year.
    mv_engine_running = abap_false.
  ENDMETHOD.

  METHOD get_info.
    rv_info = |{ mv_brand } { mv_model } ({ mv_year })|.
  ENDMETHOD.

  METHOD start_engine.
    mv_engine_running = abap_true.
    WRITE: / 'Двигатель', mv_brand, mv_model, 'запущен'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_car DEFINITION INHERITING FROM lcl_vehicle.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING iv_brand TYPE string
                                   iv_model TYPE string
                                   iv_year TYPE i
                                   iv_doors TYPE i,
             get_doors RETURNING VALUE(rv_doors) TYPE i.
  PRIVATE SECTION.
    DATA: mv_doors TYPE i.
ENDCLASS.

CLASS lcl_car IMPLEMENTATION.
  METHOD constructor.
    super->constructor( iv_brand = iv_brand
                        iv_model = iv_model
                        iv_year = iv_year ).
    mv_doors = iv_doors.
  ENDMETHOD.

  METHOD get_doors.
    rv_doors = mv_doors.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA: lo_vehicle TYPE REF TO lcl_vehicle,
        lo_car TYPE REF TO lcl_car.

  CREATE OBJECT lo_vehicle
    EXPORTING
      iv_brand = 'Toyota'
      iv_model = 'Camry'
      iv_year = 2023.

  CREATE OBJECT lo_car
    EXPORTING
      iv_brand = 'BMW'
      iv_model = 'X5'
      iv_year = 2024
      iv_doors = 4.

  WRITE: / 'Информация о транспорте:'.
  WRITE: / lo_vehicle->get_info( ).
  lo_vehicle->start_engine( ).

  WRITE: / 'Информация об автомобиле:'.
  WRITE: / lo_car->get_info( ).
  WRITE: / 'Количество дверей:', lo_car->get_doors( ).
  lo_car->start_engine( ). 