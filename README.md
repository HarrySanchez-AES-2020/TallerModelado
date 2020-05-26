# EAES_MODELADO Y VALIDACIÓN DE ARQUITECTURA
###### Taller 4 - Banco ABC por: Germán Cubillos, Fabián Burgos y Harry Sanchez.
El siguiente proyecto pretende modelar e implementar una solución de arquitectura utilizando una aproximación orientada a servicios utilizando los principios de diseño de servicios, diseño de patrones y estrategias para la construcción de arquitectura orientada a microservicios.

## INDICE
1. [Contexto](#CONTEXTO)
2. [Arquitectura de Solución](#ARQUITECTURA-DE-SOLUCIÓN)
3. [Patrones de Arquitectura](#PATRONES-DE-ARQUITECTURA)
4. [Diseño de la Arquitectura](#DISEÑO-DE-LA-ARQUITECTURA)
5. [Fuerzas de la Solución](#FUERZAS-DE-LA-SOLUCIÓN)
6. [Consecuencias de la Solución](#CONSECUENCIAS-DE-LA-SOLUCIÓN )

## CONTEXTO

El Banco ABC está realizando varios proyectos de actualización tecnológica los cuales le permiten ofrecer sus productos financieros de manera más ágil y de esta forma responder a nuevas necesidades del mercado. El Banco ABC quiere tener la posibilidad de adicionar nuevos convenios con otros proveedores de servicios de manera ágil, o incluso la posibilidad de terminar/eliminar los convenios existentes sin que esto represente indisponibilidad del servicio. Se llegó a un acuerdo de las capacidades/primitivas básicas que se deben soportar para cada convenio:

- Consulta de saldo a Pagar
- Pago del Servicio
- Compensación de pago (Opcional)

Principalmente el banco necesita un conjunto de servicios que representen sus necesidades internas de negocio, lo cual les permite desacoplar los servicios de los proveedores y así no depender de sus detalles.

## ARQUITECTURA DE SOLUCIÓN

La solución aquí planteada está basada en la necesidad de permitir al negocio una mayor interoperabilidad y un desacoplamiento de la lógica de negocio con la integración de los servicios de los sistemas de proveedores, lo que permite adicionar, eliminar o actualizar convenios de manera ágil y de manera trasparente para no generar indisponibilidades en la prestación del servicio. 

## PATRONES DE ARQUITECTURA

La solución planteada está principalmente basada sobre el estilo arquitectural de microservicios, la cual permite tener la encapsulación de una única responsabilidad y la independencia necesaria para la integración y orquestación de las operaciones necesarias en la consulta y pago de los servicios, así como también de su escalamiento, evolución o eliminación sin generar mayor impacto en la solución.

Los servicios se comunican entre sí a través de APIs bien definidas. A continuación, se detallan los patrones complementarios en los que se soporta la solución: 

**-	API Gateway:** Se realiza la implementación de un API Gateway con Apache Camel sobre sprint boot. Esta API permite tener un único punto de acceso a los diferentes microservicios expuestos por el Banco ABC. Allí se expone una puerta de enlace para cada uno de los microservicios que se tienen configurados actualmente y no se cuenta con ninguna lógica de negocio.

**-	API Composition:** Este patrón implementa una operación de consulta invocando los servicios que poseen los datos y combinando sus resultados. Allí se tienen dos tipos de participantes, un compositor el cual implementa la operación de consulta y un proveedor quien es el que posee algunos de los datos que devuelve la consulta. Esto permite realizar la composición por orquestación de los diferentes microservicios/servicios legados que se requieren para realizar las operaciones de consulta de saldo y pago de servicios y así solventar la necesidad de gestionar diversos proveedores sin impactar el sistema y su disponibilidad.

**-	Intermediate Routing:** Este patrón permite realizar el enrutamiento de mensajes a otros servicios o legados, en la solución que se diseña aquí se implementa bajo la funcionalidad de Content-Based Routing, que, en esencia, realizar el enrutamiento de los mensajes basados en su contenido, como por ejemplo el id de la referencia de pago. Puede ser utilizado para modelar procesos de negocio complejos y proporcionar una forma eficiente de recomponer los servicios sobre la ejecución.

**-	Decoupled Contract:**  Este patrón permite desacoplar el contrato del servicio de su implementación, permitiendo así que el servicio pueda evolucionar sin afectar directamente a los consumidores. Para esto los contratos se definieron bajo el principio de contrato primero.

**-	Data Model Transformation:** La lógica de transformación de modelo de datos se puede introducir para llevar a cabo la conversión en tiempo de ejecución de datos, de modo que estos se ajusten a un modelo de datos, pueden ser reestructurados para cumplir a un modelo de datos diferente. Esto se extiende un marco de mensajería no estandarizada lo que le permite superar dinámicamente disparidad entre los esquemas utilizados por un contrato de servicio y los mensajes transmitidos a ese contrato.

**-	Service Inventory:** Un inventario de servicios es una colección de servicios complementarios estandarizados y gobernados de forma independiente dentro de un límite que representa una empresa o un segmento significativo de una empresa.

## DISEÑO DE LA ARQUITECTURA

La solución aquí presentada esta basada bajo el estilo arquitectural de microservicios, se utilizaron los patrones anteriormente mencionados y esta diseñado para cumplir con las necesidades del negocio.

![imagen](https://github.com/germancubillos/javeriana/blob/master/EAES_MVA_Taller04_DS_Arquitectura.jpg)

**-Usuario:** La solución permite que se exponga la funcionalidad del banco a clientes a través de plataformas web o móviles y que se pueda acceder a ella de forma trasparente e independiente del canal.

**-	API Gateway:** La solución propuesta se compone de un api Gateway realizado con Apache Camel sobre sprint boot, que permite tener un único punto de acceso a la funcionalidad de consultar saldo y realizar pago.

**-	Orquestado de Servicios:** Es el encargado de realizar la composición por coreografía de los servicios de enrutador y despachador, este se implementa en Apache Camel.

**-	Enrutador:** Es el servicio encargado de identificar el convenio que se requiere para la realización de la transacción dado una referencia de pago, además de identificar el tipo de servicio (Rest o SOAP), devolver el end point del servicio legado y definir el tipo de transacción (Consulta Saldo o Pago). Además de permitir agregar, actualizar o eliminar nuevos convenios.

**-	Despachador:** Encargado de realizar el consumo y gestionar la comunicación de mensajes con los servicios de los proveedores. Este servicio se apoya del servicio de traductor cuando es necesario para realizar la transformación de los mensajes.

**-	Traductor:** Este servicio tiene la responsabilidad de realizar la transformación del modelo de los mensajes del estándar interno al modelo del servicio legado según corresponda.

**-	Descubridor de Servicios:** La idea básica detrás del descubridor de servicio es que cualquier instancia pueda ser capaz de identificar el servicio que necesita consultar. Esto es necesario para que la nueva instancia sea capaz de conectarse al ambiente de una aplicación existente sin intervención manual. Esto se realizó a través de Eureka.

**-	Servicios Legados:** Servicios expuestos por los proveedores y que servirán como fuente de información para realizar las operaciones de consulta de salto y pago de servicios. Estos pueden estar implementados en cualquier tecnología y expuestos bajo cualquier protocolo y/o estilo arquitectural.


El diseño de la arquitectura que se propone para el banco ABC realiza el siguiente flujo para la consulta del saldo de sus servicios públicos: 1. El usuario envía la referencia de pago para realizar la consulta; 2. la puerta de entrada realiza el direccionamiento al orquestador quien según su lógica de composición (3) realiza el consumo del servicio de enrutador enviando la referencia de pago. 

4. El enrutador según su lógica de implementación realiza la consulta del tipo de servicio que puede ser REST o SOAP, el método de comunicación GET o POST, el end point del servicio legado, el tipo de operación que para este caso siempre será Consulta de Saldo y el id de convenio. 

5. Esta información y la referencia de pago se envía al despachador para que este a su vez consuma el servicio traductor si así lo considera necesario; 6. El traductor realiza la traducción del esquema estándar definido internamente en el sistema al esquema que requiere el sistema legado (7).

8. El despachador una vez a recibido el esquema del mensaje traducido según como lo requiere el legado invoca este servicio, (9) y espera la respuesta del legado; 10. Envía el mensaje de respuesta del legado al traductor para que este realice la traducción del modelo de datos al esquema estándar de respuesta y (11) este lo envié de vuelta al despachador.

12. El despachador da como respuesta a la petición del orquestador la referencia de pago y el valor a pagar, (13) el cual lo propaga al API Gateway quien realiza el envío al usuario final (14).

![imagen](https://github.com/germancubillos/javeriana/blob/master/EAES_MVA_Taller04_DS_Saldo.jpg)

A continuación, se define el flujo del proceso de pago el cual es exactamente igual al flujo de consulta el cambio radica en (3) el enrutador quien es el encargado según su lógica implementada de definir la operación de la transacción que ente caso es la de pagar y (9) una vez recibe el mensaje de parte del legado con el estado de la transacción esta se propaga hasta el usuario final.

![imagen](https://github.com/germancubillos/javeriana/blob/master/EAES_MVA_Taller04_DS_Pago.jpg)

## FUERZAS DE LA SOLUCIÓN

A continuación, se describen los requerimientos y restricciones que están relacionadas y que pueden afectar la correcta implementación del sistema de pago de servicios y como el patrón nuclear y complementario ayudan a soportar estas necesidades:
-	La gestión de roles y sus funciones específicas es un desafío que se requiere cumplir para la operación correcta de la aplicación, para esto el patrón nuclear de un sistema por microservicios permite la gestión de los roles y el dominio de sus responsabilidades para la operación correcta del proceso.

-	La división de cada una de las tareas que se requieren para la operación en conjunto del sistema permite gestionar independientemente las funcionalidades que pueden realizar los actores dentro del sistema, permitiendo así realizar cambios modularizados sin afectación del sistema en general. 

-	Independencia y agilidad pues al tener esta definición de microservicios es más fácil de gestionar hot fix o evolutivos, sin dejar de lado la agilidad que implicaría su implementación y despliegue en los diferentes ambientes. 

-	Ser independiente de la tecnología o el estándar de implementación permite que la interoperabilidad e integración sea trasparente para el sistema. Además de permitir al equipo de desarrollo implementarlos de manera independiente y enfocados en la necesidad que debe cumplir cada servicio.

-	Aislamiento de errores o excepciones, pues si un servicio no está disponible, no repercute en toda la aplicación, siempre que los servicios de nivel superior estén preparados para controlar los errores correctamente.

-	Los servicios se pueden escalar de forma independiente, lo que permite escalar horizontalmente los subsistemas que requieren más recursos, sin tener que escalar horizontalmente toda la aplicación. 

-	Al requerir actualizar, agregar o eliminar el esquema de un servicio, es mucho más fácil generando un bajo impacto sobre el sistema.


## CONSECUENCIAS DE LA SOLUCIÓN 

Las ventajas de los microservicios tienen un "precio". Estos son algunos de los aspectos que deben tenerse en cuenta en esta solución de arquitectura, al realizar la definición de bajo nivel de la presente arquitectura o al hacer evolutivos sobre la misma:

-	Es importante definir una estructura de mensajes flexible que permita mitigar los riesgos que se puedan presentar al realizar un cambio en la estructura de los contratos para alguno de los servicios ya que si no se contempla esto conllevaría en una refacturación en cascada.

-	Es de vital importancia definir consensuadamente el nivel de abstracción de la responsabilidad que se quiere delegar en cada una de los servicios y su integración con el sistema ya que una mala definición puede ocasionar trabajo innecesario, baja eficiencia y problemas de concurrencia. Cada servicio es más sencillo, pero el sistema como un todo es más complejo.

-	Si la cadena de dependencias del servicio se hace demasiado larga (el servicio A llama a B, que llama a C...), la latencia adicional puede constituir un problema. Por esto se centraliza esta responsabilidad al orquestador, que en caso de ser necesario puede escalarse bajo la demanda requerida y realizar ejecuciones en paralelo para minimizar el tiempo de respuesta para una operación de consulta.

-	La integridad de datos está limitada a la gestión que cada servicio realice pues es responsable de la conservación de sus propios datos. Como consecuencia, la coherencia de los datos puede suponer un problema. 

-	Si bien el tener este diseño basado en servicios permite enfocar esfuerzo de pruebas sobre a funcionalidad del servicio en particular, también implica un proceso de pruebas end to end para asegurar que el microservicio no afectar la coordinación dentro del sistema.





