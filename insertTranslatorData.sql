INSERT INTO `services_abcBank`.`plantilla_convenio`
VALUES
(1,
"idFactura",
"gas",
"req",
"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sch=\"http://www.servicios.co/pagos/schemas\"> <soapenv:Header/><soapenv:Body><sch:ReferenciaFactura><sch:referenciaFactura>idFactura</sch:referenciaFactura></sch:ReferenciaFactura></soapenv:Body></soapenv:Envelope>",
"consulta");

INSERT INTO `services_abcBank`.`plantilla_convenio`
VALUES
(2,
"totalPagar",
"gas",
"res",
"",
"consulta");

INSERT INTO `services_abcBank`.`plantilla_convenio`
VALUES
(3,
"idFactura;valorFactura",
"gas",
"req",
"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sch=\"http://www.servicios.co/pagos/schemas\"><soapenv:Header/><soapenv:Body><sch:PagoResource><sch:referenciaFactura><sch:referenciaFactura>idFactura</sch:referenciaFactura></sch:referenciaFactura><sch:totalPagar>valorFactura</sch:totalPagar></sch:PagoResource></soapenv:Body></soapenv:Envelope>",
"pagar");

INSERT INTO `services_abcBank`.`plantilla_convenio`
VALUES
(4,
"mensaje",
"gas",
"res",
"",
"pagar");

INSERT INTO `services_abcBank`.`plantilla_convenio`
VALUES
(5,
"idFactura",
"agua",
"req",
"",
"consulta");

INSERT INTO `services_abcBank`.`plantilla_convenio`
VALUES
(6,
"factura;valor",
"agua",
"req",
"{ \"idFactura\": factura, \"valorFactura\": valor }",
"pagar");
