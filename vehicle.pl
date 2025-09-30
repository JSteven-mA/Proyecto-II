% -------------------------------------
% Catálogo de vehículos
% vehicle(Marca, Referencia, Tipo, Precio, Año).
% -------------------------------------

vehicle(toyota, corolla, sedan, 22000, 2021).
vehicle(toyota, rav4, suv, 28000, 2022).
vehicle(toyota, hilux, pickup, 35000, 2020).
vehicle(ford, fiesta, sedan, 18000, 2019).
vehicle(ford, explorer, suv, 40000, 2021).
vehicle(ford, ranger, pickup, 32000, 2022).
vehicle(ford, mustang, sport, 45000, 2023).
vehicle(bmw, x3, suv, 50000, 2021).
vehicle(bmw, x5, suv, 60000, 2021).
vehicle(bmw, serie3, sedan, 42000, 2022).
vehicle(chevrolet, camaro, sport, 38000, 2020).

% -------------------------------------
% Parte 2: Consultas y filtros
% -------------------------------------

% Filtrar por presupuesto
meet_budget(Reference, BudgetMax) :-
    vehicle(_, Reference, _, Price, _),
    Price =< BudgetMax.

% Listar vehículos por marca usando findall
list_by_brand(Brand, References) :-
    findall(Ref, vehicle(Brand, Ref, _, _, _), References).

% Listar vehículos agrupados por marca con bagof
list_grouped_by_brand(Brand, Grouped) :-
    bagof((Ref, Type, Year, Price),
          vehicle(Brand, Ref, Type, Price, Year),
          Grouped).

% -------------------------------------
% Parte 3: Generación de reportes
% -------------------------------------

generate_report(Brand, Type, Budget, Result) :-
    findall((Ref, Price),
            (vehicle(Brand, Ref, Type, Price, _), Price =< Budget),
            Vehicles),
    total_value(Vehicles, Total),
    Limit is 1000000,   % límite del inventario
    (Total =< Limit -> Result = (Vehicles, Total) ;
     adjust_inventory(Vehicles, Limit, Adjusted, NewTotal),
     Result = (Adjusted, NewTotal)).

% Calcular el valor total de una lista de vehículos
total_value([], 0).
total_value([(_, Price)|T], Total) :-
    total_value(T, Subtotal),
    Total is Price + Subtotal.

% Ajustar inventario si se excede el límite (mantener los más baratos)
adjust_inventory(Vehicles, Limit, Adjusted, NewTotal) :-
    sort(2, @=<, Vehicles, Sorted), % ordena por precio ascendente
    take_until_limit(Sorted, Limit, Adjusted, NewTotal).

take_until_limit([], _, [], 0).
take_until_limit([(Ref, Price)|T], Limit, [(Ref, Price)|Result], NewTotal) :-
    Price =< Limit,
    Remaining is Limit - Price,
    take_until_limit(T, Remaining, Result, Subtotal),
    NewTotal is Price + Subtotal.
take_until_limit([(_, Price)|_], Limit, [], 0) :-
    Price > Limit.

% -------------------------------------
% Parte 4: Casos de prueba
% -------------------------------------

% 1. Listar todos los Toyota SUV < 30k
test_case1(Result) :-
    findall(Ref, (vehicle(toyota, Ref, suv, Price, _), Price < 30000), Result).

% 2. Mostrar vehículos Ford agrupados por tipo y año
test_case2(Result) :-
    bagof((Type, Year, Ref),
          Price^vehicle(ford, Ref, Type, Price, Year),
          Result).

% 3. Calcular valor total de sedanes sin exceder 500k
test_case3(Result) :-
    findall((Ref, Price),
            (vehicle(_, Ref, sedan, Price, _)),
            Vehicles),
    total_value(Vehicles, Total),
    (Total =< 500000 -> Result = (Vehicles, Total) ;
     adjust_inventory(Vehicles, 500000, Adjusted, NewTotal),
     Result = (Adjusted, NewTotal)).
