# EAES_Modelado y Validación de Arqitectura
### Taller 4 - Banco ABC

El siguiente proyecto pretende modelar e implementar una solución de Arquitectura utilizando una aproximación Orientada a servicios utilizando los principios de diseño de servicios, diseño de patrones y estrategias para la construcción de arquitectura orientada a microservicios.

# Contexto 

El Banco ABC está realizando varios proyectos de actualización tecnológica los cuales le permiten ofrecer sus productos financieros de manera más ágil y de esta forma responder a nuevas necesidades del mercado. El Banco ABC quiere tener la posibilidad de adicionar nuevos convenios con otros proveedores de servicios de manera ágil, o incluso la posibilidad de terminar/eliminar los convenios existentes sin que esto represente indisponibilidad del servicio. Se llegó a un acuerdo de las capacidades/primitivas básicas que se deben soportar para cada convenio:

- Consulta de saldo a Pagar
- Pago del Servicio
- Compensación de pago (Opcional)

Principalmente el banco necesita un conjunto de servicios que representen sus necesidades internas de negocio, lo cual les permite desacoplar los servicios de los proveedores y así no depender de sus detalles.

