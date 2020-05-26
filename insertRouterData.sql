insert into convenio values ('1', 'gas', 'http://localhost:8080/gas-service/PagosService', 'get', 'consultar', '', 'soap');
insert into convenio values ('2', 'gas', 'http://localhost:8080/gas-service/PagosService', 'post', 'pagar', '', 'soap');
insert into convenio values ('3', 'agua', 'http://localhost:9090/servicios/pagos/v1/payments/idFactura', 'get', 'consultar', '', 'rest');
insert into convenio values ('4', 'agua', 'http://localhost:9090/servicios/pagos/v1/payments/idFactura', 'post', 'pagar', '', 'rest');

insert into clave_convenio values ('1', '^abdc', 'gas');
insert into clave_convenio values ('2', '.*', 'agua');

