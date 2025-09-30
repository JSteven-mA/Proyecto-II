# README – Sistema de Gestión de inventario de Vehículos en Prolog

Autores: Stephanie Jaramillo Alzate y Jaisson Steven Merchán Ardila 
Curso: Lenguajes y Paradigmas de la Computación
Profesor: Alexander Narváez Berrío
Fecha: 29 de septiembre 2025

## Descripción

Este proyecto implementa en Prolog un sistema de gestión de inventario para una concesionaria de vehículos.
El sistema permite:

* Definir un catálogo de vehículos mediante hechos Prolog.
* Consultar si un vehículo cumple un presupuesto máximo.
* Listar referencias de vehículos por marca usando findall/3.
* Agrupar vehículos por marca, tipo o año usando bagof/3.
* Generar reportes filtrados por marca, tipo y presupuesto, calculando el valor total del inventario.
* Ajustar el inventario si el valor total supera un límite predefinido, priorizando los vehículos más baratos.
* Ejecutar casos de prueba solicitados en la práctica.

## Estructura del proyecto

vehiculos.pl : archivo principal en Prolog con los hechos y predicados.
README.md : este documento.
Video: Explicación del código.

## Requisitos

* Intérprete SWI-Prolog ([https://www.swi-prolog.org/](https://www.swi-prolog.org/)).
* Sistema operativo Windows, Linux o MacOS.

## Uso del sistema

1. Abrir SWI-Prolog.

2. Cargar el archivo con el comando:
   ?- [vehiculos].

3. Ejecutar consultas de ejemplo:

   * Verificar si un vehículo cumple con el presupuesto:
     ?- meet_budget(rav4, 30000).

   * Listar vehículos de una marca:
     ?- list_by_brand(toyota, L).

   * Agrupar vehículos de una marca con detalles:
     ?- list_grouped_by_brand(ford, G).

   * Generar reporte filtrado:
     ?- generate_report(toyota, suv, 30000, R).

## Casos de prueba

1. Listar todos los SUV Toyota con precio menor a 30,000:
   ?- test_case1(R).

2. Mostrar vehículos Ford agrupados por tipo y año:
   ?- test_case2(R).

3. Calcular el valor total de los sedanes sin exceder 500,000:
   ?- test_case3(R).

## Notas de diseño

* Los vehículos se almacenan como hechos estáticos.
* Los predicados utilizan técnicas clásicas de Prolog: unificación, backtracking y recolección con findall/3 y bagof/3.
* El inventario puede ampliarse añadiendo nuevos hechos vehicle/5.

## Entrega

* Código fuente en Prolog.
* README explicativo.
* Video corto mostrando el funcionamiento.

