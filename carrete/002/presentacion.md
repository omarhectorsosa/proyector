layout: true
class: center, middle, inverse
---
# Modelo de Seguridad

---
layout: true
class: animated fadeInUp
---
## Agenda

(Tiempo estimado: 1h)

- Alcance
- Requerimientos
- Modelo

---
## Alcance

- AAA
  - Proveer mecanismos de __Autenticación__.
  - Proveer mecanismos de __Autorización__.
  - Mantener la __Auditoría__ de seguridad.
- Para cualquier ambito del negocio en donde se requiera AAA.

```
Advertencia. Seguridad al momento es un trabajo en progreso.
```

## Fuera de Alcance

- Establecimiento de las reglas de negocio de autorización.
- Seguridad conoce cuentas de seguridad (en adelante __CDS__), no personas.

---
## Requerimientos [1/2] 

- Debe brindar AAA diferentes ambitos del negocio.
- Debe soportar la existencia de diferentes tipos y formatos de __CDS__.
- Debe soportar la existencia de diferentes tipos y formatos de clave.
- Debe soportar la posibilidad de que una __CDS__ utilize varios tipos de clave.
- Debe soportar la posibilidad de asignarle diferentes niveles de autorización a cada tipo de clave.
- Debe soportar la posibilidad de que un tipo de clave sea utilizado por varias __CDS__.
- Debe poder establecer reglas diferenciadas para cada ambito. 
- Debe poder establecer reglas de autorización diferenciadas para cada aplicacion cliente.
- Debe poder indentificar a la aplicación cliente.
- Debe brindar mecanismos de recuperación de acceso.
- Debe brindar mecanismos de creación de __CDS__.

---
## Requerimientos [2/2] 

- Debe ser lenta en la autenticación pero Debe ser rápida en la autorización.
- Debe proporcionar un mecanismo SSO Web.
- Debe proporcionar un mecanismo SSO Movil.
- Debe proporcionar mecanismos 2SV (verificación en dos pasos).
  - Debe proporcionar 2SV via SMS.
  - Debe proporcionar 2SV via Email.
  - Debería proporcionar 2SV TOTP.
- Debería integrarse con otros sistemas de autenticación (LDAP, Google, Facebook).
- Debe ser independiente del sistema SOL.
- Debe proporcionar formas amigables de identificación para una __CDS__.
- No debe persistir claves en texto plano.

---
## Documentación asociada

- Listado de proyectos [filtrados por "seguridad"](https://git.psa.com.ar/search?utf8=%E2%9C%93&search=seguridad&group_id=&project_id=&repository_ref=&nav_source=navbar).
- Modelo datos [desplegado en PSAR](https://git.psa.com.ar/ipsa/sistemas/dev/database/psar/tree/development/tables/SE__).
- Seguridad V2, [documentacion técnica provista por el desarrollador](https://git.psa.com.ar/ipsa/sistemas/dev/ipsaem/ar.com.psa.ipsaem.app.seguridad.v2/blob/development/documentacion/tecnica/README.md).
- Documento compartido en [Google Doc](https://docs.google.com/document/d/1LPGHyXpZdbyC2YkweHpP-ezx8sWX4l41MfTGMKkv2c8/edit#heading=h.u3xnpjt2q1xe).
- Glosario de terminos [en construcción](https://git.psa.com.ar/ipsa/sistemas/dev/ipsaem/ar.com.psa.ipsaem.app.seguridad.v2/blob/development/documentacion/negocio/glosario_terminos.md).
- Modelo de dominio en [Enterprise Architect](https://git.psa.com.ar/ipsa/sistemas/dev/ipsaem/modelado/blob/publico/V2-WorkInProgress/IPSAEM-Seguridad.eap).

---
## Modelo de Datos

Repasemos el [modelo de datos](https://git.psa.com.ar/ipsa/sistemas/dev/database/psar/tree/development/tables/SE__).

---
class: center, middle, inverse

## Gracias!


