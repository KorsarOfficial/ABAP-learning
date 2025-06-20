REPORT z_internal_table_ops.

TYPES: BEGIN OF ty_product,
         id TYPE i,
         name TYPE string,
         price TYPE p DECIMALS 2,
         category TYPE string,
       END OF ty_product.

DATA: lt_products TYPE TABLE OF ty_product,
      ls_product TYPE ty_product,
      lv_total_price TYPE p DECIMALS 2.

INITIALIZATION.
  ls_product-id = 1.
  ls_product-name = 'Ноутбук'.
  ls_product-price = '50000.00'.
  ls_product-category = 'Электроника'.
  APPEND ls_product TO lt_products.

  ls_product-id = 2.
  ls_product-name = 'Мышь'.
  ls_product-price = '1500.00'.
  ls_product-category = 'Электроника'.
  APPEND ls_product TO lt_products.

  ls_product-id = 3.
  ls_product-name = 'Книга'.
  ls_product-price = '800.00'.
  ls_product-category = 'Образование'.
  APPEND ls_product TO lt_products.

START-OF-SELECTION.
  WRITE: / 'Список продуктов:'.
  ULINE.

  LOOP AT lt_products INTO ls_product.
    WRITE: / 'ID:', ls_product-id,
           / 'Название:', ls_product-name,
           / 'Цена:', ls_product-price,
           / 'Категория:', ls_product-category.
    ULINE.
  ENDLOOP.

  LOOP AT lt_products INTO ls_product.
    lv_total_price = lv_total_price + ls_product-price.
  ENDLOOP.

  WRITE: / 'Общая стоимость:', lv_total_price.

  SORT lt_products BY price DESCENDING.
  WRITE: / 'Сортировка по цене (убывание):'.
  ULINE.

  LOOP AT lt_products INTO ls_product.
    WRITE: / ls_product-name, '-', ls_product-price.
  ENDLOOP.

  READ TABLE lt_products INTO ls_product WITH KEY id = 2.
  IF sy-subrc = 0.
    WRITE: / 'Найден продукт с ID 2:', ls_product-name.
  ENDIF.

  DELETE lt_products WHERE category = 'Образование'.
  WRITE: / 'После удаления книг:', lines( lt_products ), 'товаров осталось'. 